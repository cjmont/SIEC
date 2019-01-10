// ENVIA LOS DATOS DE LA INFORMACION MEDIANTE AJAX, SIEMPRE Y CUANDO EL USUARIO HAYA DADO CLICK EN SIGUIENTE
function siguiente (direccion) {
  $('.btn').prop('disabled', true)
  if (verificarCampos()) {
    var url = '/academico/prospecto/contenido/' + direccion
    $.ajax({
      type: 'POST',
      url: url,
      data: $('#contenido1-form').serialize()
    })
  }
  $('.btn').prop('disabled', false)
}


function guardar (direccion,nomSalir) {
  $('.btn').prop('disabled', true)
  if (nomSalir == "salir") {
    $('#contenido1-form').append('<input type="hidden" name="salir" value="salir" readonly>')
  }else{
     $('#contenido1-form').append('<input type="hidden" name="salir" value="guardar" readonly>')
  }
  
  if (verificarCampos()) {
    var url = '/academico/prospecto/contenido/' + direccion
    $.ajax({
      type: 'POST',
      url: url,
      data: $('#contenido1-form').serialize()
    })
  }
  $('.btn').prop('disabled', false)
}


$(document).ready(function(){
  agregarAlturasidenav ()
})