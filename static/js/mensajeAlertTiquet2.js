document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('requerimiento-form');

  form.addEventListener('submit', function(event) {
      event.preventDefault(); // Previene el envío normal del formulario

      const formData = new FormData(form);

      fetch(form.action, {
          method: 'POST',
          body: formData,
          headers: {
              'X-Requested-With': 'XMLHttpRequest'
          }
      })
      .then(response => response.json())
      .then(data => {
          if (data.success) {
              Swal.fire({
                  title: 'Excelente',
                  text: 'El tiquet es: ' + data.id,
                  icon: 'success',
                  showConfirmButton: true,
                  confirmButtonText: 'Ok'
              }).then((result) => {
                  if (result.isConfirmed) {
                      window.location.reload(); // Recarga la página solo cuando se haga clic en "Ok"
                  }
              });
          } else {
              // Maneja los errores de validación aquí
              let errorMessages = '';
              for (const [field, errors] of Object.entries(data.errors)) {
                  errorMessages += `${field}: ${errors.join(', ')}\n`;
              }
              Swal.fire({
                  title: 'Error',
                  text: errorMessages,
                  icon: 'error',
                  showConfirmButton: true,
                  confirmButtonText: 'Ok'
              });
          }
      })
      .catch(error => {
          console.error('Error:', error);
          Swal.fire({
              title: 'Error',
              text: 'Ocurrió un error al enviar el formulario.',
              icon: 'error',
              showConfirmButton: true,
              confirmButtonText: 'Ok'
          });
      });
  });
});