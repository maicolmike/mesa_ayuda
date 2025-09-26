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
from django.core.mail import EmailMultiAlternatives
from django.utils.html import strip_tags
from django.http import HttpResponseForbidden

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

# Clase que extiende Thread para manejar el envío de correo en segundo plano
class EmailThread2(threading.Thread):
    def __init__(self, email):
        self.email = email
        super().__init__()

    def run(self):
        self.email.send()

# Función para enviar un correo electrónico con soporte para mensajes HTML y texto plano, con saludo personalizado
def send_custom_email(subject, template_name, context, recipient_list, saludo_personalizado):
    # Personaliza el saludo según el destinatario
    if saludo_personalizado:
        saludo = f"Estimado(a) {context['usuario'].nombres}"  # Saludo con el nombre del usuario
        mensaje = "Le informamos que hemos recibido su requerimiento"  # mensaje personalizado
    else:
        saludo = "Estimados colaboradores"  # Saludo genérico para los colaboradores
        mensaje = "Le informamos que se ha recibido un requerimiento"  # mensaje personalizado
    
    # Agregar el saludo al contexto para que esté disponible en la plantilla
    #context['saludo'] = saludo
   # Agregar el saludo y el mensaje al contexto para que estén disponibles en la plantilla
    context.update({
        'saludo': saludo,
        'mensaje': mensaje
    })

    # Renderiza la plantilla HTML usando el contexto proporcionado
    html_message = render_to_string(template_name, context)
    # Convierte el mensaje HTML en texto plano para destinatarios que no puedan ver HTML
    #plain_message = strip_tags(html_message)
    # Dirección de correo del remitente, tomada de la configuración
    #from_email = "servicio de notificación <{}>".format(settings.DEFAULT_FROM_EMAIL)
    
    # Crea un correo electrónico con soporte para texto plano y HTML
    #email = EmailMultiAlternatives(subject, plain_message, from_email, recipient_list)
    # Adjunta la versión HTML del correo
    #email.attach_alternative(html_message, "text/html")
    # Envía el correo
    #email.send()
    # Crear el mensaje de correo electrónico
    email = EmailMessage(
        subject,  # Asunto del correo
        html_message,  # Cuerpo del mensaje (HTML)
        from_email="servicio de notificación <{}>".format(settings.DEFAULT_FROM_EMAIL),  # Remitente personalizado
        to=recipient_list  # Lista de destinatarios
    )
    email.content_subtype = 'html'  # Definir el contenido como HTML

    # Crear una instancia de EmailThread para enviar el correo en segundo plano
    EmailThread2(email).start()

