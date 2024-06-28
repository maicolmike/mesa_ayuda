from django.contrib import admin
from django.urls import path
from . import views
from django.urls import include
from users.views import login_view


urlpatterns = [
    path('admin/', admin.site.urls),
    #agregadas por el usuario
    path('',views.index, name='index'),
    #path('users/login',views.login_view, name='login'),
    path('users/login', login_view, name='login'),
    
]
