
// FUNCION QUE IMPRIME LA TABLA PARA PROSPECTOS
function imprimirProspecto (data, textStatus, jqXHR) {
  $('#table_id_wrapper').remove()
  $('#table_id').remove()

  if (data.prospectos.length > 0) {
    $('#prospecto').append('<table id="table_id" class="table table-striped table-bordered hover"><thead><tr>' +
					      	'<th style="text-align:center;">CODIGO</th>' +
					        '<th style="text-align:center;">NOMBRE</th>' +
					        '<th style="text-align:center;">FECHA MODIFICACION</th>' +
                  '<th style="text-align:center;">TIPO</th>' +
					        '<th style="text-align:center;">ESTADO</th>' +
					        '<th style="text-align:center;">ACCION</th>' +
					      '</tr>' +
					    '</thead>' +
					    '<tbody></tbody></table>')
    for (var i = 0; i < data.prospectos.length; i++) {
      if (data.prospectos[i].estado != "En edicion" && data.prospectos[i].estado != "Publicado" && data.prospectos[i].estado != "Inactivo") {
        $('.table tbody').append("<tr class='prospect'>" +
        "<td style='text-align: center;'>" + data.prospectos[i].id + '</td>' +
        "<td style='width: 31%;'>" + data.prospectos[i].nombre + '</td>' +
        "<td style='text-align:center;''>" + data.prospectos[i].actualizacion + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].tipo + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].estado + '</td>' +
        '<td>' +
        "<button  type='button' class='btn btn-primary ver' onclick='getContenido(" + data.prospectos[i].id + ")' data-toggle=modal data-target=#contenido><i class='material-icons ojo'>visibility</i></button>" +
        "<button  type='button' class='btn btn-success editar' data-toggle=modal data-target=#advertenciaModal onclick='addIdProspectoEditar(" + data.prospectos[i].id + ',' + '"editar",'+'"'+data.prospectos[i].estado+'"'+")' disabled='true'><i class='material-icons'>create</i></button>" +
        "<button type='button' class='btn btn-danger eliminar'><i class='material-icons'>delete_forever</i></button><input type='hidden' id='" + data.prospectos[i].id + "' value='" + data.prospectos[i].id +
        "'/></td></tr>")
      }else if (data.prospectos[i].estado == "Publicado") {
        $('.table tbody').append("<tr class='prospect'>" +
        "<td style='text-align: center;'>" + data.prospectos[i].id + '</td>' +
        "<td style='width: 31%;'>" + data.prospectos[i].nombre + '</td>' +
        "<td style='text-align:center;''>" + data.prospectos[i].actualizacion + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].tipo + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].estado + '</td>' +
        '<td>' +
        "<button  type='button' class='btn btn-primary ver' onclick='getContenido(" + data.prospectos[i].id + ")' data-toggle=modal data-target=#contenido><i class='material-icons ojo'>visibility</i></button>" +
        "<button  type='button' class='btn btn-success editar' data-toggle=modal data-target=#advertenciaModal onclick='addIdProspectoEditar(" + data.prospectos[i].id + ',' + '"editar",'+'"'+data.prospectos[i].estado+'"'+")'><i class='material-icons'>create</i></button>" +
        "<button type='button' class='btn btn-danger eliminar'><i class='material-icons'>delete_forever</i></button><input type='hidden' id='" + data.prospectos[i].id + "' value='" + data.prospectos[i].id +
        "'/></td></tr>")
      }else if (data.prospectos[i].estado == "Inactivo") {
        $('.table tbody').append("<tr class='prospect'>" +
        "<td style='text-align: center;'>" + data.prospectos[i].id + '</td>' +
        "<td style='width: 31%;'>" + data.prospectos[i].nombre + '</td>' +
        "<td style='text-align:center;''>" + data.prospectos[i].actualizacion + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].tipo + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].estado + '</td>' +
        '<td>' +
        "<button  type='button' class='btn btn-primary ver' onclick='getContenido(" + data.prospectos[i].id + ")' data-toggle=modal data-target=#contenido><i class='material-icons ojo'>visibility</i></button>" +
        "<button  type='button' class='btn btn-success editar actualizar'><i class='material-icons'>lock_open</i></button>" +
        "<button type='button' class='btn btn-danger eliminar' disabled='true'><i class='material-icons'>delete_forever</i></button><input type='hidden' id='" + data.prospectos[i].id + "' value='" + data.prospectos[i].id +
        "'/></td></tr>")
      }else{
        $('.table tbody').append("<tr class='prospect'>" +
        "<td style='text-align: center;'>" + data.prospectos[i].id + '</td>' +
        "<td style='width: 31%;'>" + data.prospectos[i].nombre + '</td>' +
        "<td style='text-align:center;''>" + data.prospectos[i].actualizacion + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].tipo + '</td>' +
        "<td style='text-align: center;'>" + data.prospectos[i].estado + '</td>' +
        '<td>' +
        "<button  type='button' class='btn btn-primary ver' onclick='getContenido(" + data.prospectos[i].id + ")' data-toggle=modal data-target=#contenido><i class='material-icons ojo'>visibility</i></button>" +
        "<button  type='button' class='btn btn-success editar' onclick='addIdProspectoEditar(" + data.prospectos[i].id + ',' + '"editar",'+'"'+data.prospectos[i].estado+'"'+")'><i class='material-icons'>create</i></button>" +
        "<button type='button' class='btn btn-danger eliminar'><i class='material-icons'>delete_forever</i></button><input type='hidden' id='" + data.prospectos[i].id + "' value='" + data.prospectos[i].id +
        "'/></td></tr>")
      }
      
    }
  } else {
    agregarAlerta()
  }

