from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.db.models import Count, Sum, Case, When, IntegerField
from django.contrib.auth import get_user_model
from django.utils.dateparse import parse_date

from requerimientos.models import Requerimiento

User = get_user_model()

@login_required(login_url='login')
def index(request):
    """
    Dashboard principal:
    - Aplica filtros dinámicos
    - Calcula KPIs optimizados
    - Genera datos para gráficas
    """

    # ================================
    # 🔹 1. CAPTURA DE FILTROS (GET)
    # ================================
    fecha_inicio = request.GET.get('fecha_inicio')
    fecha_fin = request.GET.get('fecha_fin')
    usuario_id = request.GET.get('usuario')

    # ================================
    # 🔹 2. QUERY BASE
    # ================================
    requerimientos = Requerimiento.objects.all()

    # ================================
    # 🔹 3. FILTROS DINÁMICOS
    # ================================
    if fecha_inicio:
        requerimientos = requerimientos.filter(
            fecha__date__gte=parse_date(fecha_inicio)
        )

    if fecha_fin:
        requerimientos = requerimientos.filter(
            fecha__date__lte=parse_date(fecha_fin)
        )

    if usuario_id:
        requerimientos = requerimientos.filter(
            usuario_id=usuario_id
        )

    # ================================
    # 🔹 4. KPIs OPTIMIZADOS
    # (UNA SOLA CONSULTA SQL)
    # ================================
    stats = requerimientos.aggregate(
        total=Count('id'),

        activos=Sum(
            Case(When(estado='ACTIVO', then=1),
                 default=0,
                 output_field=IntegerField())
        ),

        cerrados=Sum(
            Case(When(estado='CERRADO', then=1),
                 default=0,
                 output_field=IntegerField())
        ),

        esp_cliente=Sum(
            Case(When(estado='ESPERANDO CLIENTE', then=1),
                 default=0,
                 output_field=IntegerField())
        ),

        esp_soporte=Sum(
            Case(When(estado='ESPERANDO SOPORTE', then=1),
                 default=0,
                 output_field=IntegerField())
        ),
    )

    # ============================================
    # 🔥 5. AGRUPACIÓN CON ORDEN PERSONALIZADO
    # ============================================
    # Aquí controlas EXACTAMENTE el orden de los estados
    por_estado = requerimientos.values('estado').annotate(
        total=Count('id'),

        # 🔹 Creamos un campo artificial llamado "orden"
        orden=Case(
            When(estado='ACTIVO', then=1),

            # 👇 AQUÍ decides el orden manualmente
            When(estado='ESPERANDO CLIENTE', then=2),
            When(estado='ESPERANDO SOPORTE', then=3),
            When(estado='CERRADO', then=4),

            # Cualquier otro estado desconocido
            default=5,
            output_field=IntegerField()
        )

    ).order_by('orden')  # 👈 IMPORTANTE: usamos el orden personalizado

    # ================================
    # 🔹 6. ÚLTIMOS REGISTROS
    # ================================
    ultimos = requerimientos.select_related('usuario').order_by('-id')[:5]

    # ================================
    # 🔹 7. USUARIOS PARA FILTRO
    # ================================
    usuarios = User.objects.all()

    # ================================
    # 🔹 8. CONTEXTO
    # ================================
    context = {
        'total': stats['total'] or 0,
        'activos': stats['activos'] or 0,
        'cerrados': stats['cerrados'] or 0,
        'esperando_cliente': stats['esp_cliente'] or 0,
        'esperando_soporte': stats['esp_soporte'] or 0,
        'por_estado': por_estado,
        'ultimos': ultimos,
        'usuarios': usuarios,
        'fecha_inicio': fecha_inicio,
        'fecha_fin': fecha_fin,
        'usuario_id': usuario_id,
        'title': "Panel de Control Empresarial",
    }

    return render(request, 'index.html', context)