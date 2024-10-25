from django.db import models

# Create your models here.

from django.conf import settings

class Requerimiento(models.Model):
    fecha = models.DateTimeField(auto_now_add=True)
    titulo = models.CharField(max_length=255)
    descripcion = models.TextField()
    agencia = models.CharField(max_length=100)
    clasificacion = models.CharField(max_length=100)
    sub_clasificacion = models.CharField(max_length=100)
    adjunto = models.FileField(upload_to='adjuntos/', null=True, blank=True)
    usuario = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    estado = models.CharField(max_length=50)

class DetalleRequerimiento(models.Model):
    requerimiento = models.ForeignKey(Requerimiento, related_name='detalles', on_delete=models.CASCADE)
    comentario = models.TextField()
    fecha = models.DateTimeField(auto_now_add=True)
    usuario = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    adjunto = models.FileField(upload_to='adjuntos/', null=True, blank=True)