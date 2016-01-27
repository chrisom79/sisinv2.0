<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script  type="text/javascript">
		var selected = null;
		var sum;
		$(document).ready(function() {
			$(window).keydown(function(event){
				if(event.keyCode == 13) {
					event.preventDefault();
					return false;
				}
			});
			
			$.ajax({
				url:"ProductoAction",
				type:"GET",
				data:{
					task : "init"
				},
				dataType: "json",
				success : function (data) {
					$("#txtPedidoNo").val(data);
					var d = new Date();

					var month = d.getMonth()+1;
					var day = d.getDate();

					var output =  (day<10 ? '0' : '') + day + '/' +
					    (month<10 ? '0' : '') + month + '/' +
					    d.getFullYear();
					$("#txtFecha").val(output);
					
				}
			});
			
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
			
    		$("#searchVend").autocomplete({
				minLength : 2,
				source : function (request, response) {
					$.ajax({
						url:"VendedorAction",
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
									usuario : m.usuario
								}
							});
							response(array);
						}
					});
				} ,
				select : function (event, ui) {
					$("#vend-id").text(ui.item.id);
					$("#vend-nombre").text(ui.item.nombre);
					$("#vend-usuario").text(ui.item.usuario);
				}
			})
			.autocomplete( "instance" )._renderItem = function( ul, item ) {
	      		return $( "<li>" )
	        		.append( "<a><strong>" + item.label + "</strong><br><i>" + item.usuario + "</i></a>" )
	        		.appendTo( ul );
    		};
			
		    dialog = $( "#dialog-form" ).dialog({
		        autoOpen: false,
		        height: 500,
		        width: 500,
		        modal: true,
		        buttons: {
		          "Agregar": function() {
		        	  sum = 0.0;
		        	  selected.cantidad = $("#txtCantidad").val();
		        	  selected.importe = selected.cantidad * selected.precio;
		        	  $("#list-prods > tbody:last-child").append("<tr id='"+selected.id+"'>"+
		        			  "<td id='t-cantidad'>"+ selected.cantidad
		        			  +"</td><td id='t-nombre'>"+ selected.nombre
		        			  +"</td><td id='t-precio'>"+ selected.precio
		        			  +"</td><td id='t-importe' class='precio'>"+ selected.importe
		        			  +"</td><td><button class='btn btn-info fa fa-trash' type='button' onclick='removeRow("+selected.id+")'></button>"
		        			  +"</td></tr>");
		        	  $(".precio").each(function() {
		        		  var value = $(this).text();
		        		  if(!isNaN(value) && value.length != 0) {
		        		  	sum += parseFloat(value);
		        		  }
		        	  });
		        	  $("#importe-total").text("Total: " + sum);
		        	  dialog.dialog( "close" );
		          },
		          "Cerrar": function() {
		            dialog.dialog( "close" );
		          }
		        },
		        close: function() {
		        	
		           
		        }
		      });
		    
		    $("#add-prod").on("click", function() {
		    	selected.precio = selected.precio_compra + (selected.precio_compra * (selected.porcentaje / 100));
		    	$("#dialog-id").text(selected.id);
		    	$("#dialog-nombre").text(selected.nombre);
		    	$("#dialog-precio").text("$ " + selected.precio);
		    	$("#txtCantidad").val("");
		        dialog.dialog( "open" );
		     });
		    
		    $("#remove-user").on("click", function(){
		    	$("#vend-id").text("");
				$("#vend-nombre").text("");
				$("#vend-usuario").text("");
		    });
		    
		    $("#crear-pedido").on("click", function(){
		    	validateAndSubmit("crear");
		    });
		    
		    $("#imprimir-pedido").on("click", function(){
		    	validateAndSubmit("imprimir");
		    });
		    
		});
		
		function removeRow(id) {
			sum = 0.0;
			
			$("#" + id).remove();
			
			$(".precio").each(function() {
      		  var value = $(this).text();
      		  if(!isNaN(value) && value.length != 0) {
      		  	sum += parseFloat(value);
      		  }
      	  });
      	  $("#importe-total").text("Total: " + sum);
		}
		
		function convertTableToString() {
			var list = "";
			$("#list-prods > tbody > tr").each(function(i, row) {
				list += $(row).find("td[id*='t-cantidad']").text() + "," + $(row).find("td[id*='t-precio']").text() + "," + $(row).prop("id") + ";";
			});
			
			return list;
		}
		
		function validateAndSubmit(task){
			$("#task").val(task);
			$("#prods").val(convertTableToString());
			$("#idVend").val($("#vend-id").text());
			$("#nombreVend").val($("#vend-nombre").text());
			$("#total").val(sum);
			$("#form-pedido").submit();
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
	                                <i class="fa fa-edit"></i>  Crear pedido
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	             <!-- row -->
	             <form id="form-pedido" role="form" action="PedidoAction" method="POST">
	             	<input type="hidden" value="" id="task" name="task"/>
	             	<input type="hidden" value="crear" name="prods" id="prods"/>
	             	<input type="hidden" value="" name="idVend" id="idVend"/>
	             	<input type="hidden" value="" name="nombreVend" id="nombreVend"/>
	             	<input type="hidden" value="" name="total" id="total"/>
	             	<div class="row">
             		 	<div class="col-lg-5">
	             		 	<div class="form-group">
                                <label>Pedido No.</label>
                                <input class="form-control" id="txtPedidoNo" name="txtPedidoNo">
                            </div>
                        </div>
                        <div class="col-lg-5">
	             		 	<div class="form-group">
                                <label>Fecha</label>
                                <input class="form-control" id="txtFecha" name="txtFecha">
                            </div>
                        </div>
			         </div>
	             	<div class="row">
	                    <div class="col-lg-24">
	                        <ol class="breadcrumb">
	                            <li class="active">
	                                <i class="fa fa-male"></i> Datos del cliente
	                            </li>
	                        </ol>
	                    </div>
	                </div>
			         <div class="row">
             		 	<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Nombre</label>
                                <input class="form-control" id="txtNombre" name="txtNombre">
                            </div>
                        </div>
                        
			         </div>
			         <div class="row">
             		 	<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Dirección</label>
                                <input class="form-control" id="txtDireccion" name="txtDireccion">
                            </div>
                        </div>
                        <div class="col-lg-7">
	             		 	<div class="form-group">
                                <label>Ciudad</label>
                                <input class="form-control" id="txtCiudad" name="txtCiudad">
                            </div>
                        </div>
			         </div>
			         <div class="row">
	                    <div class="col-lg-24">
	                        <ol class="breadcrumb">
	                            <li class="active">
	                                <i class="fa fa-shopping-cart"></i> Productos
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	                <!-- row -->
	                 <div class="row">
			         	<div class="col-lg-12">
	             		 	<div  class="form-group">
                                <input id="searchProd" class="form-control" type="text" placeholder="Nombre del producto">
                            </div>
                        </div>
                        <div class="col-lg-2">
                        	<button id="add-prod" class="btn btn-success fa fa-plus" type="button"></button>
                        </div>
                      </div>
                      <!-- row -->
                      <div class="row">
                    	<div class="col-lg-18">
                               <div class="table-responsive">
                                   <table id="list-prods" class="table table-bordered table-hover table-striped">
                                       <thead>
                                           <tr>
                                               <th>Cantidad</th>
                                               <th>Articulo</th>
                                               <th>Precio</th>
                                               <th>Importe</th>
                                               <th>Acciones</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		
                                       </tbody>
                                   </table>
                               </div>
                           
		 	 			</div>
		 			</div>
		 			 <div class="row">
                    	<div class="col-lg-24">
                    		<div  class="alert alert-success">
			    				<p id="importe-total">Total: 0.00</p>
			    			</div>
                    	</div>
                    </div>
                    <!-- row -->
                    <div class="row">
	                    <div class="col-lg-24">
	                        <ol class="breadcrumb">
	                            <li class="active">
	                                <i class="fa fa-user"></i> Vendedor
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	                <div class="row">
	                	<div class="col-lg-12">
	             		 	<div  class="form-group">
                                <input id="searchVend" class="form-control" type="text" placeholder="Nombre o usuario del vendedor">
                            </div>
                        </div>
	                </div>
	                <div class="row">
			    		<div class="col-lg-4">
			    			<div  class="form-group">
			    				<label>Identificador</label>
			    				<p id="vend-id" class="form-control-static"></p>
			    			</div>
			    		</div>
			    		<div class="col-lg-10">
			    			<div  class="form-group">
			    				<label>Nombre</label>
			    				<p id="vend-nombre" class="form-control-static"></p>
			    			</div>
			    		</div>
			    		<div class="col-lg-5">
			    			<div  class="form-group">
			    				<label>Usario</label>
			    				<p id="vend-usuario" class="form-control-static"></p>
			    			</div>
			    		</div>
			    		<div class="col-lg-2">
			    			<button id="remove-user" type="button" class="btn btn-info fa fa-trash" ></button>
			    		</div>
			    	</div>
		         	<button id="crear-pedido" type="button" class="btn btn-primary" >Crear</button>
		         	<button id="imprimir-pedido" type="button" class="btn btn-info" >Imprimir</button>
		         </form>
	          </div>
			</div>
		</div>
	<!-- dialog -->
    <div id="dialog-form" class="panel panel-default">
    	<div class="row">
    		<div class="col-lg-6">
    			<div  class="form-group">
    				<label>Codigo</label>
    				<p id="dialog-id" class="form-control-static"></p>
    			</div>
    		</div>
    	</div>
    	<div class="row">
    		<div class="col-lg-6">
    			<div  class="form-group">
    				<label>Nombre</label>
    				<p id="dialog-nombre" class="form-control-static"></p>
    			</div>
    		</div>
    	</div>
    	<div class="row">
    		<div class="col-lg-6">
    			<div  class="form-group">
    				<label>Precio</label>
    				<p id="dialog-precio" class="form-control-static"></p>
    			</div>
    		</div>
    	</div>
    	<div class="row">
        	<div class="col-lg-12">
          		<div class="form-group">
                	<label>Cantidad</label>
                    <input class="form-control" id="txtCantidad" name="txtCantidad">
                    </div>
               	</div>
        </div>
    </div>
</body>
</html>