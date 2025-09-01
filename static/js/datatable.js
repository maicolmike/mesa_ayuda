$(function () {
  // Inicializar DataTable
  var table = $("#example1").DataTable({
    "responsive": true,
    "lengthChange": false,
    "autoWidth": true,
    "lengthMenu": [10, 25, 100], // Opciones de cantidad de registros por página
    "pageLength": 5,             // Cantidad de registros por defecto
    "order": [[0, "desc"]],      // Ordenar por la columna de fecha (columna 8) descendente
    "language": {                // Traducción al español
      "sProcessing": "Procesando...",
      "sLengthMenu": "Mostrar _MENU_ registros",
      "sZeroRecords": "No se encontraron resultados",
      "sEmptyTable": "Ningún dato disponible en esta tabla",
      "sInfo": "_START_ al _END_ de _TOTAL_ registros",
      "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
      "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
      "sSearch": "Buscar:",
      "sLoadingRecords": "Cargando...",
      "oPaginate": {
        "sFirst": "Primero",
        "sLast": "Último",
        "sNext": "Siguiente",
        "sPrevious": "Anterior"
      },
      "oAria": {
        "sSortAscending": ": Activar para ordenar ascendente",
        "sSortDescending": ": Activar para ordenar descendente"
      }
    },
    // Estructura del DOM: búsqueda arriba, tabla en el medio y paginación abajo
    dom: '<"d-flex justify-content-between align-items-center mb-3"f>rtip'
  });

  // 🔹 Filtro por defecto al cargar: mostrar SOLO "EN TRAMITE" y "ACTIVO"
  table.column(6).search("EN TRAMITE|ACTIVO", true, false).draw();
  $('#estadoFilter').val("ABIERTOS"); // Seleccionar la opción "ABIERTOS" en el select

  // 🔹 Evento de cambio en el select
  $('#estadoFilter').on('change', function () {
    var filtro = $(this).val();

    if (filtro === "ABIERTOS") {
      // Si selecciona "ABIERTOS", filtrar EN TRAMITE o ACTIVO
      table.column(6).search("EN TRAMITE|ACTIVO", true, false).draw();
    } else if (filtro) {
      // Si selecciona otro estado, filtrar exactamente ese estado
      table.column(6).search(filtro, true, false).draw();
    } else {
      // Si selecciona "Todos", quitar filtros
      table.column(6).search('').draw();
    }
  });
});
