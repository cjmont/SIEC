// FUNCION PARA AGREGAR PERFIL EN DOCENTES
function agregarPerficlesDocente () {
  var divs = '<div class="form-group form-group-lg"><div class="personasDirigido col-sm-10">'
  divs = divs + '<input  class="form-control persona control-personalizado  docente " type="hidden" name="ids"  value="">'
  divs = divs + '<input  class="form-control persona control-personalizado requerido docente " type="text" name="docentes"  placeholder="Conocimiento">'
  divs = divs + '<select id="perfil" class="form-control controlPersonalizadoPerfil  docente requerido"  name="perfil">'
  divs = divs + '<option value="" selected="true" disabled="disabled">Perfil</option><option value="Recomendado" >Recomendado</option><option value="Indispensable" >Indispensable</option></select>'
  divs = divs + '<select id="tipo" class="form-control controlPersonalizado docente requerido"  name="tipo">'
  divs = divs + '<option value="" selected="true" disabled="disabled">Tipo</option><option value="Viñeta" >Viñeta</option><option value="Párrafo" >Párrafo</option></select>'
  divs = divs + '<button type="button" class="btn btn-danger btn-xs eliminarDocente" onClick="eliminarPerfile(this)"><i class="material-icons">delete_forever</i></button>'
  divs = divs + '</div></div>'
  $('#agregarPerfilDocente').off().click(function (e) {
    $('.espacio1').append(divs)
    agregarAlturasidenav ()
  })
  
}
// FUNCION PARA ELIMINAR PERFIL EN DOCENTES REGISTRADOS EN LA BASE DE DATOS
function eliminarPerfiles (nombreDocente, ids) {
  setListaEliminados(ids)
  $(nombreDocente).parent('div.personasDirigido').parent('div.form-group').remove()
  agregarAlturasidenav ()
}
// ELIMINAR PERFIL EN DOCENTES NO REGISTRADOS EN LA BASE DE DATOS
function eliminarPerfile (nombreDocente) {
  $(nombreDocente).parent('div.personasDirigido').parent('div.form-group').remove()
  agregarAlturasidenav ()
}
// FUNCION PARA AGREGAR PERFIL EN ESTUDIANTES
function agregarPerficlesEstudiantes () {
  var divss = '<div class="form-group form-group-lg"><div class="estudiantesDirigido col-sm-10">'
  divss = divss + '<input  class="form-control persona control-personalizado  estudiante " type="hidden" name="ids"  value="">'
  divss = divss + '<input  class="form-control persona control-personalizado requerido estudiante" type="text" name="Estudiante"  placeholder="Conocimiento">'
  divss = divss + '<select id="perfilEstudiante" class="form-control controlPersonalizadoPerfil estudiante requerido"  name="Perfil">'
  divss = divss + '<option value="" selected="true" disabled="disabled">Perfil</option><option value="Recomendado" >Recomendado</option><option value="Indispensable" >Indispensable</option></select>'
  divss = divss + '<select id="tipo" class="form-control controlPersonalizado requerido estudiante"  name="Tipo">'
  divss = divss + '<option value="" selected="true" disabled="disabled">Tipo</option><option value="Viñeta" >Viñeta</option><option value="Párrafo" >Párrafo</option></select>'
  divss = divss + '<button type="button" class="btn btn-danger btn-xs eliminarPerfilesEstudiante" onClick="eliminarPerfilesEstudiantes(this)"><i class="material-icons">delete_forever</i></button>'
  divss = divss + '</div></div>'
  $('#agregarPerfilEstudiante').off().click(function (e) {
    $('.espacio2').append(divss)
    agregarAlturasidenav ()
  })
}
// FUNCION PARA ELIMINAR PERFIL EN ESTUDIANTES REGISTRADOS EN LA BASE DE DATOS
function eliminarPerfilesEstudiante (nombreEstudiante, ids) {
 setListaEliminados(ids)
  $(nombreEstudiante).parent('div.estudiantesDirigido').parent('div.form-group').remove()
  agregarAlturasidenav ()
}
//  FUNCION PARA ELIMINAR PERFIL EN ESTUDIANTES NO REGISTRADOS EN LA BASE DE DATOS
function eliminarPerfilesEstudiantes (nombreEstudiante) {
  $(nombreEstudiante).parent('div.estudiantesDirigido').parent('div.form-group').remove()
  agregarAlturasidenav ()
}

