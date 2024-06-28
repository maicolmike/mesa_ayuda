from django.shortcuts import render,redirect
from .forms import LoginUser
from django.contrib import messages
from django.contrib.auth import login,logout,authenticate
from django.contrib.auth.decorators import login_required # vista basada en funciones que no permita acceder a paginas donde no se ha logeado

# Create your views here.
def login_view(request):
    return render(request, 'users/login.html',{
        'title': "Login",
    })
