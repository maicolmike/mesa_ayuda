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
from django.http import JsonResponse
from django.utils import timezone
#para el envio de correos
import threading
from django.core.mail import EmailMessage
from django.template.loader import render_to_string



# Clase que hereda de threading.Thread para enviar correos en segundo plano
class EmailThread(threading.Thread):
    def __init__(self, subject, template_name, context, recipient_list):
        # Inicializa los atributos de la clase con los parámetros proporcionados
        self.subject = subject
        self.template_name = template_name
        self.context = context
        self.recipient_list = recipient_list
        threading.Thread.__init__(self)  # Llama al inicializador de la clase base

    def run(self):
        # Renderiza la plantilla HTML con el contexto proporcionado
        html_message = render_to_string(self.template_name, self.context)
        # Crea el mensaje de correo electrónico
        email = EmailMessage(
            self.subject,  # Asunto del correo
            html_message,  # Contenido del correo en formato HTML
            #settings.DEFAULT_FROM_EMAIL,  # Dirección de correo del remitente
            #self.recipient_list  # Lista de destinatarios
            from_email="servicio de notificación <{}>".format(settings.DEFAULT_FROM_EMAIL),
            to=self.recipient_list
            
        )
        email.content_subtype = 'html'  # Establece el subtipo de contenido a 'html'
        email.send()  # Envía el correo electrónico

# Función para iniciar el envío del correo en un hilo separado
def send_async_mail(subject, template_name, context, recipient_list):
    EmailThread(subject, template_name, context, recipient_list).start()

# Vista para crear un nuevo requerimiento
@login_required  # Requiere que el usuario esté autenticado
def crear_requerimiento(request):
    if request.method == 'POST':  # Si el método de la solicitud es POST
        form = RequerimientoForm(request.POST, request.FILES, user=request.user)  # Crear un formulario con los datos enviados
        if form.is_valid():  # Validar el formulario
            requerimiento = form.save(commit=False)  # Guardar el formulario sin comprometer los datos aún
            requerimiento.usuario = request.user  # Asignar el usuario actual al requerimiento
            requerimiento.save()  # Guardar el requerimiento en la base de datos
            #form.save_m2m()  # Guardar las relaciones ManyToMany del formulario

            # Enviar correo electrónico
            subject = "Registro de Requerimiento No. " + str(requerimiento.id)  # Crear el asunto del correo con el ID del requerimiento
            template_name = "emails/nuevo_requerimiento.html"  # Plantilla HTML para el correo
            context = {  # Contexto para renderizar la plantilla
                'usuario': request.user,
                'requerimiento': requerimiento,
            }
            recipient_list = ['maicol.yela@gmail.com', 'maicol-yela@hotmail.com']  # Lista de destinatarios del correo
            send_async_mail(subject, template_name, context, recipient_list)  # Enviar el correo en segundo plano

            # Mostrar un mensaje de éxito al usuario con el ID del requerimiento
            messages.success(request, 'Registro Exitoso! Su numero de radicado tiquet es: {}'.format(requerimiento.id))
            return redirect('crear_requerimiento')  # Redirigir al usuario a la página de creación de requerimiento
    else:
        form = RequerimientoForm(user=request.user)  # Crear un formulario vacío

    # Renderizar la plantilla con el formulario
    return render(request, 'requerimientos/crear_requerimiento.html', {'title': "Crear requerimiento", 'form': form})

# Vista para listar todos los requerimientos
@login_required  # Requiere que el usuario esté autenticado
def listar_requerimientos(request):
    requerimientos = Requerimiento.objects.all().prefetch_related('detalles')  # Obtener todos los requerimientos Prefetch the related details
    return render(request, 'requerimientos/listar_requerimientos.html', {'title': "Listar requerimientos", 'requerimientos': requerimientos,'usuario': request.user})  # Renderizar la plantilla con la lista de requerimientos

