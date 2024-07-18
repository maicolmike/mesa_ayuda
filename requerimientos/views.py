from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.mail import send_mail
from .models import Requerimiento, DetalleRequerimiento
from .forms import RequerimientoForm, DetalleRequerimientoForm
from django.contrib import messages
import os
from django.conf import settings
import time 

# Vista para crear un nuevo requerimiento
@login_required  # Requiere que el usuario esté autenticado
def crear_requerimiento(request):
    if request.method == 'POST':  # Si el método de la solicitud es POST
        form = RequerimientoForm(request.POST, request.FILES, user=request.user)  # Crear un formulario con los datos enviados
        if form.is_valid():  # Validar el formulario
            requerimiento = form.save(commit=False)  # Guardar el formulario sin comprometer los datos aún
            requerimiento.usuario = request.user  # Asignar el usuario actual al requerimiento
            requerimiento.save()  # Guardar el requerimiento en la base de datos
            # Enviar correo de notificación aquí (comentado)
            # time.sleep(5.5)  # Función para demorar la redirección (comentado)
            messages.success(request, 'Registro Exitoso!  Su numero de radicado tiquet es: {}'.format(requerimiento.id))  # Mensaje de éxito con el ID del requerimiento
            return redirect('crear_requerimiento')  # Redirigir al usuario a la página de creación de requerimiento
    else:
        form = RequerimientoForm(user=request.user)  # Crear un formulario vacío
    return render(request, 'requerimientos/crear_requerimiento.html', {'title': "Crear requerimiento", 'form': form})  # Renderizar la plantilla con el formulario

# Vista para listar todos los requerimientos
@login_required  # Requiere que el usuario esté autenticado
def listar_requerimientos(request):
    requerimientos = Requerimiento.objects.all().prefetch_related('detalles')  # Obtener todos los requerimientos Prefetch the related details
    return render(request, 'requerimientos/listar_requerimientos.html', {'title': "Listar requerimientos", 'requerimientos': requerimientos})  # Renderizar la plantilla con la lista de requerimientos

# Vista para mostrar los detalles de un requerimiento específico
@login_required  # Requiere que el usuario esté autenticado
def agregar_requerimiento(request, id):
    requerimiento = get_object_or_404(Requerimiento, id=id)  # Obtener el requerimiento o devolver un 404 si no existe
    detalles = requerimiento.detalles.all()  # Obtener todos los detalles del requerimiento

    # Imprimir la ruta del archivo adjunto para depuración
    if requerimiento.adjunto:
        print("Adjunto URL:", requerimiento.adjunto.url)  # Imprimir la URL del adjunto
        print("Adjunto Path:", os.path.join(settings.MEDIA_ROOT, requerimiento.adjunto.name))  # Imprimir la ruta del adjunto

    if request.method == 'POST':  # Si el método de la solicitud es POST
        detalle_form = DetalleRequerimientoForm(request.POST, request.FILES)  # Crear un formulario de detalle con los datos enviados
        if detalle_form.is_valid():  # Validar el formulario de detalle
            detalle = detalle_form.save(commit=False)  # Guardar el formulario sin comprometer los datos aún
            detalle.requerimiento = requerimiento  # Asignar el requerimiento al detalle
            detalle.usuario = request.user  # Asignar el usuario actual al detalle
            detalle.save()  # Guardar el detalle en la base de datos
            messages.success(request, 'Novedad registrada con exitoso')  # Mensaje de éxito
            return redirect('listar_requerimientos')  # Redirigir al usuario a la página de listar_requerimientos
            #return redirect('detalle_requerimiento', id=requerimiento.id)  # Redirigir al usuario a la vista de detalles del requerimiento
    else:
        detalle_form = DetalleRequerimientoForm()  # Crear un formulario de detalle vacío

    return render(request, 'requerimientos/agregarNovedad.html', {
        'title': "Agregar requerimiento",
        'requerimiento': requerimiento,
        'detalles': detalles,
        'detalle_form': detalle_form
    })  # Renderizar la plantilla con el requerimiento, los detalles y el formulario de detalle