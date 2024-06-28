from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    #pass
    #is_admin = models.CharField(max_length=4)
    identificacion = models.CharField(max_length=100, unique=True)
    nombres = models.CharField(max_length=255)
    agencia = models.CharField(max_length=255)