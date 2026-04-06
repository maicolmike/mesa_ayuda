# se crea el archivo views.py y se pone esto dentro
from django.http import HttpResponse
from django.shortcuts import render
from django.contrib.auth.decorators import login_required # vista basada en funciones que no permita acceder a paginas donde no se ha logeado
from django.db.models import Count
from requerimientos.models import Requerimiento

@login_required(login_url='login')
def index(request):
    """
    Dashboard principal del sistema
    """

    # 🔹 Total de requerimientos
    total_requerimientos = Requerimiento.objects.count()

    # 🔹 Agrupar por estado (ACTIVO, CERRADO, etc.)
    por_estado = Requerimiento.objects.values('estado').annotate(
        total=Count('id')
    ).order_by('estado')

    # 🔹 Últimos 5 requerimientos (para mostrar en tabla)
    ultimos = Requerimiento.objects.select_related('usuario').order_by('-id')[:5]

    context = {
        'total_requerimientos': total_requerimientos,
        'por_estado': por_estado,
        'ultimos': ultimos,
        'title': "Index",
    }

    return render(request, 'index.html', context)

