from django import forms
#from django.contrib.auth.forms import UserCreationForm
from .models import User

class LoginUser(forms.Form):
    username = forms.CharField(required=True, min_length=4, max_length=50,label='Usuario',
                               widget=forms.TextInput(attrs={'class': 'form-control',
                                                             'id': 'username',
                                                             'placeholder': 'Usuario'}))
    password = forms.CharField(required=True,label='Contraseña',
                               widget=forms.PasswordInput(attrs={'class': 'form-control',
                                                             'id': 'password',
                                                             'placeholder': 'Password'}))
    
class RegistroUsuario(forms.Form):
    
    identificacion = forms.CharField(required=True, min_length=4, max_length=50,label='identificacion',
                               widget=forms.TextInput(attrs={'class': 'form-control',
                                                             'id': 'identificacion',
                                                             'placeholder': 'identificacion'}))
    
    nombres = forms.CharField(required=True, min_length=4, max_length=50,label='nombres',
                               widget=forms.TextInput(attrs={'class': 'form-control',
                                                             'id': 'identificacion',
                                                             'placeholder': 'nombres'}))
    
    username = forms.CharField(required=True, min_length=4, max_length=50,label='Usuario',
                               widget=forms.TextInput(attrs={'class': 'form-control',
                                                             'id': 'username',
                                                             'placeholder': 'Username'}))
    password = forms.CharField(required=True,
                               widget=forms.PasswordInput(attrs={'class': 'form-control',
                                                             'id': 'password',
                                                             'placeholder': 'Password'}))
    AGENCIA_CHOICES = [
    ('', ''),
    ('MOCOA', 'Mocoa'),
    ('PUERTO ASIS', 'Puerto Asis'),
    ('DORADA', 'Dorada'),
    ('HORMIGA', 'Hormiga'),
    ('ORITO', 'Orito'),
    ('VILLA GARZON', 'Villa Garzon'),
    ('PUERTO LEGUIZAMO', 'Puerto Leguizamo'),
    ('SIBUNDOY', 'Sibundoy'),
]
    agencia = forms.ChoiceField(choices=AGENCIA_CHOICES, required=True, label='agencia',
                                widget=forms.Select(attrs={'class': 'form-control',
                                                           'id': 'agencia',
                                                           'placeholder': 'agencia'}))
    
    email = forms.EmailField(required=True,
                             widget=forms.EmailInput(attrs={'class': 'form-control',
                                                             'id': 'email',
                                                             'placeholder': 'Email'}))
    
    TIPOS_USUARIO = [
        ('', ''),
        (1, 'Administrador'),
        (2, 'Cliente'),
    ]
    
    is_admin = forms.ChoiceField(label='Tipo de usuario',required=True,choices=TIPOS_USUARIO,
        widget=forms.Select(attrs={'class': 'form-control','id': 'tipousuario'})  # Personaliza el widget aquí
    )
        
    #usuario no se repita y no genere error
    def clean_username(self):
        username = self.cleaned_data.get('username')
        
        if User.objects.filter(username=username).exists() :
            raise forms.ValidationError("el usuario ya se encuentra creado")
        
        return username
    
    #se sobreescribe el metodo clean solo si debemos validar una condicion que dependa de otra
    # En esta hacemos que password sea igual que password2
    '''def clean(self):
        cleaned_data = super().clean()
        
        if cleaned_data.get('password2') != cleaned_data.get('password'):
            self.add_error('password2', 'Las contraseñas no coinciden')  '''
    
    #Guardar  
    def save(self):
        return User.objects.create_user(
        self.cleaned_data.get('identificacion'),
        self.cleaned_data.get('nombres'),
        self.cleaned_data.get('username'),
        self.cleaned_data.get('password'),
        #self.cleaned_data.get('agencia'),
        self.cleaned_data.get('email'),
        
        )