# Vista para crear un nuevo requerimiento
@login_required  # Requiere que el usuario esté autenticado para acceder a la vista
def crear_requerimiento(request):
    if request.method == 'POST':  # Si el método de la solicitud es POST, es decir, el usuario ha enviado el formulario
        form = RequerimientoForm(request.POST, request.FILES, user=request.user)  # Se crea una instancia del formulario con los datos enviados
        if form.is_valid():  # Se valida el formulario para asegurarse de que los datos son correctos
            requerimiento = form.save(commit=False)  # Guarda el formulario sin comprometer los datos aún (para agregar más información)
            requerimiento.usuario = request.user  # Asigna el usuario actual como el creador del requerimiento
            requerimiento.save()  # Guarda finalmente el requerimiento en la base de datos

            # Enviar correo al usuario que creó el requerimiento
            subject_user = "Registro de Requerimiento No. " + str(requerimiento.id)  # Asunto del correo electrónico para el usuario
            template_name_user = "emails/nuevo_requerimiento.html"  # Nombre de la plantilla HTML para el correo
            context_user = {
                'usuario': request.user,  # Contexto para la plantilla que incluye el usuario
                'requerimiento': requerimiento,  # Contexto que incluye el requerimiento recién creado
            }
            recipient_list_user = [request.user.email]  # El destinatario del correo es el usuario que creó el requerimiento
            # Envía el correo electrónico con un saludo personalizado que incluye el nombre del usuario
            send_custom_email(subject_user, template_name_user, context_user, recipient_list_user, saludo_personalizado=True)

            # Enviar correo a los colaboradores
            subject_collaborators = "Nuevo Requerimiento Recibido - No. " + str(requerimiento.id)  # Asunto del correo electrónico para los colaboradores
            template_name_collaborators = "emails/nuevo_requerimiento.html"  # Usamos la misma plantilla HTML
            context_collaborators = {
                #'usuario': None,  # No se pasa un usuario específico ya que el saludo es genérico
                'usuario': request.user,  # Contexto para la plantilla que incluye el usuario
                'requerimiento': requerimiento,  # Contexto que incluye el requerimiento recién creado
            }
            recipient_list_collaborators = ['soportesistemas@cootep.com.co', 'sistemas@cootep.com.co', 'auxsistemas@cootep.com.co']  # Destinatarios del correo para los colaboradores
            # Envía el correo electrónico con un saludo genérico "Estimados colaboradores"
            send_custom_email(subject_collaborators, template_name_collaborators, context_collaborators, recipient_list_collaborators, saludo_personalizado=False)

            # Mostrar un mensaje de éxito al usuario en la interfaz
            messages.success(request, 'Registro Exitoso! Su número de radicado tiquet es: {}'.format(requerimiento.id))
            return redirect('crear_requerimiento')  # Redirige al usuario a la página de creación de requerimiento
    else:
        form = RequerimientoForm(user=request.user)  # Si no es una solicitud POST, se crea un formulario vacío

    # Renderiza la plantilla con el formulario de creación de requerimiento
    return render(request, 'requerimientos/crear_requerimiento.html', {'title': "Crear requerimiento", 'form': form})

# Vista para listar todos los requerimientos
# Vista para listar todos los requerimientos
@login_required
def listar_requerimientos(request):
    # Leer parámetro de la URL (?estado=)
    filtro = request.GET.get("estado")

    # Si no hay filtro seleccionado -> predeterminado "ABIERTOS"
    if filtro is None:  
        filtro = "ABIERTOS"

    # Lógica de filtrado
    if filtro == "ABIERTOS":
        # Mostrar EN TRAMITE o ACTIVO
        requerimientos = Requerimiento.objects.filter(estado__in=["EN TRAMITE", "ACTIVO"])
    elif filtro == "":
        # Mostrar todos
        requerimientos = Requerimiento.objects.all()
    else:
        # Mostrar exactamente el estado elegido
        requerimientos = Requerimiento.objects.filter(estado=filtro)

    return render(request, "requerimientos/listar_requerimientos.html", {
        "title": "Listar requerimientos",
        "requerimientos": requerimientos,
        "usuario": request.user,
        "filtro_actual": filtro,
    })

