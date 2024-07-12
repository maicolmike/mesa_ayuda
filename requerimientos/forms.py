from django import forms
from .models import Requerimiento, DetalleRequerimiento

CLASIFICACION_CHOICES = [
    ('', 'Seleccionar'),
    ('Software', 'Software'),
    ('Hardware', 'Hardware'),
]

class RequerimientoForm(forms.ModelForm):
    class Meta:
        model = Requerimiento
        fields = ['titulo', 'descripcion', 'clasificacion', 'sub_clasificacion', 'adjunto', 'estado']
        labels = {
            'titulo': 'Título',
            'descripcion': 'Descripción',
            'clasificacion': 'Clasificación',
            'sub_clasificacion': 'Sub Clasificación',
        }
        widgets = {
            'titulo': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Título', 'id': 'titulo'}),
            'descripcion': forms.Textarea(attrs={'class': 'form-control', 'placeholder': 'Descripción', 'id': 'descripcion'}),
            'clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'clasificacion'}, choices=CLASIFICACION_CHOICES),
            #'sub_clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'sub_clasificacion', 'disabled': 'true'}),
            'sub_clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'sub_clasificacion'}),
            'adjunto': forms.ClearableFileInput(attrs={'class': 'form-control', 'id': 'adjunto'}),
            'estado': forms.Select(attrs={'id': 'estado', 'class': 'form-control'}, choices=[('ACTIVO', 'ACTIVO'), ('CERRADO', 'CERRADO')]),
        }

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)
        super(RequerimientoForm, self).__init__(*args, **kwargs)

        self.fields['estado'].initial = 'ACTIVO'
        if user and not user.is_superuser:
            self.fields['estado'].disabled = True
        
class DetalleRequerimientoForm(forms.ModelForm):
    class Meta:
        model = DetalleRequerimiento
        fields = ['comentario', 'adjunto']
        widgets = {
            'comentario': forms.Textarea(attrs={'class': 'form-control', 'placeholder': 'Comentario'}),
            'adjunto': forms.ClearableFileInput(attrs={'class': 'form-control'}),
        }