// este hace que la tabla se vea como es,  mas informacion aqui -> https://datatables.net/
  var table = $('#table_id').DataTable({
    "responsive": true,
    "stateSave": true,
     "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Spanish.json"
      },
    "lengthMenu": [[5,10, 25, 50], [5,10, 25, 50]]
    

  });

  //FUNCION ELIMINAR
  $('#table_id tbody').on( 'click', '.eliminar', function () {
    var botonEliminar = this
    $(botonEliminar).prop('disabled', true)
    var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
    let datos = {};
    datos["authenticity_token"] = AUTH_TOKEN;
    datos["id"] = $(botonEliminar).parents('tr').children("td").first().html();
    let datosJSON = JSON.parse(JSON.stringify(datos))
    $.ajax({
        type: 'post',
        url: 'eliminar',
        data: datos,
        success: function(json){
          alert(json.mensaje)
          if (json.eliminado == "true") {
            table.row( $(botonEliminar).parents('tr') ).remove().draw();
            
          }
          $(botonEliminar).prop('disabled', false)
        },
        dataType: 'json'
    });

  } );


  //FUNCION CAMBIAR ESTADO
  $('#table_id tbody').on( 'click', '.actualizar', function () {
    let botonActivar = this
    var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
    let datos = {};
    datos["authenticity_token"] = AUTH_TOKEN;
    datos["id"] = $(botonActivar).parents('tr').children("td").first().html();;
    let datosJSON = JSON.parse(JSON.stringify(datos))
    $.ajax({
      url: "activar",
      dataType: "json",
      type: 'post',
      data: datosJSON,
      success: function(jsons){
        alert(jsons.mensaje)
        if (jsons.activado == "true") {
          table.row( $(botonActivar).parents('tr') ).remove().draw();
        }
      }
    })
  } );
}


// ELIMINAR EL CUADRO DE ALERTAS CUANDO HAY DATOS QUE MOSTRAR
function eliminarAlerta () {
  $('.aviso').remove()
}


// AGREGAR ALERTAS PARA CUANDO NO HAY DATOS QUE MOSTRAR
function agregarAlerta () {
  $('#botones').append('<div class="alert alert-danger aviso" style="width:100%;margin-top: 8%;"><strong>No existe datos para mostrar</strong></div>')
}


// OBTENER EL CONTENIDO ESPESIFICO
function getContenido (prospecto_id) {
  $.ajax({
    type: 'GET',
    url: 'academico/ver/' + prospecto_id,
    success: exitoGetContenido,
    dataType: 'json'
  })
}


