from django.contrib import admin
from django.urls import path
from . import views
from django.urls import include
from users.views import login_view,logout_view,register,usersList,UsersListView,CambiarClave,UserUpdateView,UserUdpateClave,UserDelete,crear_usuario,editar_usuario
from django.conf import settings
from django.conf.urls.static import static
from django.conf.urls import handler404
from django.shortcuts import render


urlpatterns = [
    path('admin/', admin.site.urls),
    #agregadas por el usuario
    path('',views.index, name='index'),
    #path('users/login',views.login_view, name='login'),
    path('users/login', login_view, name='login'),
    path('users/logout', logout_view, name='logout'),
    path('users/registro',register, name='register'),
    path('users/listadoUsuarios',usersList, name='usersList'),
    path('users/cambiarClave', CambiarClave, name='CambiarClave'),
    path('users/editar', UserUpdateView, name='updateusuarios'),
    path('users/editarClave', UserUdpateClave, name='updateusuariosClave'),
    path('users/eliminarUsuarios', UserDelete, name='deleteusuarios'),
    path('requerimientos/', include('requerimientos.urls')),

    path('users/registro2',crear_usuario, name='crear_usuario'),
    path('users/editar/<int:user_id>/',editar_usuario, name='editar_usuario'),  
    path('users/listadoUsuarios2',UsersListView.as_view(), name='listarUsuarios'), # ESTE NO LO ESTOY UTILIZANDO
]
# para que reconozca los archivos media adjuntos
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
#configurar error 404
def custom_404(request, exception):
    return render(request, 'errors/404.html', {}, status=404)

handler404 = custom_404