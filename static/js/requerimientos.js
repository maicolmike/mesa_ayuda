document.addEventListener('DOMContentLoaded', function () {
    const clasificacion = document.getElementById('clasificacion');
    const subClasificacion = document.getElementById('sub_clasificacion');

    const subClasificaciones = {
        '': [],
        'Software': [
            { value: '', text: 'Seleccionar' },
            { value: 'Problemas con el sistema operativo', text: 'Problemas con el sistema operativo' },
            { value: 'Problemas con aplicaciones específicas', text: 'Problemas con aplicaciones específicas' }
        ],
        'Hardware': [
            { value: '', text: 'Seleccionar' },
            { value: 'Fallas de impresora', text: 'Fallas de impresora' },
            { value: 'Problemas con el monitor', text: 'Problemas con el monitor' },
            { value: 'Problemas con el teclado/mouse', text: 'Problemas con el teclado/mouse' }
        ]
    };

    clasificacion.addEventListener('change', function () {
        const selected = this.value;
        const options = subClasificaciones[selected] || [];
        
        subClasificacion.innerHTML = '';
        subClasificacion.disabled = options.length === 0;

        options.forEach(option => {
            const opt = document.createElement('option');
            opt.value = option.value;
            opt.text = option.text;
            subClasificacion.appendChild(opt);
        });
    });
});