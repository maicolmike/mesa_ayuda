from django import forms
from .models import Requerimiento, DetalleRequerimiento

# Definición de opciones para el campo de clasificación
CLASIFICACION_CHOICES = [
    ('', 'Seleccionar'),
    ('Software', 'Software'),
    ('Hardware', 'Hardware'),
    ('Comunicaciones', 'Comunicaciones'),
]

# Formulario para el modelo Requerimiento
class RequerimientoForm(forms.ModelForm):
    class Meta:
        model = Requerimiento  # Especifica el modelo asociado
        fields = ['titulo', 'descripcion', 'clasificacion', 'sub_clasificacion', 'adjunto', 'estado']  # Campos a incluir en el formulario
        labels = {
            'titulo': 'Título',
            'descripcion': 'Descripción',
            'clasificacion': 'Clasificación',
            'sub_clasificacion': 'Sub Clasificación',
        }
        widgets = {
            'titulo': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Título', 'id': 'titulo'}),  # Widget personalizado para el campo título
            'descripcion': forms.Textarea(attrs={'class': 'form-control', 'placeholder': 'Descripción', 'id': 'descripcion','style': 'resize: none;'}),  # Widget personalizado para el campo descripción
            'clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'clasificacion'}, choices=CLASIFICACION_CHOICES),  # Widget select para el campo clasificación
            'sub_clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'sub_clasificacion'}),  # Widget select para el campo sub clasificación
            'adjunto': forms.ClearableFileInput(attrs={'class': 'form-control', 'id': 'adjunto'}),  # Widget para el campo adjunto
            'estado': forms.Select(attrs={'id': 'estado', 'class': 'form-control'}, choices=[('ACTIVO', 'ACTIVO'), ('CERRADO', 'CERRADO')]),  # Widget select para el campo estado
        }

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)  # Extrae el argumento user de kwargs
        super(RequerimientoForm, self).__init__(*args, **kwargs)

        self.fields['estado'].initial = 'ACTIVO'  # Establece el valor inicial del campo estado
        if user and not user.is_superuser:  # Si el usuario no es un superusuario
            self.fields['estado'].disabled = True  # Deshabilita el campo estado

# Formulario para el modelo DetalleRequerimiento
class DetalleRequerimientoForm(forms.ModelForm):
    class Meta:
        model = DetalleRequerimiento  # Especifica el modelo asociado
        fields = ['comentario', 'adjunto']  # Campos a incluir en el formulario
        widgets = {
            'comentario': forms.Textarea(attrs={'class': 'form-control', 'placeholder': 'Comentario','style': 'resize: none;'}),  # Widget personalizado para el campo comentario
            'adjunto': forms.ClearableFileInput(attrs={'class': 'form-control'}),  # Widget para el campo adjunto
        }