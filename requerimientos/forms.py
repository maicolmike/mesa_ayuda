from django import forms
from .models import Requerimiento, DetalleRequerimiento

class RequerimientoForm(forms.ModelForm):
    class Meta:
        model = Requerimiento
        fields = ['titulo', 'descripcion', 'clasificacion', 'sub_clasificacion', 'adjunto', 'estado']

class DetalleRequerimientoForm(forms.ModelForm):
    class Meta:
        model = DetalleRequerimiento
        fields = ['comentario', 'adjunto']