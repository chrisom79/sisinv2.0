<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="header.jsp" />
	
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
									porcentaje : m.porcentaje,
									piezas : m.piezas,
									iva : m.iva,
									comision : m.comision,
									oferta : m.oferta != undefined ? m.oferta.ofertaCompleta : "",
									oferta_tipo : m.oferta != undefined ? m.oferta.tipo : 0,
									oferta_desc : m.oferta != undefined ? m.oferta.descuento : 0,
									oferta_compra : m.oferta != undefined ? m.oferta.compra : 0,
									oferta_lleva : m.oferta != undefined ? m.oferta.lleva : 0,
									oferta_por : m.oferta != undefined ? m.oferta.por : 0
									
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
							porcentaje : ui.item.porcentaje,
							piezas : ui.item.piezas,
							iva : ui.item.iva,
							comision : ui.item.comision === "" || ui.item.comision == undefined?0:ui.item.comision,
						    oferta : ui.item.oferta,
						    oferta_tipo : ui.item.oferta_tipo,
						    oferta_desc : ui.item.oferta_desc,
						    oferta_compra : ui.item.oferta_compra,
						    oferta_lleva : ui.item.oferta_lleva,
						    oferta_por : ui.item.oferta_por
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
					$("#searchVend").tooltipster('hide');
				}
			})
			.autocomplete( "instance" )._renderItem = function( ul, item ) {
	      		return $( "<li>" )
	        		.append( "<a><strong>" + item.label + "</strong><br><i>" + item.usuario + "</i></a>" )
	        		.appendTo( ul );
    		};
			
		    dialog = $("#dialog-form").dialog({
		        autoOpen: false,
		        autoResize: true,
		        modal: true,
		        minWidth: 470,
		        buttons: {
		          "Agregar": function() {
		        	  sum = 0.0;
		        	  precio_final = 0.0;
		        	  selected.cantidad = $("#txtCantidad").val();
		        	  if(selected.oferta_tipo == 1) {
		        		  precio_final = selected.precio - (selected.precio * (selected.oferta_desc / 100));
		        	  } 
		        	  else
		        		  precio_final = selected.precio;
		        	  
		        	  selected.importe = Math.round((selected.cantidad * precio_final) * 100) / 100;
		        	  
		        	  if(selected.oferta_tipo == 2) {
		        		  if(selected.cantidad >= selected.oferta_lleva) {
		        			  var rebaja = selected.precio *  Math.floor(selected.cantidad / selected.oferta_lleva);
		        			  selected.importe = Math.round((selected.importe - rebaja) * 100) / 100;
		        		  }  
		        	  }
		        	  
		        	  if(selected.oferta_tipo == 3) {
		        		  if(selected.cantidad >= selected.oferta_compra) {
		        			  var precio_oferta = selected.oferta_por * Math.floor(selected.cantidad / selected.oferta_compra);
		        			  selected.importe = ((selected.cantidad % selected.oferta_compra) * precio_final) + precio_oferta;
		        		  }
		        	  }
		        	  
		        	  var part1 = "<tr id='"+selected.id+"'>"+
        			  "<td id='t-cantidad'>" + selected.cantidad
        			  +"</td><td id='t-nombre'>" + selected.nombre
        			  +"</td><td id='t-precio-regular'>" + selected.precio
        			  +"</td><td id='t-precio-final'>" + precio_final
        			  +"</td><td id='t-importe' class='precio'>"+ selected.importe
        			  +"</td><td id='t-oferta'> ";
        			  
        			  var part2 =  selected.oferta != "" ? "<a href='#' data-toggle='tooltip' title='" + selected.oferta + "'><i class='fa fa-info-circle fa-fw'></i></a>" : "";
        			  
        			  var part3 = "</td><td><button class='btn btn-info fa fa-trash' type='button' onclick='removeRow(&apos;"+selected.id+"&apos;)'></button>"
        			  +"</td></tr>";
        			  
		        	  $("#list-prods > tbody:last-child").append(part1 + part2 + part3);
		        	  $(".precio").each(function() {
		        		  var value = $(this).text();
		        		  if(!isNaN(value) && value.length != 0) {
		        		  	sum += parseFloat(value);
		        		  }
		        	  });
		        	  sum = Number((sum).toFixed(2)); 
		        	  $("#importe-total").text("Total: " + sum);
		        	  dialog.dialog("close");
		          },
		          "Cerrar": function() {
		            dialog.dialog("close");
		          }
		        },
		        close: function() {
		        	$("#searchProd").val("");
		        	$("#searchProd").focus();
		        },
		        open: function() {
		        	$("#oferta-alert").remove();
		        	if(selected.oferta != "")
		        		$(this).append("<div id='oferta-alert' class='alert alert-warning'> " + selected.oferta + " </div>");
		        }
		      });
		    
		    dialog_prod = $("#upd-prod").dialog({
		        autoOpen: false,
		        autoResize: true,
		        modal: true,
		        buttons: {
		          "Cambiar": function() {
		        	  $.ajax({
							url:"ProductoAction",
							type:"GET",
							data:{
								prevId : selected.id,
								txtNombre : selected.nombre,
								txtPiezas : selected.piezas,
								txtPrecioComp : selected.precio_compra,
								txtGanancia : selected.porcentaje,
								txtIVA : selected.iva,
								txtCodigo : $("#txtCodigo").val() === ""? selected.id:$("#txtCodigo").val(),
								txtComision : $("#txtComision").val() === ""? selected.comision:$("#txtComision").val(),
								task : "<%= SISINVConstants.TASKS.TASK_EDITAR %>"
							},
							dataType: "json",
							success : function (data) {
								$("#dialog-id").text(data.id);
								$("#dialog-comision").text(data.comision);
								selected.id = data.id;
								selected.comision = data.comision
								$("#txtCodigo").val("");
								$("#txtComision").val("");
								dialog_prod.dialog("close");
							}
						});
		          },
		          "Cerrar": function() {
		            dialog_prod.dialog("close");
		          }
		        },
		        close: function() {
		        	
		        }
		      });
		    
		    $("#add-prod").on("click", function() {
		    	selected.precio = (selected.precio_compra + (selected.precio_compra * (selected.porcentaje / 100))).toFixed(2);
		    	$("#dialog-id").text(selected.id);
		    	$("#dialog-nombre").text(selected.nombre);
		    	$("#dialog-precio").text("$ " + selected.precio);
		    	$("#dialog-comision").text(selected.comision);
		    	$("#txtCantidad").val("");
		        dialog.dialog( "open" );
		        $("#add-prod").tooltipster('hide');
		     });
		    
		    $("#upd-id").on("click", function() {
		    	$("#div-comision").hide();
		    	$("#div-codigo").show();
		    	dialog_prod.dialog("open");
		     });
		    
		    $("#upd-comision").on("click", function() {
		    	$("#div-comision").show();
		    	$("#div-codigo").hide();
		    	dialog_prod.dialog("open");
		     });
		    
		    $("#remove-user").on("click", function(){
		    	$("#vend-id").text("");
				$("#vend-nombre").text("");
				$("#vend-usuario").text("");
		    });
		    
		    $("#crear-pedido").on("click", function(){
		    	if ($('#form-pedido').valid() && validateInfo()) {
			    	var n = noty({
			            text        : '¿Deseas imprimir el pedido?',
			            type        : 'information',
			            dismissQueue: true,
			            layout      : 'topRight',
			            theme       : 'defaultTheme',
			            buttons     : [
			            {
			              	addClass: 'btn btn-primary', text: 'Si', 
			               	onClick: function ($noty) {
			               		submitInfo("imprimir");
			                	$noty.close();
			               	}
			            },
			            {
			            	addClass: 'btn btn-info', text: 'No', onClick: function ($noty) {
			                submitInfo("crear");
			                    $noty.close();
			             
			                }
			                }
			            ]
			        });
			    	$("#crear-pedido").hide();
			    	$("#cerrar-pedido").show();
		    	}
		    	
		    });
		    
		    $("#cerrar-pedido").on("click", function(){
		    	$("#crear-pedido").show();
		    	$("#cerrar-pedido").hide();
		    	$("#task").val('<%= SISINVConstants.TASKS.TASK_CERRAR %>');
		    	$("#form-pedido").submit();
		    	
		    });
		    
		    $("#imprimir-pedido").on("click", function(){
		    	validateAndSubmit("imprimir");
		    }); 
		    
		    $("#form-pedido input[class='form-control']").tooltipster({ 
		    	trigger : 'custom', 
		    	onlyOne : false, 
		    	position : 'right' 
		    });
		    
		    $("#searchVend").tooltipster({ 
		    	trigger : 'custom', 
		    	onlyOne : false, 
		    	position : 'right' 
		    });
		    
		    $("#add-prod").tooltipster({ 
		    	trigger : 'custom', 
		    	onlyOne : false, 
		    	position : 'right' 
		    });
		    
		    $("#form-pedido").validate({
		    	rules : {
		    		txtNombre : "required"
		    	},
		    	 errorPlacement: function (error, element) {
		             $(element).tooltipster('update', $(error).text());
		             $(element).tooltipster('show');
		         },
		         success: function (label, element) {
		             $(element).tooltipster('hide');
		         }
		    });
		    
		    $("#acc_pedido").accordion({
		        heightStyle: "content"
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
      	  $("#importe-total").text("Total: " + sum.toFixed(2));
		}
		
		function convertTableToString() {
			var list = "";
			$("#list-prods > tbody > tr").each(function(i, row) {
				list += $(row).find("td[id*='t-cantidad']").text() + "," + $(row).find("td[id*='t-precio-regular']").text() + "," + $(row).find("td[id*='t-precio-final']").text() + "," + $(row).find("td[id*='t-importe']").text() + "," + $(row).prop("id") + ";";
			});
			
			return list;
		}
		
		function submitInfo(task){
			$("#task").val(task);
			$("#prods").val(convertTableToString());
			$("#idVend").val($("#vend-id").text());
			$("#nombreVend").val($("#vend-nombre").text());
			$("#total").val(sum);
			$("#form-pedido").submit();
		}
		
		function validateInfo() {
			if($("#list-prods tr").length < 2) {
				$("#add-prod").tooltipster('update', 'Es necesario agregar al menos un producto');
	            $("#add-prod").tooltipster('show');
	            return false;
			} 
			
			if($("#vend-id").text() === "") {
				$("#searchVend").tooltipster('update', 'Es necesario agregar al vendedor');
	            $("#searchVend").tooltipster('show');
	            return false;
			}
			return true;
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
	             	<input type="hidden" value="" name="prods" id="prods"/>
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
	                <div id="acc_pedido">
	                	<h3>Datos del cliente</h3>
	                	<div>
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
				     	</div>
	                	<h3>Productos</h3>
	                	<div>
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
                   			<br/>
                      		<!-- row -->
                   			<div class="row">
                   				<div class="col-lg-18">
                        			<div class="table-responsive">
                            			<table id="list-prods" class="table table-bordered table-hover table-striped">
                                			<thead>
                                    			<tr>
                                               		<th>Cantidad</th>
                                               		<th>Articulo</th>
                                               		<th>Precio Regular</th>
                                               		<th>Precio Final</th>
                                               		<th>Importe</th>
                                               		<th>Oferta</th>
                                               		<th>Acciones</th>
                                        		</tr>
                                 			</thead>
                     						<tbody>
                                    		</tbody>
                        				</table>
                   					</div>
		 	 					</div>
		 					</div>
		 				
		 					<br/>
		 			 		<div class="row">
                    			<div class="col-lg-24">
                    				<div  class="alert alert-success">
			    						<p id="importe-total">Total: 0.00</p>
			    					</div>
                    			</div>
                    		</div>
                    	</div>
                    <!-- row -->
                    <!-- <div class="row">
	                    <div class="col-lg-24">
	                        <ol class="breadcrumb">
	                            <li class="active">
	                                <i class="fa fa-user"></i> Vendedor
	                            </li>
	                        </ol>
	                    </div>
	                </div> -->
	                	<h3>Vendedor</h3>
	                	<div>
	                		<div class="row">
	                			<div class="col-lg-12">
	             		 			<div  class="form-group">
                                		<input id="searchVend" name="searchVend" class="form-control" placeholder="Nombre o usuario del vendedor">
                            		</div>
                        		</div>
	                		</div>
	                		<div class="row">
			    				<div class="col-lg-4 hidden-sm hidden-xs">
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
			    				<div class="col-lg-5 hidden-sm hidden-xs">
			    					<div  class="form-group">
			    						<label>Usario</label>
			    						<p id="vend-usuario" class="form-control-static"></p>
			    					</div>
			    				</div>
			    				<div class="col-lg-2">
			    					<button id="remove-user" type="button" class="btn btn-info fa fa-trash" ></button>
			    				</div>
			    			</div>
			    		</div>
			    	</div>
			    	<br/>
		         	<button id="crear-pedido" type="button" class="btn btn-primary" >Crear</button>
		         	<button id="cerrar-pedido" type="button" class="btn btn-primary" style="display:none;" >Cerrar</button>
		         </form>
	          </div>
			</div>
		</div>
	<!-- dialog -->
    <div id="dialog-form" class="panel panel-default">
    	<div class="row">
    		<div class="col-lg-10">
    			<div  class="form-group">
    				<label>Codigo</label>
    				<p id="dialog-id" class="form-control-static"></p>
    			</div>
    		</div>
    		<div class="col-lg-3">
                 <button id="upd-id" class="btn btn-success" type="button">Cambiar</button>
            </div>
    	</div>
    	<div class="row">
    		<div class="col-lg-24">
    			<div  class="form-group">
    				<label>Nombre</label>
    				<p id="dialog-nombre" class="form-control-static"></p>
    			</div>
    		</div>
    	</div>
    	<div class="row">
    		<div class="col-lg-24">
    			<div  class="form-group">
    				<label>Precio</label>
    				<p id="dialog-precio" class="form-control-static"></p>
    			</div>
    		</div>
    	</div>
    	<div class="row">
        	<div class="col-lg-10">
          		<div  class="form-group">
    				<label>Comisión</label>
    				<p id="dialog-comision" class="form-control-static"></p>
    			</div>
            </div>
            <div class="col-lg-3">
                 <button id="upd-comision" class="btn btn-success" type="button">Cambiar</button>
            </div>
        </div>
    	<div class="row">
        	<div class="col-lg-5">
          		<div class="form-group">
                	<label>Cantidad</label>
                    <input class="form-control" id="txtCantidad" name="txtCantidad">
                </div>
            </div>
        </div>
    </div>
    <div id="upd-prod" class="panel panel-default">
    	<div class="col-lg-18" id="div-codigo">
			<div class="form-group">
	        	<label>Código</label>
	            <input class="form-control" id="txtCodigo" name="txtCodigo" value="">
	        </div>
	    </div>
	    <div class="col-lg-18" id="div-comision">
			<div class="form-group">
	        	<label>Comisión</label>
	            <input class="form-control" id="txtComision" name="txtComision" value="">
	        </div>
	    </div>
    </div>
</body>
</html>