// PROCESAMIENTO DE DATOS OBTENIDOS
function exitoGetContenido (data, textStatus, jqXHR) {
  eliminarAlerta ()

  // PROSPECTO
  if (data.prospecto != "No existe datos que mostrar") {
    $('#titulo_modal').text(data.prospecto.nombre)
    $('#Linea_negocio').val(data.prospecto.linea_negocio)
    $('#tipo').val(data.prospecto.tipo)
    $('#estados').val(data.prospectoEstado)
  }else{
    $('#Linea_negocio').val(data.prospecto)
    $('#tipo').val(data.prospecto)
    $('#estados').val(data.prospectoEstado)
  }
  
  // CONTENIDO
  if (data.contenidos != "No existe datos que mostrar") {
    $('#modalidad').val(data.contenidos.modalidad)
    $('#certificado').val(data.contenidos.certificado)
    $('#horaPresencial').val(data.contenidos.horas_presenciales)
    $('#horaAutonoma').val(data.contenidos.horas_autonomas)
    $('#justificacion').val(data.contenidos.justificacion)
    $('#objetivo').val(data.contenidos.objetivo)
    $('#objetivoEspecifico').val(data.contenidos.objetivo_especifico)
    $('#metodologia').val(data.contenidos.metodologia)
    $('#descripcion').val(data.contenidos.descripcion)
    $('#estadoContenido').val(data.estadoContenido)
    $('#version').val(data.contenidos.version)
    $('#precio').val(data.contenidos.precio)
  }else{
    $('#modalidad').val(data.contenidos)
    $('#certificado').val(data.contenidos)
    $('#horaPresencial').val(data.contenidos)
    $('#horaAutonoma').val(data.contenidos)
    $('#justificacion').val(data.contenidos)
    $('#objetivo').val(data.contenidos)
    $('#objetivoEspecifico').val(data.contenidos)
    $('#metodologia').val(data.contenidos)
    $('#descripcion').val(data.contenidos)
    $('#estadoContenido').val(data.estadoContenido)
    $('#version').val(data.contenidos)
    $('#precio').val(data.contenidos)
  }
  

  // DIRIGIDO
  $('#dirigidosModal ol').remove()
  let tamañoDirigido = data.dirigido.length
  if (tamañoDirigido == 0) {
    $('#dirigidosModal').append('<div class="alert alert-danger aviso" style="width:100%;"><strong>No existe datos para mostrar</strong></div>')
  }else{
    $('#dirigidosModal').append("<ol></ol>")
    let num = 0;
    for (let i = 0; i < tamañoDirigido; i++) {
      num = i + 1;
      $('#dirigidosModal ol').append('<li '+num+'><textarea type="text" class="form-control" readonly>'+ data.dirigido[i].texto +'</textarea></li>')
    }
  }

// Perfil Estudiante
  $('#perfilEstudiante').find('ol').each(function () {
    this.remove()
  })
  let tamañoEstudiante = data.perfilEstudiante.length
  if (tamañoEstudiante == 0) {
    $('#perfilEstudiante').append('<div class="alert alert-danger aviso" style="width:100%;"><strong>No existe datos para mostrar</strong></div>')
  }else{
    $('#perfilEstudiante').append("<ol></ol>")
    let num = 0;
    for (let i = 0; i < tamañoEstudiante; i++) {
      num = i + 1;
      $('#perfilEstudiante ol').append('<li value="'+num+'"><textarea type="text" class="form-control" readonly>'+ data.perfilEstudiante[i].texto +'</textarea></li>')
    }
  }

// Perfil Docente
  $('#perfilDocente').find('ol').each(function () {
    this.remove()
  })
  let tamañoDocente = data.perfilDocente.length
  if (tamañoDocente == 0) {
    $('#perfilDocente').append('<div class="alert alert-danger aviso" style="width:100%;"><strong>No existe datos para mostrar</strong></div>')
  }else{
    $('#perfilDocente').append("<ol></ol>")
    let num = 0;
    for (let i = 0; i < tamañoDocente; i++) {
      num = i + 1;
      $('#perfilDocente ol').append('<li '+num+'><textarea type="text" class="form-control" readonly>' + data.perfilDocente[i].texto + '</textarea></li>')
    }
  }
}


// AGREGAR ID Y TIPO PARA EDITAR
function addIdProspectoEditar (prospecto_id, tipo,estado) {
  if (estado == "En edicion") {
     window.location.href = 'academico/prospecto/' + tipo + '/' + prospecto_id
   }else{
      $('#modalSi').click(function(){
        window.location.href = 'academico/prospecto/' + tipo + '/' + prospecto_id
      });
   }
 
}



//DAR CLICK AUTOMATICAMENTE A LA OPCION "Prospecto" DEL MENU
function activarProspecto(){
  $('#prospectos').click();
  $('#prospectos').attr('aria-expanded','"true"');
  $("#prospecto").addClass("active in");
  $("#prospecto_li").addClass("active");
}


$(document).ready(function () {
  //CUANDO SE DA CLICK EN EL BOTON PROSPECTO
  $('#prospectos').click(function () {
    $('#botones-t').click()
  })

  // CUANDO SE DA CLICK EN EL BOTON "TODO"
  $('#botones-t').click(function () {
    eliminarAlerta()
    $('.table tbody').html('')
    $('.botton').removeClass('active')
    $(this).addClass('active')
    $.getJSON('/getProspecto', imprimirProspecto)
  })

  // CUANDO SE DA CLICK EN EL BOTON "EN EDICION"
  $('#botones-e').click(function () {
    eliminarAlerta()
    $('.table tbody').html('')
    $('.botton').removeClass('active')
    $(this).addClass('active')
    $.getJSON('/getEnEdicion', imprimirProspecto)
  })

  // CUANDO SE DA CLICK EN EL BOTON "POR APROBAR"
  $('#botones-pap').click(function () {
    eliminarAlerta()
    $('.table tbody').html('')
    $('.botton').removeClass('active')
    $(this).addClass('active')
    $.getJSON('/getPorAprobar', imprimirProspecto)
  })

  // CUANDO SE DA CLICK EN EL BOTON "APROBADO"
  $('#botones-a').click(function () {
    eliminarAlerta()
    $('.table tbody').html('')
    $('.botton').removeClass('active')
    $(this).addClass('active')
    $.getJSON('/getPublicado', imprimirProspecto)
  })

  // CUANDO SE DA CLICK EN EL BOTON "APROBADO"
  $('#botones-ap').click(function () {
    eliminarAlerta()
    $('.table tbody').html('')
    $('.botton').removeClass('active')
    $(this).addClass('active')
    $.getJSON('/getAprobado', imprimirProspecto)
  })

  // CUANDO SE DA CLICK EN EL BOTON "INACTIVO"
  $('#botones-ina').click(function () {
    eliminarAlerta()
    $('.table tbody').html('')
    $('.botton').removeClass('active')
    $(this).addClass('active')
    $.getJSON('/getInactivo', imprimirProspecto)
  })
  
  $('.container ').change(function(){
    agregarAlturasidenav()
  });

  activarProspecto();

})
