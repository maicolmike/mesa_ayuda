from django.forms import ModelForm
from .models import PersonaPEP,Familiar
from django import forms


'''
class CrearPepForm(ModelForm):
    class Meta:
        model = PersonaPEP
        fields = [
            'nombre', 'identificacion', 'es_pep', 'estado', 'tipo_pep', 'cargo', 'fecha_vinculacion', 'fecha_desvinculacion', 'cuentas_extranjeras', 'fecha_registro_pep', 'fecha_actualizacion'
        ]
        labels = {
            'nombre': 'Nombres y apellidos'
        }
        
        
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.fields['nombre'].widget.attrs.update({
            'class': 'form-control',
            'placeholder': 'Nombre'
        }) #Dic
        
'''       

class CrearPepForm(ModelForm):
    class Meta:
        model = PersonaPEP
        fields = [
            'nombre', 'identificacion', 'es_pep', 'estado', 'tipo_pep', 'cargo', 'fecha_vinculacion', 'fecha_desvinculacion', 'cuentas_extranjeras', 'fecha_registro_pep', 'fecha_actualizacion'
        ]
        labels = {
            'nombre': 'Nombres','cuentas_extranjeras': 'Maneja cuentas en el extranjero'
        }
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control mb-2 mr-sm-2', 'placeholder': 'Nombre','id': 'nombre'}),
            'identificacion': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Identificacion','id': 'identificacion'}),
            'estado': forms.Select(attrs={'id': 'estado','class': 'form-control'}, choices=[('', 'Seleccionar'), ('Asociado', 'Asociado'), ('No asociado', 'No asociado'), ('Retirado', 'Retirado')]),
            'tipo_pep': forms.Select(attrs={'id': 'tipo_pep','class': 'form-control'}, choices=[('', 'Seleccionar'), ('Maneja recursos publicos nacionales', 'Maneja recursos públicos nacionales'), ('Maneja recursos publicos exterior', 'Maneja recursos públicos exterior'), ('Funcion publica prominente', 'Función pública prominente'), ('Reconocimiento Publico', 'Reconocimiento Público')]),
            'cargo': forms.TextInput(attrs={'id': 'cargo','class': 'form-control', 'placeholder': 'cargo'}),
            'fecha_vinculacion': forms.DateInput(attrs={'id': 'fecha_vinculacion','class': 'form-control datepicker', 'placeholder': 'Fecha de vinculación'}),
            'fecha_desvinculacion': forms.DateInput(attrs={'id': 'fecha_desvinculacion','class': 'form-control datepicker', 'placeholder': 'Fecha de desvinculación'}),
            'fecha_registro_pep': forms.DateInput(attrs={'id': 'fecha_registro_pep','class': 'form-control datepicker', 'placeholder': 'Fecha de registro pep'}),
            'fecha_actualizacion': forms.DateInput(attrs={'id': 'fecha_actualizacion','class': 'form-control datepicker', 'placeholder': 'Fecha de actualizacion'}),
            'es_pep': forms.RadioSelect(attrs={'id': 'es_pep','class': ''}, choices=[('Si', 'Sí'), ('No', 'No')]),
            #'es_pep': forms.CheckboxInput(attrs={'class': 'form-check-input', 'id': 'es_pep'}),
            'cuentas_extranjeras': forms.RadioSelect(attrs={'id': 'cuentas_extranjeras','class': ''}, choices=[('Si', 'Sí'), ('No', 'No')]),
            #'cuentas_extranjeras': forms.CheckboxInput(attrs={'class': 'form-check-input', 'id': 'cuentas_extranjeras'}),
        }
        #usuario no se repita y no genere error
        ''' def clean_username(self):
            identificacion = self.cleaned_data.get('identificacion')
            
            if PersonaPEP.objects.filter(identificacion=identificacion).exists() :
                raise forms.ValidationError("el asociado pep ya se encuentra creado")
            
            return identificacion '''
        
class CrearFamiliaresForm(ModelForm):
    class Meta:
        model = Familiar
        fields = [
            'nombre', 'identificacion','parentesco','estado'
        ]
        labels = {
            'nombre': 'Nombres'
        }
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control mb-2 mr-sm-2', 'placeholder': 'Nombre y apellidos','id': 'nombre'}),
            'identificacion': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Identificacion','id': 'identificacion'}),
            'parentesco': forms.Select(attrs={'id': 'parentesco','class': 'form-control'}, 
                                       choices=[('', 'Seleccionar parentesco'), ('Hijos (as)', 'Hijos (as)'), ('Hijos (as) adoptivos', 'Hijos (as) adoptivos'), ('Padres o madres', 'Padres o madres'), ('Padres adoptantes o madres adoptantes', 'Padres adoptantes o madres adoptantes'), ('Suegros (as)', 'Suegros (as)'), ('Yernos o nueras', 'Yernos o nueras'), ('Abuelos (as)', 'Abuelos (as)'), ('Hermanos (as)', 'Hermanos (as)'), ('Nietos (as)', 'Nietos (as)')]),
            'estado': forms.Select(attrs={'id': 'estado','class': 'form-control'}, choices=[('', 'Seleccionar estado'), ('Asociado', 'Asociado'), ('No asociado', 'No asociado'), ('Retirado', 'Retirado')]),
        }
        
class ConsultarDocumentoForm(forms.Form):
    numero_documento = forms.CharField(max_length=20, label='Número de Documento')