//BOTON SIGUIENTE
function siguiente () {
  if (verificarCampos()) {
    $('#prospecto-form').submit()
  }
   $('.btn').prop('disabled', false)
}
//BUSCA MARCA LOS CAMPOS QUE COINCIDA CON LA BASE DE DATOS EN LA ETIQUETA <select> 
function showSelect (etiqueraId, valor) {
  $(etiqueraId + 'option[value=' + valor + ']').attr('selected', true)
}

$(document).ready(function () {
  //EVENTO SIGUIENTE
  $('#siguiente_prospecto').click(function () {
    $('.btn').prop('disabled', true)
    siguiente()
  })

//BOTON GUARDAR Y SALIR
  $('#salir_Guardar').click(function () {
   	$('.btn').prop('disabled', true)
   	$('#prospecto-form').append('<input type="hidden" name="salir" value="salir" readonly>')
   	siguiente()
  })
  
  //BOTON GUARDAR Y SALIR
  $('#Guardar').click(function () {
    $('.btn').prop('disabled', true)
    $('#prospecto-form').append('<input type="hidden" name="salir" value="guardar" readonly>')
    siguiente()
  })
  showSelect()
  agregarAlturasidenav ()
})
