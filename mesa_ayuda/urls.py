from django.contrib import admin
from django.urls import path
from . import views
from django.urls import include
from users.views import login_view,logout_view,register,usersList,UsersListView,CambiarClave,UserUdpateView,UserUdpateClave,UserDelete,crear_usuario


urlpatterns = [
    path('admin/', admin.site.urls),
    #agregadas por el usuario
    path('',views.index, name='index'),
    #path('users/login',views.login_view, name='login'),
    path('users/login', login_view, name='login'),
    path('users/logout', logout_view, name='logout'),
    path('users/registro',register, name='register'),
    path('users/registro2',crear_usuario, name='crear_usuario'),
    path('users/listadoUsuarios',usersList, name='usersList'),
    path('users/listadoUsuarios2',UsersListView.as_view(), name='listarUsuarios'), # ESTE NO LO ESTOY UTILIZANDO
    path('users/cambiarClave', CambiarClave, name='CambiarClave'),
    path('users/editar', UserUdpateView, name='updateusuarios'),
    path('users/editarClave', UserUdpateClave, name='updateusuariosClave'),
    path('users/eliminarUsuarios', UserDelete, name='deleteusuarios'),
    
]
