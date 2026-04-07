from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.db.models import Count, Sum, Case, When, IntegerField
from django.contrib.auth import get_user_model
from django.utils.dateparse import parse_date

# Importamos el modelo de requerimientos de tu aplicación
from requerimientos.models import Requerimiento

# Obtenemos el modelo de usuario personalizado que estés usando
User = get_user_model()

@login_required(login_url='login')
def index(request):
    """
    Vista principal del Dashboard.
    Calcula KPIs, genera datos para gráficas y aplica filtros dinámicos
    en una sola consulta eficiente a la base de datos.
    """

    # 1. 🔍 CAPTURA DE FILTROS (Vía parámetros GET de la URL)
    fecha_inicio = request.GET.get('fecha_inicio')
    fecha_fin = request.GET.get('fecha_fin')
    usuario_id = request.GET.get('usuario')

    # Iniciamos el QuerySet base (aún no se ejecuta en la BD)
    requerimientos = Requerimiento.objects.all()

    # 2. 🛠 APLICACIÓN DE FILTROS DINÁMICOS
    # Solo filtramos si el usuario ha enviado valores en el formulario
    if fecha_inicio:
        # __date__gte: Filtra fechas mayores o iguales a la proporcionada
        requerimientos = requerimientos.filter(fecha__date__gte=parse_date(fecha_inicio))

    if fecha_fin:
        # __date__lte: Filtra fechas menores o iguales a la proporcionada
        requerimientos = requerimientos.filter(fecha__date__lte=parse_date(fecha_fin))

    if usuario_id:
        # Filtramos por la llave primaria del usuario seleccionado
        requerimientos = requerimientos.filter(usuario_id=usuario_id)

    # 3. 🚀 KPIs OPTIMIZADOS (Agregación Condicional)
    # En lugar de hacer 5 .count(), hacemos una sola consulta SQL que suma
    # 1 si se cumple la condición, logrando un rendimiento superior.
    stats = requerimientos.aggregate(
        total=Count('id'),
        activos=Sum(Case(When(estado='ACTIVO', then=1), default=0, output_field=IntegerField())),
        cerrados=Sum(Case(When(estado='CERRADO', then=1), default=0, output_field=IntegerField())),
        esp_cliente=Sum(Case(When(estado='ESPERANDO CLIENTE', then=1), default=0, output_field=IntegerField())),
        esp_soporte=Sum(Case(When(estado='ESPERANDO SOPORTE', then=1), default=0, output_field=IntegerField())),
    )

    # 4. 📊 DATOS PARA GRÁFICAS (Agrupamiento)
    # values('estado') actúa como un GROUP BY de SQL.
    # .order_by('estado') garantiza que las barras no cambien de posición al filtrar.
    por_estado = requerimientos.values('estado').annotate(
        total=Count('id')
    ).order_by('estado')

    # 5. 📋 TABLA DE RECIENTES
    # select_related('usuario') realiza un JOIN para obtener los datos del usuario
    # en la misma consulta, evitando el problema de rendimiento N+1.
    ultimos = requerimientos.select_related('usuario').order_by('-id')[:5]

    # 6. 👥 DATOS ADICIONALES PARA EL FORMULARIO
    # Necesitamos todos los usuarios para llenar el <select> del filtro
    usuarios = User.objects.all()

    # 7. 📦 CONTEXTO PARA EL TEMPLATE
    # Usamos 'or 0' para evitar valores None si la base de datos está vacía.
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