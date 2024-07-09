from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from django.contrib import messages

from django.views.generic import DetailView
from .models import PersonaPEP, Familiar
from .forms import CrearPepForm, CrearFamiliaresForm
import time # módulo time de Python, es parte de la biblioteca estándar de Python, y contiene la útil función sleep() que suspende o detiene un programa durante un número de determinado de segundos
from django.db import transaction
from .forms import ConsultarDocumentoForm
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin # vista basada en clases que no permita acceder a paginas donde no se ha logeado


class PersonaPEPDetailView(DetailView):
    model = PersonaPEP
    template_name = 'personasPep/personaPep_detalle.html'
    context_object_name = 'persona'
    paginate_by = 1
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Agrega la información de los familiares al contexto
        familiares = self.object.familiares.all()
        context['familiares'] = familiares
        context['title'] = 'Persona PEP DetailView'
        #print(context)
        return context

@login_required(login_url='login')
def crear_pep(request):
    form = CrearPepForm(request.POST or None)

    if request.method == 'POST':
        identificacion = request.POST.get('identificacion', None)

        # Verificar si la cédula ya existe en la base de datos
        if identificacion and PersonaPEP.objects.filter(identificacion=identificacion).exists():
            # Si la cédula ya existe, mostrar un mensaje de error
            messages.error(request, 'La Persona Pep ya está registrada.')
            return render(request, 'personasPep/crearPep.html', {'title': "Crear pep", 'form': form})

        # Si la cédula no existe, proceder con la validación del formulario
        if form.is_valid():
            # Guardar la nueva Persona PEP
            persona_pep = form.save()
            persona_pep.save()

            # Redireccionar a la creación de familiares
            messages.success(request, 'Persona Pep creada con éxito')
            return redirect(reverse('crear_familiares', kwargs={'persona_pep_id': persona_pep.id}))
    
    # Si la solicitud no es POST o el formulario no es válido, mostrar el formulario
    return render(request, 'personasPep/crearPep.html', {'title': "Crear pep", 'form': form})

@login_required(login_url='login')
def crear_familiares(request, persona_pep_id):
    persona_pep = get_object_or_404(PersonaPEP, id=persona_pep_id)
    familiares = Familiar.objects.filter(persona_pep=persona_pep)
    form = CrearFamiliaresForm(request.POST or None)
    messageListado = request.GET.get('messageListado', None)

    if request.method == 'POST' and form.is_valid():
        familiar = form.save(commit=False)
        familiar.persona_pep = persona_pep
        familiar.save()
        messages.success(request, 'Familiar ha sido creado con éxito')

    context = {
        'title': "Crear Familiares",
        'form': form,
        'persona_pep': persona_pep,
        'familiares': familiares,
        'messageListado': messageListado,
    }

    return render(request, 'personasPep/crearFamiliares.html', context)

@login_required(login_url='login')
def editar_pep(request, pk):
    persona_pep = get_object_or_404(PersonaPEP, pk=pk)
    form = CrearPepForm(request.POST or None, instance=persona_pep)

    if request.method == 'POST' and form.is_valid():
        form.save()
        messages.success(request, 'Persona Pep actualizada con éxito')
        return redirect(reverse('crear_familiares', kwargs={'persona_pep_id': persona_pep.pk}))

    return render(request, 'personasPep/editarPep.html', {'title': 'Editar Pep', 'form': form, 'persona_pep': persona_pep})

@login_required(login_url='login')
def editar_familiar_pep(request, familiar_id):
    familiar = get_object_or_404(Familiar, id=familiar_id)
    persona_pep = familiar.persona_pep
    form = CrearFamiliaresForm(request.POST or None, instance=familiar)

    if request.method == 'POST' and form.is_valid():
        form.save()
        messages.success(request, 'Familiar de Persona Pep actualizada con éxito')
        return redirect('crear_familiares', persona_pep_id=persona_pep.pk)

    return render(request, 'personasPep/editarFamiliarPep.html', {'persona_pep': persona_pep, 'form': form, 'title': 'Editar Familiar Pep'})

