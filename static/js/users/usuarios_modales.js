document.addEventListener("DOMContentLoaded", function () {

  // MODAL EDITAR
  document.querySelectorAll('.btn-editar').forEach(btn => {
    btn.addEventListener("click", () => {

      edit_id.value = btn.dataset.id;
      edit_identificacion.value = btn.dataset.identificacion;
      edit_nombres.value = btn.dataset.nombres;
      edit_username.value = btn.dataset.username;
      edit_email.value = btn.dataset.email;

      edit_superuser.value = btn.dataset.superuser === "True" ? "1" : "0";
      edit_active.value = btn.dataset.active === "True" ? "1" : "0";

      edit_agencia.value = btn.dataset.agencia.trim().toUpperCase();
    });
  });

  // MODAL CLAVE
  document.querySelectorAll('.btn-clave').forEach(btn => {
    btn.addEventListener("click", () => {
      clave_id.value = btn.dataset.id;
    });
  });

  // MODAL ELIMINAR
  document.querySelectorAll('.btn-eliminar').forEach(btn => {
    btn.addEventListener("click", () => {
      delete_id.value = btn.dataset.id;
      delete_username.innerText = btn.dataset.username;
    });
  });

});
