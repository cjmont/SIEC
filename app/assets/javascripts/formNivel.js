// AGREGAR UNIDADES
function agregarUnidades () {
  var divs = '<div class="form-group form-group-lg content_nivel"><div class="unidades col-sm-10">'
  divs = divs + '<input  class="form-control num control-personalizado nivel" " type="hidden" name="ids"  value="">'
  divs = divs + '<input class="form-control num control-personalizado requerido nivel" type="number" placeholder="Unidad" name="numUnidad" min=0 >'
  divs = divs + '<input class="form-control unidadesText control-personalizado requerido nivel" type="text" placeholder="Titulo" name="nombreUnidad">'
  divs = divs + '<input class="form-control numeroHora control-personalizado requerido nivel" type="number" placeholder="Horas" name="numHoraUnidad" min=0>'
  divs = divs + '<button type="button" class="btn btn-success aniadir" data-toggle="tooltip" data-placement="left" title="Añadir subunidad" onClick="agregarSubUnidades(this)"><i class="material-icons">add_circle_outline</i></button>'
  divs = divs + '<button type="button" class="btn btn-danger btn-xs eliminarNivel" onClick="eliminar(this)"><i class="material-icons">delete_forever</i></button>'
  divs = divs + '</div>'
  divs = divs + '<div class="subunidades form-group form-group-lg"></div></div>'
  $('#agregarUnidad').off().click(function (e) {
    $('.espacio').append(divs)
    agregarAlturasidenav ()
  })
  
}
// AGREGAR SUB UNIDADES
function agregarSubUnidades (nombre) {
  var subnivel = '<div class="subnidad col-sm-10">'
  subnivel = subnivel + '<input  class="form-control numSubnidad control-personalizado subnivel" type="hidden" name="subids"  value="">'
  subnivel = subnivel + '<input class="form-control numSubnidad control-personalizado requerido subnivel" type="number" placeholder="SubUnidad" name="numSubUnidad" min=0 >'
  subnivel = subnivel + '<input class="form-control subunidadesText control-personalizado requerido subnivel" type="text" placeholder="Titulo" name="nombreSubUnidad">'
  subnivel = subnivel + '<input class="form-control numeroHorasubunidad control-personalizado requerido subnivel" type="number" placeholder="Horas" name="numHoraSubUnidad" min=0>'
  subnivel = subnivel + '<button type="button" class="btn btn-danger btn-xs eliminarSubNivel" onClick="eliminarSubUnidad(this)"><i class="material-icons">delete_forever</i></button>'
  subnivel = subnivel + '</div>'
  $(nombre).parent('div.unidades').next().append(subnivel)
  agregarAlturasidenav ()
}
// ENVIA Y VERIFICAR EL FORMULARIO
function verificarEnviarUnidad (lista, urlname, salir) {
  var listaUnidad = new Array()
  if ($('.content_nivel').length > 0) {
    if (verificarCampos()) {
      $('#Nivel-form').find('#authenticity_token').each(function () {
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

      lista['idContenido'] = $('#idContenidos').val()
      $('#Nivel-form').find('.content_nivel').each(function () {
        var elemento = this
        unidad = {}

        if ($(elemento).find('.unidades').length > 0) {
          $(elemento).find('.unidades').each(function () {
            $(this).find('.nivel').each(function () {
              var subElementos = this
              if (subElementos.name == 'numUnidad') {
                unidad['numero'] = subElementos.value
              } else if (subElementos.name == 'nombreUnidad') {
                unidad['nombre'] = subElementos.value
              } else if (subElementos.name == 'numHoraUnidad') {
                unidad['hora'] = subElementos.value
              } else if (subElementos.name == 'ids') {
                unidad['id'] = subElementos.value
              }
            })
          })

          if ($(elemento).find('.subnidad').length > 0) {
            subnom = false, subnum = false, subhora = false, subidss = false
            listaSubNivel = new Array()
            $(this).find('.subnivel').each(function () {
              var subElementos = this
              if (subnom == false && subnum == false && subhora == false && subidss == false) {
                subunidad = {}
              }
              if (subElementos.name == 'numSubUnidad' && subnum == false) {
                subunidad['subnumero'] = subElementos.value
                subnum = true
              } else if (subElementos.name == 'nombreSubUnidad' && subnom == false) {
                subunidad['subnombre'] = subElementos.value
                subnom = true
              } else if (subElementos.name == 'numHoraSubUnidad' && subhora == false) {
                subunidad['subhora'] = subElementos.value
                subhora = true
              } else if (subElementos.name == 'subids' && subidss == false) {
                if (subElementos.value == "") {
                  subunidad['ids'] = subElementos.value
                }
                subunidad['ids'] = subElementos.value
                console.log(subElementos.value)
                subidss = true
              }

              if (subnom == true && subnum == true && subhora == true && subidss == true) {
                listaSubNivel.push(subunidad)
                subnom = false, subnum = false, subhora = false, subidss = false
              }
            })

            unidad['subnivel'] = listaSubNivel
          } else {
            unidad['subnivel'] = ''
          }

          listaUnidad.push(unidad)
        }
      })
      lista['unidades'] = listaUnidad

      var list = JSON.parse(JSON.stringify(lista))
      var url = '/academico/prospecto/' + urlname
          $.ajax({
             type: 'POST',
             dataType: 'json',
             url: url,
             data: list,
             success: redireccionar
          })
          $('.btn').prop('disabled', false)
    }
  } else {
    alert('Por favor debe al menos crear un campo para poder enviar la informacion')
  }

  $('.btn').prop('disabled', false)
}
// ELIMINAR CAMPO DE UNIDAD
function eliminar (e) {
  $(e).parent('div.unidades').parent('div.form-group').remove()
  agregarAlturasidenav ()
}
function eliminar (e,ID) {
  setListaEliminados(ID)
  $(e).parent('div.unidades').parent('div.form-group').remove()
  agregarAlturasidenav ()
}
// ELIMINAR LOS CAMPOS DE SUBUNIDAD
function eliminarSubUnidad (e) {
  $(e).parent('div.subnidad').remove()
  agregarAlturasidenav ()
}
function eliminarSubUnidad (e,ID) {
  setListaEliminados(ID)
  $(e).parent('div.subnidad').remove()
  agregarAlturasidenav ()
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
/*************************************************************************/
/*************************************************************************/
//LISTA DE LAS UNIDADES ELIMINADOS PARA PODER DESPUES SER UTILIZADO PARA ENVIARLO JUNTOS CON LOS OTROS DATOS
let listaEliminados = new Array()
//FUNCION PARA RETORNAR EL ARREGLO DE LISTA ELIMINADO
function getlistaEliminados(){
  return listaEliminados
}
//FUNCION PARA AÑADIR DATOS AL ARREGLO DE LISTA ELIMINADO
function setListaEliminados(id){
  listaEliminados.push(id)
}
/*************************************************************************/
/*************************************************************************/
function botonCrear (booleano) {
  let listasUnidad = {}
  $('.btn').prop('disabled', true)
  verificarEnviarUnidad(listasUnidad, 'crearUnidades', booleano)
}
function botonEditar (booleano) {
  let listasUnidad = {}
  $('.btn').prop('disabled', true)
  verificarEnviarUnidad(listasUnidad, 'editarUnidades', booleano)
}
$(document).ready(function () {
  agregarUnidades()
  agregarAlturasidenav ()
})
