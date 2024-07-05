from django.shortcuts import render,redirect,get_object_or_404
from .forms import LoginUser, RegistroUsuario,CambiarClaveForm,RegistroUsuario1
from django.contrib import messages
from django.contrib.auth import login,logout,authenticate
from django.contrib.auth.decorators import login_required # vista basada en funciones que no permita acceder a paginas donde no se ha logeado
from .models import User
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin # vista basada en clases que no permita acceder a paginas donde no se ha logeado
from django.contrib.auth import update_session_auth_hash
from django.http import JsonResponse
import time # módulo time de Python, es parte de la biblioteca estándar de Python, y contiene la útil función sleep() que suspende o detiene un programa durante un número de determinado de segundos
from django.urls import reverse
# Create your views here.
#Inicio de sesion login
def login_view(request):
    if request.method == 'POST':
        form = LoginUser(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)
                messages.success(request, 'Bienvenido {}'.format(user.username))
                return redirect('index')  # Redirige al usuario a la página de inicio
            else:
                messages.error(request, 'Usuario o contraseña incorrectos')
    else:
        form = LoginUser()  # Crea un formulario vacío si la solicitud no es POST
    
    # Si el usuario ya está autenticado, redirige a la página de inicio
    if request.user.is_authenticated:
        return redirect('index')

    return render(request, 'users/login.html', {
        'title': "Login",
        'form': form
    })
#Cerrar de sesion login
@login_required(login_url='login') 
def logout_view(request):
    logout(request)
    messages.error(request,'Sesion cerrada')
    #messages.success(request,'Sesion cerrada')
    return redirect('login')

#Registrar usuario
@login_required(login_url='login')    
def register(request):
    
    form = RegistroUsuario(request.POST or None)
    
    if request.method == 'POST' and form.is_valid():
        user = form.save() #save () se encuentra en el archivo forms.py
        if user:
            if form.cleaned_data['is_superuser'] == '1': #El campo en el formulario html es 1
                #otorgar permisos de administrador
                user.is_staff = True
                user.is_superuser = True
            user.save()
            messages.success(request, 'usuario creado')
            return redirect('register')
    
    return render(request, 'users/register.html', {
        'form': form,
        'title': "Registro",
        })

#Listar usuarios
@login_required(login_url='login')
def usersList(request):
    #return HttpResponse('Hola mundo')
    lista_usuarios = User.objects.all()
    return render(request, 'users/listUsers.html',{ 
        'title': "Listado Usuarios",
        'lista_usuarios': lista_usuarios,
    })

# esta Clase sirve para listar los usuarios que se obtienen de la vista listar usuarios
# esta asociada a los siguiente template-usuarios-list.html peps-peps-urls.py
# no la estoy utilizando, no esta anexada a ninguna url todavia 
class UsersListView(LoginRequiredMixin,ListView):
    login_url = 'login'
    template_name = 'users/listUsers2.html'
    queryset = User.objects.all().order_by('id')
    #print(queryset)
    paginate_by = 7

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['message'] = 'Listado de Usuarios'
        context['title'] = 'Listado de Usuarios'
        #print(context) # para saber que variable debe tener en este caso son object_list o user_list
        #context['usersList']=context['user_list']
        
        return context
    
@login_required(login_url='login')    
def CambiarClave(request):
    
    form = CambiarClaveForm(request.POST or None)
    if request.method == 'POST' and form.is_valid():
        password_actual = form.cleaned_data['passwordActual']
        password_nueva = form.cleaned_data['passwordNew']
        confirmar_password = form.cleaned_data['passwordNewConfirm']

        # Validar que la contraseña actual sea correcta
        if not request.user.check_password(password_actual):
            messages.error(request, 'La contraseña actual es incorrecta.')
            return render(request, 'users/cambiarClave.html', {'form': form, 'title': 'Cambiar clave'})
        
        # Validar que la contraseña actual sea diferente de la nueva
        if password_actual == password_nueva:
            messages.error(request, 'La nueva contraseña debe ser diferente de la contraseña actual.')
            return render(request, 'users/cambiarClave.html', {'form': form, 'title': 'Cambiar clave'})
        
        # Validar que la nueva contraseña y la confirmación coincidan
        if password_nueva != confirmar_password:
            messages.error(request, 'Las contraseñas no coinciden.')
            return render(request, 'users/cambiarClave.html', {'form': form, 'title': 'Cambiar clave'})

        # Cambiar la contraseña del usuario
        request.user.set_password(password_nueva)   #request.user es específico para interactuar con el usuario que ha iniciado sesión en ese momento, 
        request.user.save()

        # Actualizar la sesión del usuario para evitar cerrar sesión después de cambiar la contraseña
        update_session_auth_hash(request, request.user)

        messages.success(request, 'Contraseña cambiada exitosamente.')

    return render(request, 'users/cambiarClave.html', {'form': form, 'title': 'Cambiar clave'})


