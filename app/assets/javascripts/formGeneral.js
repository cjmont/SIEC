//REDIRECCIONA AL LINK ASIGNADO
function atras(links){
	var mensaje;
    var opcion = confirm("¿Desea regresar sin guardar?");
    if (opcion == true) {
        window.location.href = links
	} 
}
// VERIFICA SI LOS CAMPOS ESTA VACIO O NO
function verificarCampos () {
  var bool = true
  $('.requerido').each(function () {
    if ($(this).val() == '' || $(this).val() == null) {
      $(this).addClass('vacio')
      bool = false
    }else{
      $(this).removeClass('vacio')
    }
  })
  if (!bool) { alert('Por favor llene los campos obligatorios.') }
  return bool
}
// AGREGANDO LA ALTURA PARA EL SIDENAV, ESTO VA CAMBIANDO DE ACUERDO COMO VA CAMBIANDO LA ALTURA DEL contenedor
function agregarAlturasidenav () {
  let alturaTabla = $('.tab-content').height()
  let alturaSidenav = $('.sidenav').height()
  if (  alturaTabla > "597" ) {
    $('.sidenav').css({'height': alturaTabla + 62})
  }else{
    $('.sidenav').css({'height': 597})
  }
  
}