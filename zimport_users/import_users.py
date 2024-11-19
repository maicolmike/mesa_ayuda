# Importar módulos necesarios para la ejecución del script
import os  # Para configurar variables de entorno del sistema
import django  # Para interactuar con el framework Django
from django.contrib.auth.hashers import make_password  # Para encriptar contraseñas
import csv  # Para trabajar con archivos CSV
import sys # proporciona acceso a funciones y variables específicas del intérprete de Python. 

# Configurar el entorno de Django
# Añade el directorio raíz del proyecto al PYTHONPATH
sys.path.append('/home/cootep/Documents/programacion/mesa_ayuda') #Verifica que el módulo mesa_ayuda sea accesible

# Establece la configuración del proyecto Django. Cambia 'mesa_ayuda.settings' al nombre de tu configuración.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mesa_ayuda.settings')  
django.setup()  # Inicializa el entorno de Django para usar sus modelos y funcionalidades

# Importar el modelo de usuario
# Cambia 'users.models' al nombre de tu aplicación y asegúrate de que 'User' sea el modelo correcto.
from users.models import User  

# Especificar la ruta del archivo CSV
# Reemplaza con la ubicación del archivo CSV que deseas importar. Asegúrate de que la ruta sea correcta.
file_path = '/home/cootep/Documents/programacion/mesa_ayuda/zimport_users/users20241118.csv'

# Función principal para importar usuarios desde un archivo CSV
def import_users_from_csv():
    # Abrir el archivo CSV en modo de lectura
    # `newline=''` asegura que las líneas se procesen correctamente.
    # `encoding='utf-8'` garantiza que los caracteres especiales (acentos, etc.) se lean correctamente.
    with open(file_path, newline='', encoding='utf-8') as csvfile:
        # Crear un lector de archivos CSV que interprete los datos como un diccionario
        reader = csv.DictReader(csvfile)
        
        # Iterar sobre cada fila del archivo CSV
        for row in reader:
            # Leer los valores del archivo CSV basados en los nombres de las columnas
            username = row['username']  # Nombre de usuario único
            email = row['email']  # Dirección de correo electrónico
            identificacion = row['identificacion']  # Identificación única del usuario
            nombres = row['nombres']  # Nombre completo del usuario
            agencia = row['agencia']  # Agencia a la que pertenece el usuario
            
            # Crear una instancia del modelo User con los datos leídos del archivo
            user = User(
                username=username,  # Asigna el nombre de usuario
                email=email,  # Asigna el correo electrónico
                identificacion=identificacion,  # Asigna la identificación
                nombres=nombres,  # Asigna el nombre completo
                agencia=agencia,  # Asigna la agencia
                is_active=True  # Marca al usuario como activo por defecto
            )
            
            # Generar y asignar una contraseña encriptada basada en el nombre de usuario
            # `make_password` se utiliza para generar un hash seguro de la contraseña
            user.password = make_password(username)
            
            # Guardar el usuario en la base de datos
            user.save()
            
            # Imprimir un mensaje en la consola para confirmar la creación del usuario
            print(f"Usuario {username} creado exitosamente")

# Ejecutar la función para importar usuarios desde el archivo CSV
import_users_from_csv()
