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
            { value: 'adminweb', text: 'Adminweb' },
            { value: 'multiportal', text: 'Multiportal' },
            { value: 'convenios', text: 'Convenios' },
            { value: 'PEPS', text: 'PEPS' },
            { value: 'equipo lento', text: 'Equipo lento' },
            { value: 'perdida de informacion', text: 'Perdida de información' },
            { value: 'problemas con el sistema operativo', text: 'Problemas con el sistema operativo' },
            { value: 'problemas con aplicaciones especificas', text: 'Problemas con aplicaciones específicas' }
        ],
        'Hardware': [
            { value: '', text: 'Seleccionar' },
            { value: 'computadores', text: 'Computadores' },
            { value: 'impresoras', text: 'Impresoras' },
            { value: 'datafonos', text: 'Datafonos' },
            { value: 'UPS', text: 'UPS' },
            { value: 'Planta electrica', text: 'Planta eléctrica' },
            { value: 'aire acondicionado', text: 'Aire acondicionado' },
            { value: 'instalaciones electricas', text: 'Instalaciones eléctricas' },
            { value: 'Fallas de impresora', text: 'Fallas de impresora' },
            { value: 'Problemas con el monitor', text: 'Problemas con el monitor' },
            { value: 'Problemas con el teclado/mouse', text: 'Problemas con el teclado/mouse' }
        ],
        'Comunicaciones': [
            { value: '', text: 'Seleccionar' },
            { value: 'internet', text: 'Internet' },
            { value: 'equipos de comunicacion', text: 'Equipos de comunicación' },
            { value: 'conexion remota', text: 'Conexión remota' }
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