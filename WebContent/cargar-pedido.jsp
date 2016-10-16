<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="header.jsp" />
	<script  type="text/javascript">
		$(function() {
			$(":checkbox").click(function() {
				if($(this).is(":checked"))
					$(this).closest("tr").addClass("selected");
				else
					$(this).closest("tr").toggleClass("selected");
			});
			
			$("#cargar-pedido").on("click", function(){
				var n = noty({
		            text        : '¿Deseas imprimir el pedido?',
		            type        : 'information',
		            dismissQueue: true,
		            layout      : 'topRight',
		            theme       : 'defaultTheme',
		            buttons     : [
		                {addClass: 'btn btn-primary', text: 'Si', onClick: function ($noty) {
		                	submitCarga('<%= SISINVConstants.PEDIDO_TASKS.PRINT_PEDIDO %>');
		                    $noty.close();
		                    
		                }
		                },
		                {addClass: 'btn btn-info', text: 'No', onClick: function ($noty) {
		                	submitCarga('<%= SISINVConstants.PEDIDO_TASKS.LOAD_PRODS %>');
		                    $noty.close();
		             
		                }
		                }
		            ]
		        });
			});
		});
		
		function submitCarga(task){
			$("#task").val(task);
			$("#prods").val(createListCargados());
			$("#form-pedido").submit();
		}
		
		function createListCargados() {
			var list = "";
			
			$(":checkbox").each(function() {
				if($(this).is(":checked")) {
					list += $(this).closest("tr").prop("id") + ",";
				}
			});
			
			return list;
		}
		
		function eliminar(idPedido, idProducto){
			noty({
	            text        : '¿Deseas borrar el producto?',
	            type        : 'information',
	            dismissQueue: true,
	            layout      : 'center',
	            theme       : 'defaultTheme',
	            modal		: true,
	            buttons     : [
	            {
	              	addClass: 'btn btn-primary', text: 'Si', 
	               	onClick: function ($noty) {
	               		$.ajax({
	    					url:"PedidoAction",
	    					type:"GET",
	    					data:{
	    						idPedido : idPedido,
	    						idProducto : idProducto,
	    						task : "<%= SISINVConstants.PEDIDO_TASKS.BORRAR_PRODUCTO %>"
	    					},
	    					dataType: "json",
	    					success : function (data) {
	    						$("#" + data).remove();
	    					}
	    				});
	                	$noty.close();
	               	}
	            },
	            {
	            	addClass: 'btn btn-info', text: 'No', onClick: function ($noty) {
	               		$noty.close();
	                }
	             }]
	        });
			  
		}
		
		function cambiar(idPedido, idProducto){
			$.ajax({
					url:"PedidoAction",
					type:"GET",
					data:{
						idPedido : idPedido,
						idProducto : idProducto,
						cantidad : $("#txt"+ idProducto).val(),
						task : "<%= SISINVConstants.PEDIDO_TASKS.CAMBIAR_PRODUCTO %>"
					},
					dataType: "json",
					success : function (data) {
						
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
	                            	<c:if test="${task eq 'cargar'}">
	                                <i class="fa fa-arrow-circle-o-up"></i>  Cargar pedido
	                                </c:if>
	                                <c:if test="${task eq 'mostrar_pedido'}">
	                                <i class="fa fa-file-text-o"></i>  Mostrar pedido
	                                </c:if>
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	             <!-- row -->
	             <form id="form-pedido" role="form" action="PedidoAction" method="POST">
	             	<input type="hidden" value="" id="task" name="task"/>
	             	<input type="hidden" value="" name="prods" id="prods"/>
	             	<input type="hidden" value="${pedido.id}" name="idPedido" id="idPedido"/>
	             	
	             	<div class="row">
             		 	<div class="col-lg-5">
	             		 	<div class="form-group">
                                <label>Pedido No.</label>
                                <input class="form-control" id="txtPedidoNo" name="txtPedidoNo" value="${pedido.id}" disabled>
                            </div>
                        </div>
                        <div class="col-lg-5">
	             		 	<div class="form-group">
                                <label>Fecha</label>
                                <input class="form-control" id="txtFecha" name="txtFecha" value="${fecha}" disabled>
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
                                <input class="form-control" id="txtNombre" name="txtNombre" value="${pedido.nombre}" disabled>
                            </div>
                        </div>
                        
			         </div>
			         <div class="row">
             		 	<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Dirección</label>
                                <input class="form-control" id="txtDireccion" name="txtDireccion" value="${pedido.direccion}" disabled>
                            </div>
                        </div>
                        <div class="col-lg-7">
	             		 	<div class="form-group">
                                <label>Ciudad</label>
                                <input class="form-control" id="txtCiudad" name="txtCiudad" value="${pedido.ciudad}" disabled>
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
                    	<div class="col-lg-18">
                               <div class="table-responsive">
                                   <table id="list-prods" class="table table-bordered table-hover table-striped">
                                       <thead>
                                           <tr>
                                               <th>Cantidad</th>
                                               <th>Articulo</th>
                                               <c:if test="${task eq 'cargar'}">
                                               <th>Cargado</th>
                                               <th>Eliminar</th>
                                               </c:if>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${items}" var="item">
                                       		 	<tr id="${item.id}" <c:if test="${item.cargado}">class="selected"</c:if>>
<%--                                        		 		 <td><c:out value="${item.cantidad}" /></td> --%>
													
													<td>
														<c:if test="${task eq 'cargar'}">
														<div class="col-lg-12">
															<input class="form-control" id="txt${item.id}" name="txt${item.id}" value="${item.cantidad}" onchange='cambiar("${pedido.id}", "${item.id}")'>
														</div>
														</c:if>
														<c:if test="${task eq 'mostrar_pedido'}">
														<c:out value="${item.cantidad}" />
														</c:if>
                            						</td>
                                       		 		 <td><c:out value="${item.articulo}" /></td>
                                       		 		 <c:if test="${task eq 'cargar'}">
                                       		 		 <td>
                                       		 		 	<label>
                                        					<input type="checkbox" value="" <c:if test="${item.cargado}">checked disabled</c:if>>
                                    					</label>
                                    				</td>
                                    				<td><button class='btn btn-info fa fa-trash' type='button' onclick='eliminar("${pedido.id}", "${item.id}")'></button></td>
                                    				</c:if>
                                       		 	</tr>
                                       		 </c:forEach>
                                       </tbody>
                                   </table>
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
			    		<div class="col-lg-4">
			    			<div  class="form-group">
			    				<label>Identificador</label>
			    				<p id="vend-id" class="form-control-static">${pedido.vendedor.id}</p>
			    			</div>
			    		</div>
			    		<div class="col-lg-10">
			    			<div  class="form-group">
			    				<label>Nombre</label>
			    				<p id="vend-nombre" class="form-control-static">${pedido.vendedor.nombre}</p>
			    			</div>
			    		</div>
			    		<div class="col-lg-10">
			    			<div  class="form-group">
			    				<label>Usuario</label>
			    				<p id="vend-nombre" class="form-control-static">${pedido.vendedor.usuario}</p>
			    			</div>
			    		</div>
			    	</div>
			    	<c:if test="${task eq 'cargar'}">
		         	<button id="cargar-pedido" type="button" class="btn btn-primary" >Cargar</button>
		         	</c:if>
		         </form>
	          </div>
			</div>
		</div>
	<!-- dialog -->
    
</body>
</html>