# esta funcion sirve para editar los usuarios que se obtienen de la vista listar usuarios
# esta asociada a los siguiente template-usuarios-list.html peps-peps-urls.py      
@login_required(login_url='login')
def UserUdpateView(request):
    AGENCIA_CHOICES = [
        ('MOCOA', 'Mocoa'),
        ('PUERTO ASIS', 'Puerto Asis'),
        ('DORADA', 'Dorada'),
        ('HORMIGA', 'Hormiga'),
        ('ORITO', 'Orito'),
        ('VILLA GARZON', 'Villa Garzon'),
        ('PUERTO LEGUIZAMO', 'Puerto Leguizamo'),
        ('SIBUNDOY', 'Sibundoy'),
    ]
    
    if request.method == 'POST':
        user_id = request.POST.get('id')
        identificacion = request.POST.get('identificacion')
        nombres = request.POST.get('nombres')
        username = request.POST.get('username')
        #agencia = request.POST.get('agencia')
        email = request.POST.get('userEmail')
        tipousuario = request.POST.get('tipousuario')
        
        # Busca el usuario en la base de datos por su ID
        try:
            user = User.objects.get(id=user_id)

            # Verificar si el nuevo nombre de usuario ya existe y no es el del propio usuario
            if User.objects.filter(username=username).exclude(id=user_id).exists():
                messages.error(request, "Error el nombre de usuario ya existe.")
                return redirect('usersList')
            
            # Verificar si identificacion ya existe y no es el del propio usuario
            if User.objects.filter(identificacion=identificacion).exclude(id=user_id).exists():
                messages.error(request, "Error identificacion ya existe.")
                return redirect('usersList')
            
            # Actualiza los campos con los nuevos valores
            user.identificacion = identificacion
            user.nombres = nombres
            user.username = username
            user.email = email
            user.is_superuser = tipousuario

            # Guarda los cambios en la base de datos
            user.save()
            messages.success(request, "Usuario actualizado exitosamente.")

        except User.DoesNotExist:
            messages.error(request, "El usuario no existe.")

        #time.sleep(1.5)  # función para que se demore en redireccionar
        return redirect('usersList')
# esta funcion sirve para actualizar la clave los usuarios que se obtienen de la vista listar usuarios
# esta asociada a los siguiente template-usuarios-list.html peps-peps-urls.py  
@login_required(login_url='login')    
def UserUdpateClave(request):
    
    if request.method == 'POST':
        user_id = request.POST.get('id')
        new_password = request.POST.get('passnew')

        try:
            # Obtén el usuario de la base de datos
            user = User.objects.get(id=user_id) #En contraste, si tuvieras un objeto User específico (por ejemplo, obtenido de una consulta a la base de datos), podrías hacer user.set_password(password_nueva) y user.save() para cambiar la contraseña de ese usuario en particular. Esto podría ser útil en situaciones donde estás trabajando con información específica de un usuario, independientemente de la sesión actual.

            # Establece la nueva contraseña usando set_password()
            user.set_password(new_password)

            # Guarda el usuario, lo que encripta la nueva contraseña
            user.save()
            
            # Actualizar la sesión del usuario para evitar cerrar sesión después de cambiar la contraseña
            update_session_auth_hash(request, user)
            
        except User.DoesNotExist:
            resultado = "El usuario no existe."
            
        time.sleep(1.5) #funcion para que se demore en redireccionar
        return redirect('usersList')
        
    
# esta funcion sirve para eliminar los usuarios que se obtienen de la vista listar usuarios
# esta asociada a los siguiente template-usuarios-list.html peps-peps-urls.py  
@login_required(login_url='login')    
def UserDelete(request):
    if request.method == 'POST':
        user_id = request.POST.get('id')
        
        # Busca el usuario en la base de datos por su ID
        try:
            user = User.objects.get(id=user_id)

            # Elimina el usuario de la base de datos
            user.delete()

        except User.DoesNotExist:
            resultado = "El usuario no existe."

        # Redirecciona a la lista de usuarios después de eliminar
        time.sleep(1.5) #funcion para que se demore en redireccionar
        return redirect('usersList')
    

@login_required(login_url='login')
def crear_usuario(request):
    form = RegistroUsuario1(request.POST or None)

    if request.method == 'POST':
        identificacion = request.POST.get('identificacion', None)

        # Verificar si la identificación ya existe en la base de datos
        if identificacion and User.objects.filter(identificacion=identificacion).exists():
            # Si la identificación ya existe, mostrar un mensaje de error
            messages.error(request, 'La identificación ya está registrada.')
            return render(request, 'users/crearUsuario.html', {'title': "Crear Usuario", 'form': form})

        # Si la identificación no existe, proceder con la validación del formulario
        if form.is_valid():
            user = form.save(commit=False)
            if form.cleaned_data['is_superuser'] == 1:  # 1 representa al administrador
                user.is_staff = True
                user.is_superuser = True
            user.save()

            # Redireccionar a la lista de usuarios o alguna otra página
            messages.success(request, 'Usuario creado con éxito')
            return redirect('crear_usuario')
            #return redirect('usersList')
    
    # Si la solicitud no es POST o el formulario no es válido, mostrar el formulario
    return render(request, 'users/crearUsuario.html', {'title': "Crear Usuario", 'form': form})