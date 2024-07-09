from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.mail import send_mail
from .models import Requerimiento, DetalleRequerimiento
from .forms import RequerimientoForm, DetalleRequerimientoForm

@login_required
def crear_requerimiento(request):
    if request.method == 'POST':
        form = RequerimientoForm(request.POST, request.FILES)
        if form.is_valid():
            requerimiento = form.save(commit=False)
            requerimiento.usuario = request.user
            requerimiento.save()

            return redirect('detalle_requerimiento', id=requerimiento.id)
    else:
        form = RequerimientoForm()
    return render(request, 'requerimientos/crear_requerimiento.html', {'form': form})

@login_required
def detalle_requerimiento(request, id):
    requerimiento = get_object_or_404(Requerimiento, id=id)
    detalles = requerimiento.detalles.all()
    if request.method == 'POST':
        detalle_form = DetalleRequerimientoForm(request.POST, request.FILES)
        if detalle_form.is_valid():
            detalle = detalle_form.save(commit=False)
            detalle.requerimiento = requerimiento
            detalle.usuario = request.user
            detalle.save()

            # Enviar correo electrónico
            

            return redirect('detalle_requerimiento', id=requerimiento.id)
    else:
        detalle_form = DetalleRequerimientoForm()
    return render(request, 'requerimientos/detalle_requerimiento.html', {'requerimiento': requerimiento, 'detalles': detalles, 'detalle_form': detalle_form})