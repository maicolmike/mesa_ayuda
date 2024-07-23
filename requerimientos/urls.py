from django.urls import path
from . import views

#configuracion de los archivos multimedia
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('crear/', views.crear_requerimiento, name='crear_requerimiento'),
    path('listar_requerimientos/', views.listar_requerimientos, name='listar_requerimientos'),
    path('requerimiento/<int:id>/', views.agregar_novedad, name='agregar_novedad'),
    path('detalle_requerimiento/<int:id>/', views.detalle_requerimiento, name='detalle_requerimiento'),
    path('cerrar_requerimiento/<int:id>/', views.cerrar_requerimiento, name='cerrar_requerimiento'),
]#+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)