// VERIFICA Y ENVIA EL FORMULARIO DEL DOCENTE
function verificarCampoDocente (lista, urlname, salir) {
  var listasItems = new Array()
  if ($('.persona').length) {
    if (verificarCampos()) {
      lista['salir'] = salir
      $('#contenido1-form').find('#authenticity_token').each(function () {
        var tokens = this
        lista['authenticity_token'] = tokens.value
      })
      lista["curso"] = $("#cursos").val()
      lista['idContenido'] = $('.idContenidos').val()
      $('#contenido1-form').find('.personasDirigido').each(function () {
        var elemento = this
        item = {}
        $(elemento).find('.docente').each(function () {
          var subElementos = this
          if (subElementos.name == 'docentes') {
            item['conocimiento'] = subElementos.value
          } else if (subElementos.name == 'perfil') {
            item['perfil'] = subElementos.value
          } else if (subElementos.name == 'tipo') {
            item['tipo'] = subElementos.value
          } else if (subElementos.name == 'ids') {
            item['id'] = subElementos.value
          }
        })
        listasItems.push(item)
      })
      lista['items'] = listasItems
      if(getlistaEliminados().length != 0){
        lista['eliminados'] = getlistaEliminados()
      }else{
        lista['eliminados'] = ""
      }
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

// VERIFICA Y ENVIA EL FORMULARIO DEL ESTUDIANTE
function verificarCampoEstudiante (lista, urlname, salir) {
  var listasItems = new Array()
  if ($('.persona').length) {
    if (verificarCampos()) {
      lista['salir'] = salir
      lista["curso"] = $("#cursos").val()
      $('#contenido2-form').find('#authenticity_token').each(function () {
        var tokens = this
        lista['authenticity_token'] = tokens.value
      })
      lista['idContenido'] = $('.idContenidos').val()
      $('#contenido2-form').find('.estudiantesDirigido').each(function () {
        var elemento = this
        item = {}
        $(elemento).find('.estudiante').each(function () {
          var subElementos = this
          if (subElementos.name == 'Estudiante') {
            item['conocimiento'] = subElementos.value
          } else if (subElementos.name == 'Perfil') {
            item['perfil'] = subElementos.value
          } else if (subElementos.name == 'Tipo') {
            item['tipo'] = subElementos.value
          } else if (subElementos.name == 'ids') {
            item['id'] = subElementos.value
          }
        })
        listasItems.push(item)
      })
      lista['items'] = listasItems
      if(getlistaEliminados().length != 0){
        lista['eliminados'] = getlistaEliminados()
      }else{
        lista['eliminados'] = ""
      }
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

function botonEditarDocente (booleano) {
  var listasDocente = {}
  $('.btn').prop('disabled', true)
  verificarCampoDocente(listasDocente, 'editarDocente', booleano)
}


function botonCrearDocente (booleano) {
  var listasDocente = {}
  $('.btn').prop('disabled', true)
  verificarCampoDocente(listasDocente, 'crearDocente', booleano)
}


function botonEditarEstudiante (booleano) {
  var listasEstudiante = {}
  $('.btn').prop('disabled', true)
  verificarCampoEstudiante(listasEstudiante, 'editarEstudiante', booleano)
}


function botonCrearEstudiante (booleano) {
  var listasEstudiante = {}
  $('.btn').prop('disabled', true)
  verificarCampoEstudiante(listasEstudiante, 'crearEstudiante', booleano)
}


function redireccionar (data, textStatus, jqXHR) {
  if (data.link != "") {
    window.location.href = data.link
  }else{
    alert(data.mensaje)
    let urls = window.location.href
     window.location.href = urls.replace("crear","editar")
  }
  
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
$(document).ready(function () {
  agregarPerficlesDocente()
  agregarPerficlesEstudiantes()
  agregarAlturasidenav ()
})
