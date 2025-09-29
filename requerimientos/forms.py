from django import forms
from .models import Requerimiento, DetalleRequerimiento

# Definición de opciones para el campo de clasificación
CLASIFICACION_CHOICES = [
    ('', 'Seleccionar'),
    ('Software', 'Software'),
    ('Hardware', 'Hardware'),
    ('Comunicaciones', 'Comunicaciones'),
    ('Transaccional', 'Transaccional'),
    ('Solicitud de actualizacion de informacion', 'Solicitud de actualizacion de informacion'),
    ('Solicitud de reportes de informacion', 'Solicitud de reportes de informacion'),
]

# Definición de opciones para el campo de agencia
AGENCIA_CHOICES = [
    ('', 'Seleccionar'),
    ('MOCOA', 'Mocoa'),
    ('PUERTO ASIS', 'Puerto Asis'),
    ('DORADA', 'Dorada'),
    ('HORMIGA', 'Hormiga'),
    ('ORITO', 'Orito'),
    ('VILLA GARZON', 'Villa Garzon'),
    ('PUERTO LEGUIZAMO', 'Puerto Leguizamo'),
    ('SIBUNDOY', 'Sibundoy'),
]

# Definición de opciones para el campo de ESTADO
ESTADO_CHOICES = [
    ('', 'Seleccionar'),
    ('ACTIVO', 'ACTIVO'),
    ('EN TRAMITE', 'EN TRAMITE'),
    ('CERRADO', 'CERRADO'),
]

# Formulario para el modelo Requerimiento
class RequerimientoForm(forms.ModelForm):
    class Meta:
        model = Requerimiento  # Especifica el modelo asociado
        fields = ['titulo', 'descripcion', 'agencia','clasificacion', 'sub_clasificacion', 'adjunto', 'estado']  # Campos a incluir en el formulario
        labels = {
            'titulo': 'Título',
            'descripcion': 'Descripción',
            'agencia': 'Agencia',
            'clasificacion': 'Clasificación',
            'sub_clasificacion': 'Sub Clasificación',
        }
        widgets = {
            'titulo': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Título', 'id': 'titulo'}),  # Widget personalizado para el campo título
            'descripcion': forms.Textarea(attrs={'class': 'form-control', 'placeholder': 'Descripción', 'id': 'descripcion','style': 'resize: none;'}),  # Widget personalizado para el campo descripción
            'agencia': forms.Select(attrs={'class': 'form-control', 'id': 'agencia'}, choices=AGENCIA_CHOICES),
            'clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'clasificacion'}, choices=CLASIFICACION_CHOICES),  # Widget select para el campo clasificación
            'sub_clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'sub_clasificacion'}),  # Widget select para el campo sub clasificación
            'adjunto': forms.ClearableFileInput(attrs={'class': 'form-control', 'id': 'adjunto'}),  # Widget para el campo adjunto
            'estado': forms.HiddenInput(),  # Ocultar el campo estado
            #'estado': forms.Select(attrs={'id': 'estado', 'class': 'form-control','type':'hidden'}, choices=[('ACTIVO', 'ACTIVO'), ('CERRADO', 'CERRADO')]),  # Widget select para el campo estado
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

# Formulario para el modelo EditarRequerimiento
class RequerimientoEditarForm(forms.ModelForm):
    class Meta:
        model = Requerimiento
        fields = ['agencia', 'clasificacion', 'sub_clasificacion', 'estado','usuario']
        widgets = {
            'agencia': forms.Select(attrs={'class': 'form-control', 'id': 'agencia'}, choices=AGENCIA_CHOICES),
            'clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'clasificacion'}, choices=CLASIFICACION_CHOICES),  # Widget select para el campo clasificación
            'sub_clasificacion': forms.Select(attrs={'class': 'form-control', 'id': 'sub_clasificacion'}),  # Widget select para el campo sub clasificación
            'estado': forms.Select(attrs={'class': 'form-control', 'id': 'estado'}, choices=ESTADO_CHOICES),  # Widget select para el campo ESTADO
            'usuario': forms.Select(attrs={'class': 'form-control'}),
        }
