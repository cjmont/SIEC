
//FUNCION PARA AGREGAR CURSO NUEVO
function crearCurso(){
		var divs = '<div class="form-group form-group-lg"><div class="programa col-sm-10" style="display: inline-flex;margin-bottom:1%">';
		divs = divs + '<input id="" class="form-control  control-programa cursoNuevo requerido" name="campo-programa" type="text"  placeholder="Nombre de Curso" >';
		divs = divs + '<button type="button" class="btn btn-danger btn-xs eliminarPrograma" onClick="eliminarCursos(this)"><i class="material-icons">highlight_off</i></button>';
		divs = divs + '</div></div>';
	   $(".espacio3").append(divs);
     agregarAlturasidenav ()
}


//FUNCION PARA AGREGAR CURSO EXISTENTES
function agregarCurso(nombre,id){
  var divs = '<div class="form-group form-group-lg"><div class="programa col-sm-10" style="display: inline-flex;margin-bottom:1%">';
  divs = divs + '<input id="'+id+'" class="form-control  curso control-programa" name="campo-programa" type="text"  placeholder="Nombre de Curso" value="'+nombre+'" readonly>';
  divs = divs + '<button type="button" class="btn btn-danger btn-xs eliminarPrograma" onClick="eliminarCursos(this)"><i class="material-icons">highlight_off</i></button>';
  divs = divs + '</div></div>';
  $(".espacio3").append(divs);
  agregarAlturasidenav ()
}


//FUNCION PARA QUITAR EL CURSO DE LA LISTA 
function eliminarCursos(idsEtiqueta){
    let ids = $(idsEtiqueta).prev()[0].id
    if (ids != "") {
        var index = $.inArray(ids, selected);
        selected.splice( index, 1 );
        $("#table_id_programa tbody").find("tr#"+ids).removeClass('selected');
    }
    numProspecto();
	$(idsEtiqueta).parent("div.programa").parent("div.form-group").remove();
  agregarAlturasidenav ()
}
//CONTADOR DE NUMERO DE PROSPECTOS SELECCIONADOS
function numProspecto(){
    $("#numProspecto").text(selected.length);
}
//**********************************************************
//**********************************************************
//FUNCIONES DE BOTONES DEPENDIENDO DE LO QUE SE ESCOJA
function boton(accion){
    if (selected.length > 0 || $(".cursoNuevo").length > 0) {
        if (verificarCampos ()) {
            let listasPrograma = new Array()
            let formPrograma = {};
            $('#programa-form').find('#authenticity_token').each(function () {
                var tokens = this
                formPrograma['authenticity_token'] = tokens.value;
            });
            formPrograma['prospectoIds'] = $(".prospectoId").val();
            formPrograma['salir'] = accion;
            formPrograma['tipo'] = $(".tipo").val();
            formPrograma["listaCursoSeleccionado"] = selected;
            formPrograma["listaComparar"] = selectedOld;
             $('.espacio3').find('.cursoNuevo').each(function () {
                var elemento = this
                listasPrograma.push(elemento.value)
              })
            formPrograma["lista"] = listasPrograma;
            var list = JSON.parse(JSON.stringify(formPrograma))

              var url = '/academico/setPrograma'
                    $.ajax({
                       type: 'POST',
                       dataType: 'json',
                       url: url,
                       data: list,
                     success: redireccionar
                    })
            }
        
        }else{
            if (selectedOld.length > 0) {
              let formPrograma = {};
              $('#programa-form').find('#authenticity_token').each(function () {
                  var tokens = this
                  formPrograma['authenticity_token'] = tokens.value;
              });
              formPrograma["listaCursoSeleccionado"] = selected;
              formPrograma["listaComparar"] = selectedOld;
              var list = JSON.parse(JSON.stringify(formPrograma))

                var url = '/academico/setPrograma'
                $.ajax({
                         type: 'POST',
                         dataType: 'json',
                         url: url,
                         data: list,
                         success: redireccionar
                      })
              }else{
                alert("Debe seleccionar o crear al menos un campo para poder guardar");
              }
            
        }
  
    
}
//REDIRECCIONAR 
function redireccionar (data, textStatus, jqXHR) {
  alert(data.mensaje);
  if (data.link != "") {
     window.location.href = data.link
  }else{
    let urls = window.location.href
      window.location.href = urls.replace("crear","editar")
  }
}
//**********************************************************
//**********************************************************
//FUNCION ENVIAR PARA PODER GUARDAR LOS CAMPOS SELECCIONADOS 
var selected = [];
var selectedOld = [];
$(document).ready(function(){
	
	$('#table_id_programa').DataTable({
    "responsive": true,
    "stateSave": true,
     "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Spanish.json"
      },
    "lengthMenu": [[5,10, 25, 50], [5,10, 25, 50]],
    "rowCallback": function( row, data ) {
            if ( $.inArray(data.DT_RowId, selected) !== -1 ) {
                $(row).addClass('selected');
            }
        }
  });

    /*AGREGA O ELIMINA EL ID DEL CURSO CADA VEZ QUE SE DA CLICK SOBRE ALGUN CURSO
     PARA SER ALMACENADO EN EL ARRAY selected*/
  	 $('#table_id_programa tbody').on('click', 'tr', function () {
        var id = this.id;
        var index = $.inArray(id, selected);
 
        if ( index === -1 ) {
            selected.push( id );
            var nombre = $(this).children("td").first().text();
            agregarCurso(nombre,id);
        } else {
            selected.splice( index, 1 );
            $(".espacio3").find("input#"+id).parent("div.programa").parent("div.form-group").remove();
        }
        $(this).toggleClass('selected');
        numProspecto();
    } );
     
     //ENCONTRAR TODOS LOS CAMPOS QUE TENGAN EL NOMBRE DE .selected PARA GUARDARLO EN EL ARRAY selected
    $("#table_id_programa tbody").find(".selected").each(function(){
        let selector = this;
        selected.push(selector.id);
        selectedOld.push(selector.id);
        numProspecto();
    });
    setTimeout("agregarAlturasidenav ()",10000);
    
    
});