# Vista para agregar una novedad a un requerimiento
@login_required  # Requiere que el usuario esté autenticado
def agregar_novedad(request, id):
    requerimiento = get_object_or_404(Requerimiento, id=id)  # Obtener el requerimiento o devolver un 404 si no existe
    detalles = requerimiento.detalles.all()  # Obtener todos los detalles del requerimiento

    print(request.user.is_superuser)
    print(requerimiento.usuario.email)

    # Imprimir la ruta del archivo adjunto para depuración
    if requerimiento.adjunto:
        print("Adjunto URL:", requerimiento.adjunto.url)  # Imprimir la URL del adjunto
        print("Adjunto Path:", os.path.join(settings.MEDIA_ROOT, requerimiento.adjunto.name))  # Imprimir la ruta del adjunto

    if requerimiento.estado == 'CERRADO':
            messages.error(request, f"El requerimiento {requerimiento.id} ya está cerrado.")
            return redirect('listar_requerimientos')

    if request.method == 'POST':  # Si el método de la solicitud es POST
        detalle_form = DetalleRequerimientoForm(request.POST, request.FILES)  # Crear un formulario de detalle con los datos enviados
        if detalle_form.is_valid():  # Validar el formulario de detalle
            detalle = detalle_form.save(commit=False)  # Guardar el formulario sin comprometer los datos aún
            detalle.requerimiento = requerimiento  # Asignar el requerimiento al detalle
            detalle.usuario = request.user  # Asignar el usuario actual al detalle
            detalle.save()  # Guardar el detalle en la base de datos

            # Define el mensaje basado en el usuario
            if request.user.is_superuser:
                mensaje = f"Estimado {requerimiento.usuario.nombres}, nos complace informarle que estamos en proceso de notificarle sobre el estado y detalles de su requerimiento."
                mensajeNotificacion = "Se brindó una solución al requerimiento"
                mensajeNotificacion2 = "En espera que cliente confirme solución"
            else:
                mensaje = "Estimados colaboradores,"
                mensajeNotificacion = "Nueva novedad"
                mensajeNotificacion2 = "Nueva novedad"

            # Enviar correo electrónico
            subject = "Nueva novedad en el Requerimiento No. " + str(requerimiento.id)  # Crear el asunto del correo con el ID del requerimiento
            template_name = "emails/nueva_novedad.html"  # Plantilla HTML para el correo
            context = {  # Contexto para renderizar la plantilla
                'usuario': request.user,
                'requerimiento': requerimiento,
                'detalle': detalle,
                'mensaje': mensaje,
                'mensajeNotificacion': mensajeNotificacion,
                'mensajeNotificacion2': mensajeNotificacion2,
            }

            # Definir la lista de destinatarios en base al tipo de usuario
            if request.user.is_superuser:
                recipient_list = [requerimiento.usuario.email]
            else:
                recipient_list = ['maicol.yela@gmail.com', 'maicol-yela@hotmail.com']

            # Enviar el correo electrónico de manera asíncrona
            send_async_mail(subject, template_name, context, recipient_list)

            messages.success(request, 'Novedad registrada con éxito')  # Mensaje de éxito
            return redirect('listar_requerimientos')  # Redirigir al usuario a la página de listar_requerimientos
            #return redirect('detalle_requerimiento', id=requerimiento.id)  # Redirigir al usuario a la vista de detalles del requerimiento
    else:
        detalle_form = DetalleRequerimientoForm()  # Crear un formulario de detalle vacío

    return render(request, 'requerimientos/agregarNovedad.html', {
        'title': "Agregar novedad",
        'requerimiento': requerimiento,
        'detalles': detalles,
        'detalle_form': detalle_form
    })  # Renderizar la plantilla con el requerimiento, los detalles y el formulario de detalle