# Vista para agregar una novedad a un requerimiento
@login_required  # Requiere que el usuario esté autenticado
def agregar_novedad(request, id):
    # Obtener el requerimiento o devolver 404 si no existe
    requerimiento = get_object_or_404(Requerimiento, id=id)

    # --- Validación de permisos ---
    # Solo el superusuario o el dueño del requerimiento pueden agregar novedades
    if not (request.user.is_superuser or request.user == requerimiento.usuario):
        messages.error(request, "No tienes permiso para agregar novedades a este requerimiento.")
        return redirect('listar_requerimientos')

    # Obtener todos los detalles (novedades) del requerimiento
    detalles = requerimiento.detalles.all()

    # --- Bloquear si ya está cerrado ---
    if requerimiento.estado == 'CERRADO':
        messages.error(request, f"El requerimiento {requerimiento.id} ya está cerrado.")
        return redirect('listar_requerimientos')

    # --- Procesamiento del formulario ---
    if request.method == 'POST':
        detalle_form = DetalleRequerimientoForm(request.POST, request.FILES)
        if detalle_form.is_valid():
            # Crear el detalle (novedad) pero aún no lo guardamos en BD
            detalle = detalle_form.save(commit=False)
            detalle.requerimiento = requerimiento
            detalle.usuario = request.user
            detalle.save()  # Guardamos ya con relaciones correctas

            # Inicialización del mensaje adicional para correo
            mensajeNotificacion0 = ""

            # =================================================
            # Manejo de ESTADO del requerimiento
            # =================================================
            if request.user.is_superuser:
                # Caso: el que responde es un superusuario

                # Forzamos el estado a "EN TRÁMITE" de manera defensiva
                # Solo lo actualizamos si es distinto (para no hacer UPDATE innecesario)
                if requerimiento.estado != "EN TRAMITE":
                    requerimiento.estado = "EN TRAMITE"
                    requerimiento.save()

                # Mensajes para correo al cliente
                mensaje = f"Estimado {requerimiento.usuario.nombres},"
                mensajeNotificacion0 = (
                    "nos complace informarle que estamos en proceso de notificarle "
                    "sobre el estado y detalles de su requerimiento."
                )
                mensajeNotificacion = "Se brindó una solución al requerimiento"
                mensajeNotificacion2 = "En espera que cliente confirme solución"

            else:
                # Caso: el que responde es el cliente (no superusuario)

                # Revisamos si ya existe alguna respuesta previa de un superusuario
                hay_respuesta_superusuario = requerimiento.detalles.filter(
                    usuario__is_superuser=True
                ).exists()

                if hay_respuesta_superusuario:
                    # Si ya hubo respuesta de superusuario, el requerimiento
                    # debe estar en "EN TRÁMITE". Si por alguna razón no lo está,
                    # lo corregimos (defensivo + eficiente)
                    if requerimiento.estado != "EN TRAMITE":
                        requerimiento.estado = "EN TRAMITE"
                        requerimiento.save()
                    # Si ya estaba en EN TRAMITE, no hacemos nada (ahorramos UPDATE)
                else:
                    # Si NUNCA ha respondido un superusuario,
                    # dejamos el estado como está (normalmente ACTIVO)
                    pass

                # Mensajes para correo a los colaboradores
                mensaje = "Estimados colaboradores,"
                mensajeNotificacion = "Nueva novedad"
                mensajeNotificacion2 = "Nueva novedad"

            # =================================================
            # Envío de correo de notificación
            # =================================================
            subject = "Nueva novedad en el Requerimiento No. " + str(requerimiento.id)
            template_name = "emails/nueva_novedad.html"
            context = {
                'usuario': request.user,
                'requerimiento': requerimiento,
                'detalle': detalle,
                'mensaje': mensaje,
                'mensajeNotificacion0': mensajeNotificacion0,
                'mensajeNotificacion': mensajeNotificacion,
                'mensajeNotificacion2': mensajeNotificacion2,
            }

            # Lista de destinatarios según quién genera la novedad
            if request.user.is_superuser:
                # Si responde un superusuario → notificar al cliente
                recipient_list = [requerimiento.usuario.email]
            else:
                # Si responde el cliente → notificar al equipo de sistemas
                recipient_list = [
                    'soportesistemas@cootep.com.co',
                    'sistemas@cootep.com.co',
                    'auxsistemas@cootep.com.co',
                ]

            # Enviar el correo electrónico de forma asíncrona
            send_async_mail(subject, template_name, context, recipient_list)

            # Mensaje de éxito para el usuario
            messages.success(request, 'Novedad registrada con éxito')
            return redirect('listar_requerimientos')

    else:
        # Si la solicitud es GET → mostramos formulario vacío
        detalle_form = DetalleRequerimientoForm()

    # Renderizar la plantilla con el formulario y los detalles existentes
    return render(request, 'requerimientos/agregarNovedad.html', {
        'title': "Agregar novedad",
        'requerimiento': requerimiento,
        'detalles': detalles,
        'detalle_form': detalle_form
    })


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
        'usuario': request.user,
    })

