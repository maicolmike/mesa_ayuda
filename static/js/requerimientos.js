document.addEventListener('DOMContentLoaded', function () {
    // Obtener referencias a los elementos del formulario
    const clasificacion = document.getElementById('clasificacion');
    const subClasificacion = document.getElementById('sub_clasificacion');
    const form = document.querySelector('form');

    // Definir las subclasificaciones disponibles para cada clasificación
    const subClasificaciones = {
        '': [],
        'Software': [
            { value: '', text: 'Seleccionar' },
            { value: 'linix', text: 'Linix' },
            { value: 'administrativo visionamos adminweb', text: 'Administrativo visionamos adminweb' },
            { value: 'multiportal', text: 'Multiportal' },
            { value: 'aplicativo convenios', text: 'Aplicativo convenios' },
            { value: 'aplicativo PEPS', text: 'Aplicativo PEPS' },
            { value: 'sistema operativo', text: 'Sistema operativo' },
            { value: 'perdida de informacion', text: 'Perdida de información' },
            { value: 'problemas con aplicaciones especificas', text: 'Problemas con aplicaciones específicas' }
        ],
        'Hardware': [
            { value: '', text: 'Seleccionar' },
            { value: 'computadores', text: 'Computadores' },
            { value: 'impresoras', text: 'Impresoras' },
            { value: 'datafonos', text: 'Datafonos' },
            { value: 'UPS', text: 'UPS' },
            { value: 'planta electrica', text: 'Planta eléctrica' },
            { value: 'aire acondicionado', text: 'Aire acondicionado' },
            { value: 'instalaciones electricas', text: 'Instalaciones eléctricas' },
        ],
        'Comunicaciones': [
            { value: '', text: 'Seleccionar' },
            { value: 'internet', text: 'Internet' },
            { value: 'equipos de comunicacion', text: 'Equipos de comunicación' },
            { value: 'conexion remota data center', text: 'Conexión remota data center' }
        ]
    };

    // Manejar el evento de cambio en el campo de clasificación
    clasificacion.addEventListener('change', function () {
        const selected = this.value;  // Obtener el valor seleccionado
        const options = subClasificaciones[selected] || [];  // Obtener las subclasificaciones correspondientes
        
        subClasificacion.innerHTML = '';  // Limpiar las opciones actuales
        subClasificacion.disabled = false;  // Habilitar el campo de subclasificación

        // Añadir las nuevas opciones de subclasificación
        options.forEach(option => {
            const opt = document.createElement('option');
            opt.value = option.value;
            opt.text = option.text;
            subClasificacion.appendChild(opt);
        });
    });

    // Manejar el evento de envío del formulario
    form.addEventListener('submit', function (event) {
        // Verificar si el campo de subclasificación está vacío
        if (subClasificacion.value === '') {
            event.preventDefault(); // Prevenir el envío del formulario
            alert('Debe seleccionar una subclasificación.'); // Mostrar alerta
            //clasificacion.value = ''; // Resetear el campo de clasificación a "Seleccionar"
        }
    });
});