<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="css/jquery-ui.css" rel="stylesheet">
	<link href="css/extra-styles.css" rel="stylesheet">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/utils.js"></script>
	<script src="js/jquery.noty.packaged.js"></script>
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
		                	submitCarga('<%= SISINVConstants.TASKS.TASK_IMPRIMIR %>');
		                    $noty.close();
		                    
		                }
		                },
		                {addClass: 'btn btn-info', text: 'No', onClick: function ($noty) {
		                	submitCarga('<%= SISINVConstants.PEDIDO_TASKS.PRINT_PEDIDO %>');
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
	                                <i class="fa fa-arrow-circle-o-up"></i>  Cargar pedido
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
                                               <th>Cargado</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${items}" var="item">
                                       		 	<tr id="${item.id}" <c:if test="${item.cargado}">class="selected"</c:if>>
                                       		 		 <td><c:out value="${item.cantidad}" /></td>
                                       		 		 <td><c:out value="${item.articulo}" /></td>
                                       		 		 <td>
                                       		 		 	<label>
                                        					<input type="checkbox" value="" <c:if test="${item.cargado}">checked disabled</c:if>>
                                    					</label>
                                    				</td>
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
		         	<button id="cargar-pedido" type="button" class="btn btn-primary" >Cargar</button>
		         </form>
	          </div>
			</div>
		</div>
	<!-- dialog -->
    
</body>
</html>