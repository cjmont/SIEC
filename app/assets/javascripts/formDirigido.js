// FUNCION PARA AGREGAR PERFIL EN DOCENTES
function agregarDirigido () {
  var divs = '<div class="form-group form-group-lg"><div class="personasDirigido col-sm-10">'
  divs = divs + '<input  class="form-control persona control-personalizado dirigido " type="hidden" name="idDirigido" value="">'
  divs = divs + '<input  class="form-control persona control-personalizado requerido dirigido " type="text" name="dirigido"  placeholder="Participante">'
  divs = divs + '<select id="tipo" class="form-control controlPersonalizado dirigido requerido"  name="tipo">'
  divs = divs + '<option value="" selected="true" disabled="disabled">Tipo</option><option value="Viñeta" >Viñeta</option><option value="Párrafo" >Párrafo</option></select>'
  divs = divs + '<button type="button" class="btn btn-danger btn-xs eliminarDirigido" onClick="eliminarDirigidos(this)"><i class="material-icons">delete_forever</i></button>'
  divs = divs + '</div></div>'
  $('#agregarDirigido').off().click(function (e) {
    $('.espacio1').append(divs)
     agregarAlturasidenav ()
  })
 
}
//*******************************************************************************
//*******************************************************************************
//LISTA DE LOS PERFILES ELIMINADOS PARA PODER DESPUES SER UTILIZADO PARA ENVIARLO JUNTOS CON LOS OTROS DATOS
let listaEliminados = new Array()
//FUNCION PARA RETORNAR EL ARREGLO DE LISTA ELIMINADO
function getlistaEliminados(){
  return listaEliminados
}
//FUNCION PARA AÑADIR DATOS AL ARREGLO DE LISTA ELIMINADO
function setListaEliminados(id){
  listaEliminados.push(id)
}
//*******************************************************************************
//*******************************************************************************
// FUNCION PARA ELIMINAR DIRIGIDO
function eliminarDirigido (nombreDirigido, id) {
  setListaEliminados(id)
  $(nombreDirigido).parent('div.personasDirigido').parent('div.form-group').remove()
  agregarAlturasidenav ()
}
// ELIMINAR CAMPO NO REGISTRADOS EN LA BASE DE DATOS
function eliminarDirigidos (nombreDirigido) {
  $(nombreDirigido).parent('div.personasDirigido').parent('div.form-group').remove()
  agregarAlturasidenav ()
}
// VERIFICA Y ENVIA EL FORMULARIO
function verificarCampoDirigido (lista, urlname, salir) {
  var listasItems = new Array()
  if ($('.persona').length) {
    if (verificarCampos()) {
      $('#dirigido-form').find('#authenticity_token').each(function () {
        var tokens = this
        lista['authenticity_token'] = tokens.value
        lista['salir'] = salir
        lista["curso"] = $("#cursos").val()
      })
      if ( getlistaEliminados().length > 0) {
        lista['eliminados'] = getlistaEliminados()
      }else {
        lista['eliminados'] = ""
      }
      lista['idContenido'] = $('.idContenidos').val()
      $('#dirigido-form').find('.personasDirigido').each(function () {
        var elemento = this
        item = {}
        $(elemento).find('.dirigido').each(function () {
          var subElementos = this
          if (subElementos.name == 'dirigido') {
            item['dirigido'] = subElementos.value
          } else if (subElementos.name == 'tipo') {
            item['tipo'] = subElementos.value
          } else if (subElementos.name == 'idDirigido') {
          	item['id'] = subElementos.value
          }
        })
        listasItems.push(item)
      })
      lista['items'] = listasItems
      var list = JSON.parse(JSON.stringify(lista))

      var url = '/academico/prospecto/' + urlname
	        $.ajax({
	           type: 'POST',
	           dataType: 'json',
	           url: url,
	           data: list,
             success: redireccionar
	      	})
    }
  } else {
    alert('Por favor debe al menos crear un campo para poder enviar la informacion')
  }
  $('.btn').prop('disabled', false)
}

function botonEditar(booleano) {
  var listasDirigido = {}
  $('.btn').prop('disabled', true)
  verificarCampoDirigido(listasDirigido, 'editarDirigido', booleano)
}

function botonCrear(booleano) {
  var listasDirigido = {}
  $('.btn').prop('disabled', true)
  verificarCampoDirigido(listasDirigido, 'crearDirigido', booleano)
}
function redireccionar (data, textStatus, jqXHR) {
  if (data.linkss != "") {
    window.location.href = data.linkss
  }else{
    alert(data.mensaje)
    let urls = window.location.href
    window.location.href = urls.replace("crear","editar")
  }
}
$(document).ready(function () {
  agregarDirigido()
})

