from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.db.models import Count, Sum, Case, When, IntegerField
from django.contrib.auth import get_user_model
from datetime import datetime, timedelta
from django.http import JsonResponse

from requerimientos.models import Requerimiento

User = get_user_model()


@login_required(login_url='login')
def index(request):

    # ================================
    # 🔹 1. CAPTURA DE FILTROS
    # ================================
    fecha_inicio = request.GET.get('fecha_inicio')
    fecha_fin = request.GET.get('fecha_fin')
    usuario_id = request.GET.get('usuario')

    clasificacion = request.GET.get('clasificacion')
    sub_clasificacion = request.GET.get('sub_clasificacion')

    # ================================
    # 🔹 2. QUERY BASE
    # ================================
    requerimientos = Requerimiento.objects.all()

    # ================================
    # 🔹 3. FILTROS POR FECHA
    # ================================
    if fecha_inicio:
        try:
            fecha_inicio_dt = datetime.strptime(fecha_inicio, "%Y-%m-%d")
            requerimientos = requerimientos.filter(fecha__gte=fecha_inicio_dt)
        except:
            pass

    if fecha_fin:
        try:
            fecha_fin_dt = datetime.strptime(fecha_fin, "%Y-%m-%d") + timedelta(days=1)
            requerimientos = requerimientos.filter(fecha__lt=fecha_fin_dt)
        except:
            pass

    # ================================
    # 🔹 4. FILTRO USUARIO
    # ================================
    if usuario_id:
        requerimientos = requerimientos.filter(usuario_id=usuario_id)

    # ================================
    # 🔹 5. FILTRO CLASIFICACIÓN
    # ================================
    if clasificacion:
        requerimientos = requerimientos.filter(clasificacion=clasificacion)

    # ================================
    # 🔹 6. FILTRO SUBCLASIFICACIÓN
    # ================================
    if sub_clasificacion:
        requerimientos = requerimientos.filter(sub_clasificacion=sub_clasificacion)

    # ================================
    # 🔹 7. KPIs
    # ================================
    stats = requerimientos.aggregate(
        total=Count('id'),

        activos=Sum(Case(When(estado='ACTIVO', then=1), default=0, output_field=IntegerField())),
        cerrados=Sum(Case(When(estado='CERRADO', then=1), default=0, output_field=IntegerField())),
        esp_cliente=Sum(Case(When(estado='ESPERANDO CLIENTE', then=1), default=0, output_field=IntegerField())),
        esp_soporte=Sum(Case(When(estado='ESPERANDO SOPORTE', then=1), default=0, output_field=IntegerField())),
    )

    # ================================
    # 🔹 8. AGRUPACIÓN POR ESTADO
    # ================================
    por_estado = requerimientos.values('estado').annotate(
        total=Count('id'),
        orden=Case(
            When(estado='ACTIVO', then=1),
            When(estado='ESPERANDO CLIENTE', then=2),
            When(estado='ESPERANDO SOPORTE', then=3),
            When(estado='CERRADO', then=4),
            default=5,
            output_field=IntegerField()
        )
    ).order_by('orden')

    # ================================
    # 🔹 9. ÚLTIMOS REGISTROS
    # ================================
    ultimos = requerimientos.select_related('usuario').order_by('-id')[:5]

    # ================================
    # 🔹 10. LISTAS PARA SELECT
    # ================================
    usuarios = User.objects.all()

    clasificaciones = Requerimiento.objects.values_list(
        'clasificacion', flat=True
    ).distinct()

    # 🔥 CLAVE: subclasificación depende de clasificación
    if clasificacion:
        sub_clasificaciones = Requerimiento.objects.filter(
            clasificacion=clasificacion
        ).values_list('sub_clasificacion', flat=True).distinct()
    else:
        sub_clasificaciones = Requerimiento.objects.values_list(
            'sub_clasificacion', flat=True
        ).distinct()

    # ================================
    # 🔹 11. CONTEXTO
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

        'clasificaciones': clasificaciones,
        'sub_clasificaciones': sub_clasificaciones,
        'clasificacion_sel': clasificacion,
        'sub_clasificacion_sel': sub_clasificacion,

        'fecha_inicio': fecha_inicio,
        'fecha_fin': fecha_fin,
        'usuario_id': usuario_id,
        'title': 'Index',
    }

    return render(request, 'index.html', context)


# ============================================
# 🔹 VISTA AJAX (SEPARADA Y CORRECTA)
# ============================================
def obtener_subclasificaciones(request):

    clasificacion = request.GET.get('clasificacion')

    # 🔹 Filtrar subclasificaciones según clasificación
    sub_clasificaciones = Requerimiento.objects.filter(
        clasificacion=clasificacion
    ).values_list('sub_clasificacion', flat=True).distinct()

    return JsonResponse(list(sub_clasificaciones), safe=False)