@login_required(login_url='login')
def eliminar_familiar_pep(request, familiar_id):
    familiar = get_object_or_404(Familiar, id=familiar_id)
    persona_pep = familiar.persona_pep
    familiar.delete()
    messages.success(request, 'Familiar de Persona Pep eliminado con éxito')
    # Redirecciona a la lista de usuarios después de eliminar
    time.sleep(1.5) #funcion para que se demore en redireccionar
    return redirect('crear_familiares', persona_pep_id=persona_pep.pk) # esta instruccion o la de abajo hacen lo mismo
    return redirect(reverse('crear_familiares', kwargs={'persona_pep_id': persona_pep.pk}))

@login_required(login_url='login')
def eliminar_persona_pep(request, persona_pep_id):
    persona_pep = get_object_or_404(PersonaPEP, id=persona_pep_id)

    try:
        with transaction.atomic():
            # Eliminar todos los familiares asociados
            familiares = Familiar.objects.filter(persona_pep=persona_pep)
            familiares.delete()

            # Eliminar la PersonaPEP
            persona_pep.delete()

            messages.success(request, 'Persona Pep y sus familiares eliminados con éxito')

    except Exception as e:
        messages.error(request, f'Error al eliminar Persona Pep: {str(e)}')
    
    time.sleep(1.5) #funcion para que se demore en redireccionar
    return redirect('crear_pep')  # Ajusta la ruta según tus necesidades

@login_required(login_url='login')
def consultar_pep(request):
    lista_de_asociados_pep = PersonaPEP.objects.all()
    

    if request.method == 'POST':
        documento = request.POST.get('documento', '')
        try:
            # Intenta buscar la Persona PEP por identificación
            persona_encontrada = PersonaPEP.objects.get(identificacion=documento)
            return render(request, 'personasPep/consultarPep.html', {'title': "Consultar pep", 'persona_encontrada': persona_encontrada,'lista_de_asociados_pep': lista_de_asociados_pep})
        except PersonaPEP.DoesNotExist:
            # Si no se encuentra la Persona PEP, busca entre los familiares
            familiares_encontrados = Familiar.objects.filter(identificacion=documento)
            if familiares_encontrados.exists():
                # Si hay familiares encontrados, muestra la información
                return render(request, 'personasPep/consultarPep.html', {'title': "Consultar pep", 'familiares_encontrados': familiares_encontrados,'lista_de_asociados_pep': lista_de_asociados_pep})
            else:
                # Si no se encuentra ninguna coincidencia, muestra un mensaje
                messages.warning(request, 'Documento no encontrado')
                return render(request, 'personasPep/consultarPep.html', {'title': "Consultar pep", 'mensaje': 'Documento no encontrado','lista_de_asociados_pep': lista_de_asociados_pep})
    else:
        # Si la solicitud no es POST, simplemente renderiza el formulario vacío
        return render(request, 'personasPep/consultarPep.html', {'title': "Consultar pep",'lista_de_asociados_pep': lista_de_asociados_pep})
     
@login_required(login_url='login')
def consultar_pep2(request):
    # Obtener la lista de asociados PEP, esto depende de tu modelo y lógica de negocio
    lista_de_asociados_pep = PersonaPEP.objects.all()

    return render(request, 'personasPep/consultarPep2.html', {'title': "Listado asociados pep",'lista_de_asociados_pep': lista_de_asociados_pep})

class PepListView(LoginRequiredMixin,ListView):
    login_url = 'login'
    template_name = 'personasPep/pepListado.html'
    queryset = PersonaPEP.objects.all().order_by('id')
    #print(queryset)
    paginate_by = 7

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['message'] = 'Listado de Asociados pep'
        context['title'] = 'Listado de Asociados pep'
        #print(context) # para saber que variable debe tener en este caso son object_list o user_list
        #context['usersList']=context['user_list']
        
        return context