# Vista para mostrar los detalles de un requerimiento específico
@login_required  # Requiere que el usuario esté autenticado
def detalle_requerimiento(request, id):
    # Obtener el requerimiento específico o devolver un error 404 si no existe
    requerimiento = get_object_or_404(Requerimiento, id=id)
    
    # Obtener todos los detalles asociados al requerimiento
    detalles = requerimiento.detalles.all()

    # Imprimir la ruta del archivo adjunto para depuración, si existe
    if requerimiento.adjunto:
        print("Adjunto URL:", requerimiento.adjunto.url)
        print("Adjunto Path:", os.path.join(settings.MEDIA_ROOT, requerimiento.adjunto.name))

    if request.method == 'POST':  # Si la solicitud es un POST (es decir, se envió un formulario)
        detalle_form = DetalleRequerimientoForm(request.POST, request.FILES)  # Crear un formulario de detalle con los datos recibidos
        if detalle_form.is_valid():  # Si el formulario es válido según las reglas definidas en forms.py
            detalle = detalle_form.save(commit=False)  # Guardar el formulario sin comprometer los datos en la base de datos todavía
            detalle.requerimiento = requerimiento  # Asignar el requerimiento actual al detalle
            detalle.usuario = request.user  # Asignar el usuario actual al detalle
            detalle.save()  # Guardar el detalle en la base de datos
            messages.success(request, 'Novedad registrada con éxito')  # Mostrar un mensaje de éxito al usuario
            return redirect('detalle_requerimiento', id=requerimiento.id)  # Redirigir al usuario a la página de detalles del requerimiento actualizado
    else:
        detalle_form = DetalleRequerimientoForm()  # Crear un formulario de detalle vacío si la solicitud no es un POST

    # Renderizar la plantilla 'detalleRequerimiento.html' con los siguientes contextos
    return render(request, 'requerimientos/detalleRequerimiento.html', {
        'title': "Detalle Requerimiento",  # Título de la página
        'requerimiento': requerimiento,  # Objeto del requerimiento actual
        'detalles': detalles,  # QuerySet de detalles asociados al requerimiento
        'detalle_form': detalle_form,  # Formulario para agregar nuevos detalles
    })

@login_required
def cerrar_requerimiento(request, id):
    if request.method == 'POST':
        requerimiento = get_object_or_404(Requerimiento, id=id)
        
        if requerimiento.estado == 'CERRADO':
            messages.error(request, f"El requerimiento {requerimiento.id} ya está cerrado.")
            return redirect('listar_requerimientos')

        requerimiento.estado = 'CERRADO'
        requerimiento.save()

        detalle = DetalleRequerimiento.objects.create(
            requerimiento=requerimiento,
            comentario="El requerimiento fue cerrado.",
            fecha=timezone.now(),
            usuario=request.user,
        )

        # Define el mensaje
        mensaje = f"Estimado {requerimiento.usuario.nombres}, nos complace informarle que estamos en proceso de notificarle sobre el estado y detalles de su requerimiento."
        mensajeNotificacion = "El requerimiento fue cerrado"
        mensajeNotificacion2 = "Requerimiento cerrado exitosamente"

        # Enviar correo electrónico
        subject = f"Cierre del Requerimiento No. {requerimiento.id}"
        template_name = "emails/cerrar_requerimiento.html"
        context = {
            'usuario': request.user,
            'requerimiento': requerimiento,
            'detalle': detalle,
            'mensaje': mensaje,
            'mensajeNotificacion': mensajeNotificacion,
            'mensajeNotificacion2': mensajeNotificacion2,
        }

        # Definir la lista de destinatarios
        recipient_list = [requerimiento.usuario.email]
        
        # Enviar el correo electrónico de manera asíncrona
        send_async_mail(subject, template_name, context, recipient_list)

        messages.success(request, f"Requerimiento {requerimiento.id} cerrado exitosamente.")
        return redirect('listar_requerimientos')
    else:
        messages.error(request, "Método no permitido.")
        return redirect('listar_requerimientos')