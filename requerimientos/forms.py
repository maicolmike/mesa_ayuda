from django import forms
from .models import Requerimiento, DetalleRequerimiento


class RequerimientoForm(forms.ModelForm):
    class Meta:
        model = Requerimiento
        fields = ['titulo', 'descripcion', 'clasificacion', 'sub_clasificacion', 'adjunto', 'estado']
        labels = {
            'titulo': 'Titulo', 'descripcion': 'Descripcion'
        }
        widgets = {
            'titulo': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Título', 'id': 'titulo'}),
            'descripcion': forms.Textarea(attrs={'class': 'form-control', 'placeholder': 'Descripción', 'id': 'descripcion','style': 'resize: none;'}),
            'clasificacion': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Clasificación', 'id': 'clasificacion'}),
            'sub_clasificacion': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Sub Clasificación', 'id': 'sub_clasificacion'}),
            'adjunto': forms.ClearableFileInput(attrs={'class': 'form-control', 'id': 'adjunto'}),
            'estado': forms.Select(attrs={'id': 'estado', 'class': 'form-control'}, choices=[('ACTIVO', 'ACTIVO'), ('CERRADO', 'CERRADO')]),
        }

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)  # Retrieve the user from kwargs
        super(RequerimientoForm, self).__init__(*args, **kwargs)

        # Set default value for 'estado' and disable it for non-admin users
        self.fields['estado'].initial = 'ACTIVO'
        if user and not user.is_superuser:
            #print("User is not superuser, disabling estado field")
            self.fields['estado'].widget.attrs['disabled'] = 'disabled'

class DetalleRequerimientoForm(forms.ModelForm):
    class Meta:
        model = DetalleRequerimiento
        fields = ['comentario', 'adjunto']