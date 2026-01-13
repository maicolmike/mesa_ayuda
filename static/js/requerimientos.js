document.addEventListener('DOMContentLoaded', function () {
    const clasificacion = document.getElementById('clasificacion');
    const subClasificacion = document.getElementById('sub_clasificacion');
    const form = document.querySelector('form');

    // Definir subclasificaciones por clasificación
    const subClasificaciones = {
        '': [],
        'Software': [
            { value: '', text: 'Seleccionar' },
            { value: 'administrativo visionamos adminweb', text: 'Administrativo visionamos adminweb' },
            { value: 'aplicativo convenios', text: 'Aplicativo convenios' },
            { value: 'aplicativo PEPS', text: 'Aplicativo PEPS' },
            { value: 'consulta web', text: 'Consulta web' },
            { value: 'correo electronico institucional', text: 'Correo electronico institucional' },
            { value: 'linix', text: 'Linix' },
            { value: 'multiportal o nueva app red coopcentral', text: 'Multiportal o Nueva App Red Coopcentral' },
            { value: 'pasarela ACH colombian', text: 'Pasarela ACH colombian' },
            { value: 'workmanager', text: 'Workmanager' }, 
        ],
        'Hardware': [
            { value: '', text: 'Seleccionar' },
            { value: 'aire acondicionado', text: 'Aire acondicionado' },
            { value: 'computadores', text: 'Computadores' },
            { value: 'datafonos', text: 'Datafonos' },
            { value: 'DVR', text: 'DVR' },
            { value: 'estabilizadores', text: 'Estabilizadores' },
            { value: 'impresoras y validadoras', text: 'Impresoras y validadoras' },
            { value: 'instalaciones electricas', text: 'Instalaciones eléctricas' },
            { value: 'lector biometrico', text: 'Lector biometrico' },
            { value: 'planta electrica', text: 'Planta eléctrica' },
            { value: 'UPS', text: 'UPS' },
        ],
        'Comunicaciones': [
            { value: '', text: 'Seleccionar' },
            { value: 'conexion remota data center', text: 'Conexión remota data center' },
            { value: 'equipos de comunicacion', text: 'Equipos de comunicación' },
            { value: 'internet', text: 'Internet' },
            { value: 'puntos de red de datos', text: 'Puntos de red de datos' },
        ],
        'Transaccional': [
            { value: '', text: 'Seleccionar' },
            { value: 'cupo rotativo', text: 'Cupo rotativo' },
            { value: 'recaudos PSE', text: 'Recaudos PSE' },
            { value: 'recaudos supergiros', text: 'Recaudos supergiros' },
            { value: 'retiros', text: 'Retiros' },
            { value: 'tarjetas', text: 'Tarjetas' },
            { value: 'transferencias', text: 'Transferencias' },  
        ],
        'Solicitud de actualizacion de informacion': [
            { value: '', text: 'Seleccionar' },
            { value: 'etapas de credito', text: 'Etapas de credito' },
            { value: 'fecha de vencimiento de contrato', text: 'Fecha de vencimiento de contrato' },
            { value: 'ultima fecha de actualizacion de datos (asociados - terceros)', text: 'Ultima fecha de actualizacion de datos (asociados - terceros)' },
            { value: 'creacion nomina por convenio', text: 'Creacion nomina por convenio' },
            { value: 'creacion lugar de nacimiento - lugar de expedicion documento', text: 'Creacion lugar de nacimiento - lugar de expedicion documento' },
        ],
        'Solicitud de reportes de informacion': [
            { value: '', text: 'Seleccionar' },
            { value: 'listado de asociados activos', text: 'Listado de asociados activos' },
            { value: 'listado de asociados actualizados a la fecha', text: 'Listado de asociados actualizados a la fecha' },
            { value: 'listado de asociados afiliados', text: 'Listado de asociados afiliados' },
            { value: 'listado de asociados al dia en pago de obligaciones', text: 'Listado de asociados al dia en pago de obligaciones' },
            { value: 'listado de asociados retirados', text: 'Listado de asociados retirados' },
            { value: 'listado de asociados sin actualizar datos', text: 'Listado de asociados sin actualizar datos' },
            { value: 'listado de asociados sin cancelar aportes', text: 'Listado de asociados sin cancelar aportes' },
        ]
    };

    // 👉 Guardar el valor actual de sub_clasificacion (desde Django)
    const currentSubClasificacion = subClasificacion.dataset.current;


    function cargarSubClasificaciones(selectedClasificacion, selectedSub) {
        const options = subClasificaciones[selectedClasificacion] || [];
        subClasificacion.innerHTML = '';

        options.forEach(option => {
            const opt = document.createElement('option');
            opt.value = option.value;
            opt.text = option.text;

            // 👉 Marcar como seleccionado si coincide con el valor actual
            if (option.value === selectedSub) {
                opt.selected = true;
            }
            subClasificacion.appendChild(opt);
        });
    }

    // Cargar subclasificaciones al iniciar (modo edición)
    cargarSubClasificaciones(clasificacion.value, currentSubClasificacion);

    // Cambiar subclasificaciones al cambiar clasificación
    clasificacion.addEventListener('change', function () {
        cargarSubClasificaciones(this.value, '');
    });

    // Validar antes de enviar
    form.addEventListener('submit', function (event) {
        if (subClasificacion.value === '') {
            event.preventDefault();
            alert('Debe seleccionar una subclasificación.');
        }
    });
});
