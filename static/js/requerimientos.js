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
            { value: 'falla linix', text: 'Falla Linix' },
            { value: 'falla adminweb', text: 'Falla Adminweb' },
            { value: 'falla multiportal', text: 'Falla Multiportal' },
            { value: 'falla convenios', text: 'Falla Convenios' },
            { value: 'falla PEPS', text: 'Falla PEPS' },
            { value: 'equipo lento', text: 'Equipo lento' },
            { value: 'perdida de informacion', text: 'Perdida de información' },
            { value: 'problemas con el sistema operativo', text: 'Problemas con el sistema operativo' },
            { value: 'problemas con aplicaciones especificas', text: 'Problemas con aplicaciones específicas' }
        ],
        'Hardware': [
            { value: '', text: 'Seleccionar' },
            { value: 'falla computadores', text: 'Falla Computadores' },
            { value: 'falla impresoras', text: 'Falla Impresoras' },
            { value: 'falla datafonos', text: 'Falla Datafonos' },
            { value: 'falla UPS', text: 'Falla UPS' },
            { value: 'falla planta electrica', text: 'Falla Planta eléctrica' },
            { value: 'falla aire acondicionado', text: 'Falla Aire acondicionado' },
            { value: 'falla instalaciones electricas', text: 'Falla Instalaciones eléctricas' },
            { value: 'fallas de impresora', text: 'Fallas de impresora' },
            { value: 'problemas con el monitor', text: 'Problemas con el monitor' },
            { value: 'problemas con el teclado/mouse', text: 'Problemas con el teclado/mouse' }
        ],
        'Comunicaciones': [
            { value: '', text: 'Seleccionar' },
            { value: 'falla internet', text: 'Falla Internet' },
            { value: 'falla equipos de comunicacion', text: 'Falla Equipos de comunicación' },
            { value: 'falla conexion remota', text: 'Falla Conexión remota' }
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