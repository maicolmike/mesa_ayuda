
(function ()
{

    const btnsEditar = document.querySelectorAll('.btnEditar'); // btnEditar hace referencia a un boton que se le puso una clase de nombre btnEditar
    
    //const csrf_token = document.querySelector("[name='csrf-token']").value;
    
    btnsEditar.forEach((btn) => 
    {
      
        btn.addEventListener('click', function () 
        {
              Swal.fire({
                //position: 'top-end',
                title: 'Excelente',
                //titleText: 'Your work has been saved 2',
                text: 'Los cambios fueron realizados',
                icon: 'success',
                showConfirmButton: true, // si se deja solo true por defecto aparece un boton que dice Ok para personalizarlo hay que utilizar confirmButtonText:
                confirmButtonText: 'Ok',
                timer: 1700
              })
            //confirmarComprar();
        });
    });

})();


/*
Swal.fire(
    'Deleted!',
    'Your file has been deleted.',
    'success'
  )
*/ 

// poner btn1 al id de un boton 
$("#btn1").click(function(){
    alert("prueba");
});