<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="header.jsp" />
		<script  type="text/javascript">
			$(document).ready(function() {
				$.ajax({
					url:"PedidoRutaAction",
					type:"GET",
					data:{
						task : "<%= SISINVConstants.TASKS.TASK_INIT %>"
					},
					dataType: "json",
					success : function (data) {
						$.map(data, function(m){
							if(m.ruta == undefined) {
								$("#list-pedidos > tbody:last-child").append("<tr id='" + m.id + "'>" +
				        			  "<td id='id_" + m.id + "'>"+ m.id +"</td>" +
				        			  "<td id='nom_" + m.id + "'>"+ m.nombre +"</td>" +
				        			  "<td id='dir_" + m.id + "'>"+ m.direccion +"</td>" +
				        			  "<td id='tot_" + m.id + "'>"+ m.total+"</td>" +
				        			  "<td id='ale_" + m.id + "'><input id='cb-selected' type='checkbox' value=''></td>" +
				        			  "</tr>");
							} else if (!($("#"+ m.ruta.id).length)) {
								$(".container-fluid").append(
										"<div class='row'>" +
											"<div class='col-lg-18'>" +
												"<div class='panel-heading'>" +
													"<h3 class='panel-title'><i class='fa fa-truck fa-fw'></i> Ruta " + m.ruta.nombre + " </h3>" +
												"</div>" +
											"</div>" +
											(!m.enviado?
											"<div id='btn_"+ m.ruta.id + "' class='col-lg-5'>" +
							                       	"<button class='btn btn-info' type='button' onclick='enviarRuta(" + m.ruta.id + ")'>Enviar pedidos</button>" +
							                "</div>":"")+
										"</div>" +
							            "<div class='row'>" +
											"<div class='panel-body'>" +
												"<div class='table-responsive'>" +
													"<table id='tbl_" + m.ruta.id + "' class='table table-bordered table-hover table-striped'>" +
													  "<thead>" +
														  "<tr>" +
															  "<th class='hidden-sm hidden-xs'># Pedido</th>" +
															  "<th>Fecha</th>" +
															  "<th>Cliente</th>" +
															  "<th>Total</th>" +
															  "<th>Status</th>" +
														  "</tr>" +
													  "</thead>" +
													  "<tbody>" +
														  "<tr id='row_" + m.id + "'>"+
									        			  	"<td id='id_" + m.id + "'>"+ m.id +"</td>" +
									        			  	"<td id='nom_" + m.id + "'>"+ m.nombre +"</td>" +
									        			  	"<td id='dir_" + m.id + "'>"+ m.direccion +"</td>" +
									        			  	"<td id='tot_" + m.id + "'>"+ m.total+"</td>" +
									        			  	(m.enviado?"<td id='ale_" + m.id + "'><div class='alert-cell alert-success'>Enviado</div></td>":
									        			  		"<td id='ale_" + m.id + "'><div class='alert-cell alert-warning'>Por enviar</div></td>")
									        			   + "</tr>" +
													  "</tbody>" +
													"</table>" +
												"</div>" +
											"</div>" +
									 "</div>");
							} else {
								$("#tbl_" + + m.ruta.id + " > tbody:last-child").append("<tr id='row_" + m.id + "'>" +
					        			  "<td id='id_" + m.id + "'>"+ m.id +"</td>" +
					        			  "<td id='nom_" + m.id + "'>"+ m.nombre +"</td>" +
					        			  "<td id='dir_" + m.id + "'>"+ m.direccion +"</td>" +
					        			  "<td id='tot_" + m.id + "'>"+ m.total+"</td>" +
					        			  (m.enviado?"<td id='ale_" + m.id + "'><div class='alert-cell alert-success'>Enviado</div></td>":
				        			  		"<td id='ale_" + m.id + "'><div class='alert-cell alert-warning'>Por enviar</div></td>") +
					        			  "</tr>");
							}
						});
					}
				});
				
				$("#add-ruta").on("click", function(){
					if($("#nombre-ruta").val() === "") {
						$("#nombre-ruta").tooltipster('update', 'Es necesario agregar un nombre');
			            $("#nombre-ruta").tooltipster('show');
					} else {
						var list = "";
						$(":checkbox").each(function() {
							if($(this).is(":checked")) {
								list += $(this).closest("tr").prop("id") + ",";
							}
						});
						
						$.ajax({
							url:"PedidoRutaAction",
							type:"GET",
							data:{
								nombre : $("#nombre-ruta").val(),
								pedidos : list,
								task : "<%= SISINVConstants.RUTA_TASKS.CREAR %>"
							},
							dataType: "json",
							success : function (data) {
								$(".container-fluid").append(
									"<div class='row'>" +
										"<div class='col-lg-18'>" +
											"<div class='panel-heading'>" +
												"<h3 class='panel-title'><i class='fa fa-truck fa-fw'></i> Ruta " + $("#nombre-ruta").val() + " </h3>" +
											"</div>" +
										"</div>" +
										"<div id='btn_"+ data + "' class='col-lg-5'>" +
					                       	"<button class='btn btn-info' type='button' onclick='enviarRuta(" + data + ")'>Enviar pedidos</button>" +
					                    "</div>"+
									"</div>" +
					                "<div class='row'>" +
											"<div class='panel-body'>" +
												"<div class='table-responsive'>" +
													"<table id='tbl_" + data + "' class='table table-bordered table-hover table-striped'>" +
													  "<thead>" +
														  "<tr>" +
															  "<th class='hidden-sm hidden-xs'># Pedido</th>" +
															  "<th>Fecha</th>" +
															  "<th>Cliente</th>" +
															  "<th>Total</th>" +
															  "<th>Status</th>" +
														  "</tr>" +
													  "</thead>" +
													  "<tbody>" +
													  "</tbody>" +
													"</table>" +
												"</div>" +
											"</div>" +
										"</div>" +
								 "</div>"
								);
								
								$(":checkbox").each(function() {
									
									if($(this).is(":checked")) {
										var tr = $(this).closest("tr");
										$("#tbl_" + data + " > tbody:last-child").append("<tr id='row_" + tr.find('#id_'+ tr.prop('id')).text() + "'>"+
							        			  "<td>" + tr.find('#id_'+ tr.prop('id')).text() + "</td>" +
							        			  "<td>" + tr.find('#nom_'+ tr.prop('id')).text() + "</td>" +
							        			  "<td>" + tr.find('#dir_'+ tr.prop('id')).text() + "</td>" +
							        			  "<td>" + tr.find('#tot_'+ tr.prop('id')).text() + "</td>" +
							        			  "<td id='ale_" +tr.find('#id_'+ tr.prop('id')).text()+ "'>" +
							        			  	"<div class='alert-cell alert-warning'>" +
							                     	 	"Por enviar" +
							                  		"</div>" +
							                  		"</td>" +
							        		"</tr>");
										$(this).closest("tr").remove();
										$("#nombre-ruta").val("");
									}
								});
							}
						});
					}
				});
				
				$("#nombre-ruta").tooltipster({ 
			    	trigger : 'custom', 
			    	onlyOne : false, 
			    	position : 'bottom' 
			    });
				
				$("#nombre-ruta").on("keyup", function(){
					$("#nombre-ruta").tooltipster('hide');	
				});
				
			});
			
			function enviarRuta(idPedido){
				$.ajax({
					url:"PedidoRutaAction",
					type:"GET",
					data:{
						idRuta : idPedido,
						task : "<%= SISINVConstants.RUTA_TASKS.ENVIAR %>"
					},
					dataType: "json",
					success : function (data) {
						if(data != "") {
							$("#tbl_"+data + " > tbody > tr").each(function () {
								var idRow = $(this).prop('id').replace( /^\D+/g, '');;
								$(this).find(".alert-cell").remove();
								$(this).find("#ale_" + idRow).append("<div class='alert-cell alert-success'>" +
			                     	 	"Enviado" +
				                  		"</div>");
							});
							
							$("#btn_"+data).remove()
						}
					}
				});
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
                                <i class="fa fa-search"></i> Pedidos pendientes de hoy
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- row -->
				 <div class="row">
				 	<div class="col-lg-24">
				 		<div class="panel-heading">
				 			<h3 class="panel-title"><i class="fa fa-shopping-cart fa-fw"></i> Lista de pedidos</h3>
				 		</div>
				 		<div class="panel-body">
				 			<div class="table-responsive">
				 				 <table id="list-pedidos" class="table table-bordered table-hover table-striped">
                                      <thead>
                                          <tr>
                                              <th class="hidden-sm hidden-xs"># Pedido</th>
                                              <th>Cliente</th>
                                              <th>Direccion</th>
                                              <th>Total</th>
                                              <th>Ruta</th>
                                          </tr>
                                      </thead>
                                      <tbody>
                                      		
                                      </tbody>
                                     </table>
				 			</div>
				 		</div>
				 	</div>
				 	
				 </div>
				 <!-- end row -->
				 <!-- row -->
				 <div class="row">
		         	<div class="col-lg-10">
             		 	<div  class="form-group">
                               <input id="nombre-ruta" class="form-control" type="text" placeholder="Nombre de la ruta">
                           </div>
                       </div>
                       <div class="col-lg-4">
                       	<button id="add-ruta" class="btn btn-success" type="button">Crear ruta</button>
                       </div>
                  </div>
                  <!-- end row -->
                  <!-- row -->
                  <div class="row">
                    <div class="col-lg-24">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-truck"></i> Rutas
                            </li>
                        </ol>
                    </div>
                    <!-- end row -->
                </div>
                  
            </div>
         </div>
	</body>
</html>