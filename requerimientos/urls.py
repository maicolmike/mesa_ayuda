from django.urls import path
from . import views

urlpatterns = [
    path('crear/', views.crear_requerimiento, name='crear_requerimiento'),
    path('requerimiento/<int:id>/', views.detalle_requerimiento, name='detalle_requerimiento'),
]