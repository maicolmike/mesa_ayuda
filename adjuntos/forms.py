from django import forms
#from django.contrib.auth.forms import UserCreationForm
from users.models import User

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
    username = forms.CharField(required=True, min_length=4, max_length=50,label='Usuario',
                               widget=forms.TextInput(attrs={'class': 'form-control',
                                                             'id': 'username',
                                                             'placeholder': 'Username'}))
    email = forms.EmailField(required=True,
                             widget=forms.EmailInput(attrs={'class': 'form-control',
                                                             'id': 'email',
                                                             'placeholder': 'Email'}))
    password = forms.CharField(required=True,
                               widget=forms.PasswordInput(attrs={'class': 'form-control',
                                                             'id': 'password',
                                                             'placeholder': 'Password'}))
    '''password2 = forms.CharField(label= 'Confirmar password',
                                required=True,
                               widget=forms.PasswordInput(attrs={'class': 'form-control',
                                                             'id': 'password',
                                                             'placeholder': 'Password'})) '''
    TIPOS_USUARIO = [
        ('', ''),
        (1, 'Administrador'),
        (2, 'Cliente'),
    ]
    
    is_admin = forms.ChoiceField(label='Tipo de usuario',required=True,choices=TIPOS_USUARIO,
        widget=forms.Select(attrs={'class': 'form-control','id': 'tipousuario'})  # Personaliza el widget aquí
    )
    
    '''
    is_admin = forms.CharField(label='Tipo de usuario',required=True,
        widget=forms.Select(attrs={'class': 'form-control','id': 'tipousuario'},choices=TIPOS_USUARIO)  # Personaliza el widget aquí
    )
    '''
        
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
        self.cleaned_data.get('username'),
        self.cleaned_data.get('email'),
        self.cleaned_data.get('password'),
        )
        
class CambiarClaveForm(forms.Form):
    
    passwordActual = forms.CharField(label= 'Contraseña actual',required=True,
                               widget=forms.PasswordInput(attrs={'class': 'form-control',
                                                             'id': 'password',
                                                             'placeholder': 'Contraseña actual'}))
    passwordNew = forms.CharField(label= 'Contraseña nueva',required=True,
                               widget=forms.PasswordInput(attrs={'class': 'form-control',
                                                             'id': 'passwordNew',
                                                             'placeholder': 'Contraseña nueva'}))
    passwordNewConfirm = forms.CharField(label= 'Confirmar Contraseña',
                                required=True,
                               widget=forms.PasswordInput(attrs={'class': 'form-control',
                                                             'id': 'passwordNewConfirm',
                                                             'placeholder': 'Confirmar contraseña'}))