@login_required  # 🔒 Solo usuarios autenticados pueden acceder
def cerrar_requerimiento(request, id):
    # Busca el requerimiento por ID o devuelve error 404 si no existe
    requerimiento = get_object_or_404(Requerimiento, id=id)

    # --- Validación de permisos ---
    # Solo puede cerrar: 
    #   1. un superusuario (administrador) 
    #   2. o el mismo usuario que creó el requerimiento
    if not (request.user.is_superuser or request.user == requerimiento.usuario):
        messages.error(request, "No tienes permiso para cerrar este requerimiento.")
        return redirect('listar_requerimientos')

    # --- Verificamos si se hizo una petición POST ---
    if request.method == 'POST':
        # Si el requerimiento ya estaba cerrado, no hacemos nada
        if requerimiento.estado == 'CERRADO':
            messages.error(request, f"El requerimiento {requerimiento.id} ya está cerrado.")
            return redirect('listar_requerimientos')

        # Cambiamos el estado a "CERRADO" y guardamos en BD
        requerimiento.estado = 'CERRADO'
        requerimiento.save()

        # Creamos un registro en la tabla DetalleRequerimiento 
        # (ejemplo: como un historial o bitácora del cierre)
        detalle = DetalleRequerimiento.objects.create(
            requerimiento=requerimiento,
            comentario=request.POST.get('comentario', 'Sin comentarios'),  # comentario opcional
            fecha=timezone.now(),
            usuario=request.user,  # quién cerró el requerimiento
        )

        # =================================================
        # Envío de notificaciones por correo electrónico
        # =================================================
        subject = f"Cierre del Requerimiento No. {requerimiento.id}"  # Asunto del correo
        template_name = "emails/cerrar_requerimiento.html"  # Plantilla HTML usada para el correo

        # --- CASO 1: El que cierra es un ADMIN ---
        if request.user.is_superuser:
            # 📩 Correo al CLIENTE informándole que su caso fue cerrado
            context_cliente = {
                'usuario': requerimiento.usuario,  # destinatario
                'requerimiento': requerimiento,
                'detalle': detalle,
                'mensaje': f"Estimado {requerimiento.usuario.nombres},",
                'mensajeNotificacion0': "nos complace informarle que estamos en proceso de notificarle sobre el estado y detalles de su requerimiento.",
                'mensajeNotificacion': "El requerimiento fue cerrado",
                'mensajeNotificacion2': "Requerimiento cerrado exitosamente",
            }
            send_async_mail(subject, template_name, context_cliente, [requerimiento.usuario.email])

            # 📩 Correo a los ADMINISTRADORES para que sepan quién cerró el caso
            context_admin = {
                'usuario': request.user,  # quién cerró
                'requerimiento': requerimiento,
                'detalle': detalle,
                'mensaje': "Estimados colaboradores,",  # saludo genérico
                'mensajeNotificacion0': "",
                'mensajeNotificacion': f"El requerimiento {requerimiento.id} fue cerrado por {request.user.username}.",
                'mensajeNotificacion2': "Requerimiento cerrado exitosamente",
            }
            recipient_list_admin = [
                'soportesistemas@cootep.com.co',
                'sistemas@cootep.com.co',
                'auxsistemas@cootep.com.co',
            ]
            send_async_mail(subject, template_name, context_admin, recipient_list_admin)

        # --- CASO 2: El que cierra es un CLIENTE ---
        else:
            # 📩 Solo se notifica a los ADMINISTRADORES
            # (para que ellos sepan que el cliente cerró su propio caso)
            context_admin = {
                'usuario': request.user,  # cliente que cerró
                'requerimiento': requerimiento,
                'detalle': detalle,
                'mensaje': "Estimados colaboradores,",  # saludo genérico
                'mensajeNotificacion0': "",
                'mensajeNotificacion': f"El requerimiento {requerimiento.id} fue cerrado por {request.user.username}.",
                'mensajeNotificacion2': "Requerimiento cerrado exitosamente",
            }
            recipient_list_admin = [
                'soportesistemas@cootep.com.co',
                'sistemas@cootep.com.co',
                'auxsistemas@cootep.com.co',
            ]
            send_async_mail(subject, template_name, context_admin, recipient_list_admin)

        # =================================================
        # Mensaje de confirmación en la interfaz web (Django messages)
        # =================================================
        messages.success(request, f"Requerimiento {requerimiento.id} cerrado exitosamente.")
        return redirect('listar_requerimientos')

    else:
        # Si alguien intenta cerrar el caso con GET u otro método → no se permite
        messages.error(request, "Método no permitido.")
        return redirect('listar_requerimientos')
