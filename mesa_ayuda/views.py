# se crea el archivo views.py y se pone esto dentro
from django.http import HttpResponse
from django.shortcuts import render
from django.contrib.auth.decorators import login_required # vista basada en funciones que no permita acceder a paginas donde no se ha logeado
from django.db.models import Count
from requerimientos.models import Requerimiento
from django.contrib.auth import get_user_model
from django.utils.dateparse import parse_date

User = get_user_model()

@login_required(login_url='login')
def index(request):
    """
    Dashboard empresarial con filtros y KPIs
    """

    # 🔹 FILTROS
    fecha_inicio = request.GET.get('fecha_inicio')
    fecha_fin = request.GET.get('fecha_fin')
    usuario_id = request.GET.get('usuario')

    requerimientos = Requerimiento.objects.all()

    # Filtro por fecha
    if fecha_inicio:
        requerimientos = requerimientos.filter(fecha__date__gte=parse_date(fecha_inicio))

    if fecha_fin:
        requerimientos = requerimientos.filter(fecha__date__lte=parse_date(fecha_fin))

    # Filtro por usuario
    if usuario_id:
        requerimientos = requerimientos.filter(usuario_id=usuario_id)

    # 🔹 KPIs
    total = requerimientos.count()
    cerrados = requerimientos.filter(estado="CERRADO").count()
    activos = requerimientos.filter(estado="ACTIVO").count()
    esperando_cliente = requerimientos.filter(estado="ESPERANDO CLIENTE").count()
    esperando_soporte = requerimientos.filter(estado="ESPERANDO SOPORTE").count()

    # 🔹 AGRUPADO POR ESTADO
    por_estado = requerimientos.values('estado').annotate(total=Count('id'))

   

    # 🔹 ÚLTIMOS
    ultimos = requerimientos.select_related('usuario').order_by('-id')[:5]

    # 🔹 USUARIOS PARA FILTRO
    usuarios = User.objects.all()

    context = {
        'total': total,
        'cerrados': cerrados,
        'activos': activos,
        'esperando_cliente': esperando_cliente,
        'esperando_soporte': esperando_soporte,
        'por_estado': por_estado,
        'ultimos': ultimos,
        'usuarios': usuarios,
        'fecha_inicio': fecha_inicio,
        'fecha_fin': fecha_fin,
        'usuario_id': usuario_id,
        'title': "Index",
    }
    

    return render(request, 'index.html', context)

