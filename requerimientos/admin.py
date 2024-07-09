from django.contrib import admin

# Register your models here.
from .models import Requerimiento,DetalleRequerimiento

admin.site.register(Requerimiento)
admin.site.register(DetalleRequerimiento)