<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="header.jsp" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#searchProd").autocomplete({
			minLength : 2,
			source : function (request, response) {
				$.ajax({
					url:"ProductoAction",
					type:"GET",
					data:{
						term : request.term,
						task : "QSearch"
					},
					dataType: "json",
					success : function (data) {
						var array = $.map(data, function(m){
							return {
								label: m.nombre,
								id : m.id,
								nombre : m.nombre,
								precio : m.precioCompra,
								porcentaje : m.porcentaje
							}
						});
						response(array);
					}
				});
			} ,
			select : function (event, ui) {
				selected = {
						id : ui.item.id,
						nombre : ui.item.nombre,
						precio_compra : ui.item.precio,
						precio : ui.item.precio,
						porcentaje : ui.item.porcentaje
					}
			}
		})
		.autocomplete( "instance" )._renderItem = function( ul, item ) {
      		return $( "<li>" )
        		.append( "<a><strong>" + item.label + "</strong><br><i>" + item.id + "</i></a>" )
        		.appendTo( ul );
		};
		
		$("input[name='tipo']").on("click", function() {
			if($(this).val() == "desc"){
				$("#div-desc").show();
				$("#div-precio").hide();
				$("#div-compralleva").hide();
				$("#div-comprapor").hide();
			} else if($(this).val() == "compra-lleva") {
				$("#div-desc").hide();
				$("#div-precio").hide();
				$("#div-compralleva").show();
				$("#div-comprapor").hide();
			} else if($(this).val() == "compra-por") {
				$("#div-desc").hide();
				$("#div-precio").hide();
				$("#div-compralleva").hide();
				$("#div-comprapor").show();
			}
		});
	});
	
	function save(numeroPedido){
		
		if(selected.id != undefined) {
			$("#producto").val(selected.id);
		}
			
		$("#form-prod").submit();
	 }
</script>
</head>
<body>
	<jsp:include page="navigation.jsp" />
	<div id="wrapper">
	 <div id="page-wrapper">
	 	 <div class="container-fluid">
	 	 	<!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-24">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-plus-square"></i>  Editar oferta
                            </li>
                        </ol>
                    </div>
                </div>
             <!-- row -->
             <form id="form_oferta" role="form" action="OfertaAction" method="POST">
             	<input type="hidden" value="editar" name="task"/>
             	<input type="hidden" value="${oferta.id}" name="idOferta"/>
             	<input type="hidden" value="${oferta.producto.id}" name="prevProducto" id="prevProductoproducto"/>
             	<input type="hidden" value="${oferta.producto.id}" name="producto" id="producto"/>
             	<jsp:include page="campos-oferta.jsp" />
	            <button type="submit" class="btn btn-primary" onclick='save()'>Actualizar</button>
	         </form>
          </div>
		</div>
	</div>
</body>
</html>