$("#registrar").click(function(){
	if (verificarCampo() == true) {
		$("#form-inicio").submit();
	}else{
	}
});

function verificarCampo(){
	var ban = true;
	$(".requerido").each(function (){
		if ($(this).val() == "") {
			$(this).addClass("vacio");
			ban = false;
		}
	})

	if (!ban) {alert("Por favor llene los campos ")}
    return ban;
}

$(".requerido").keyup(function() {
    $(this).removeClass("vacio"); 
});