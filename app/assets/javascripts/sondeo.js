//CUANDO EN EL SONDEO SELECCIONAMOS LA OPCION NUEVO APARECERA EL FORMULARIO
function selectSondeo (tipo) {
  if (tipo == 'existente') {
    $("#sondeoForm").css("display","none")

  }else {
    $("#sondeoForm").css("display","grid")
    $('#area option[value=""]').attr('selected', true);
    $('#tipo option[value=""]').attr('selected',true);
    $('#linea_negocio option[value=""]').attr('selected',true)
  }
  agregarAlturasidenav()
}
function enviarSondeo(){
  $('.boton-enviar').prop('disabled', true)
  let lista = {}
  lista['area'] = $("#area").val()
  lista['tipo'] =  $("#tipo").val()
  lista['linea_negocio'] =  $("#linea_negocio").val()
  lista['idProspecto'] = $("#idProspecto").val()
  lista['nombre_prospecto'] =  $("#nombre").val()
  lista['descripcion'] =  $("#descripcion").val()
  lista['dirigido'] =  $("#dirigidos").val() // ojo
  lista['presenciales'] =  $("#presenciales").val()
  lista['virtuales'] =  $("#virtuales").val()
  lista['autonomas'] =  $("#autonomas").val()
  $.$.ajax({
    url: '/academico/sondeo',
    type: 'POST',
    dataType: 'json',
    data: lista,
  })
  .done(function() {
    console.log("success");
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });
  $('.boton-enviar').prop('disabled', true)
}

//DAR CLICK AUTOMATICAMENTE A LA OPCION "Sondeo" DEL MENU
function activarProspecto(){
  $('#sondeos').click();
  $('#sondeos').attr('aria-expanded','"true"');
  $("#sondeo").addClass("active in");
  $("#sondeo_li").addClass("active");
}

$(document).ready(function () {
  //CUANDO DETECTA ALGUN CANMBIO
  $('#selectSondeo1').change(function(){
    var sondeo = $(this).val()
    selectSondeo(sondeo)
  });
  $('.container ').change(function(){
    agregarAlturasidenav()
  });
  activarProspecto()
})

