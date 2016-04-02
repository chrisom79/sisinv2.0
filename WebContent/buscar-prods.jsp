<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="css/jquery-ui.css" rel="stylesheet">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/utils.js"></script>
	<script src="js/jquery.noty.packaged.js"></script>
	<script>
		function editProducto(id){
			$("#task").val("getProd");
			$("#productoId").val(id);
			$("#buscarForm").submit();
		}
		
		function deleteProducto(id){
			
			var n = noty({
	            text        : '¿Deseas borrar el producto?',
	            type        : 'information',
	            dismissQueue: true,
	            layout      : 'center',
	            theme       : 'defaultTheme',
	            modal		: true,
	            buttons     : [
	                {addClass: 'btn btn-primary', text: 'Si', onClick: function ($noty) {
	                	$("#task").val("borrar");
	        			$("#productoId").val(id);
	        			$("#buscarForm").submit();
	                    $noty.close();
	                }
	                },
	                {addClass: 'btn btn-default', text: 'No', onClick: function ($noty) {
	                    $noty.close();
	                }
	                }
	            ]
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
	                                <i class="fa fa-search"></i> Buscar productos
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	                
	             
	             <!-- row -->
	             <div class="row">
             		 <form id="buscarForm" role="form" action="ProductoAction" method="POST">
             		 	<input type="hidden" value="buscar" name="task" id="task"/>
             		 	<input type="hidden" value="" name="productoId" id="productoId"/>
             		 	<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Nombre o código</label>
                                <input class="form-control" placeholder="Texto a buscar" name="txtBuscar" value="${txtBuscar}">
                            </div>
                            <button type="submit" class="btn btn-info" >Buscar</button>
                        </div>
                        
             		 </form>
		             	
		         </div>
	             </div>
	             <!-- row -->
	             <div class="row">
                    <div class="col-lg-24">
                       	<div class="panel-heading">
                               <h3 class="panel-title"><i class="fa fa-shopping-cart fa-fw"></i> Lista de productos</h3>
                           </div>
                           <div class="panel-body">
                               <div class="table-responsive">
                                   <table class="table table-bordered table-hover table-striped">
                                       <thead>
                                           <tr>
                                               <th>Codigo</th>
                                               <th>Nombre</th>
                                               <th>Precio compra</th>
                                               <th>Precio venta</th>
                                               <th>Iva</th>
                                               <th>Editar</th>
                                               <th>Borrar</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${productos}" var="item">
											    <tr>
											      <td><c:out value="${item.id}" /></td>
											      <td><c:out value="${item.nombre}" /></td>
											      <td><c:out value="${item.precioCompra}" /></td>
											      <td><c:out value="${(item.precioCompra*(item.porcentaje / 100)) + item.precioCompra}" /></td>
											      <td><c:if test="${item.iva}"><i class="fa fa-check fa-fw"></i></c:if></td>
											      <td><button class='btn btn-info fa fa-edit' type='button' onclick='editProducto("${item.id}")'></button></td>
											      <td><button class='btn btn-info fa fa-trash' type='button' onclick='deleteProducto("${item.id}")'></button></td>
											    </tr>
											  </c:forEach>
                                       </tbody>
                                   </table>
                               </div>
                           </div>
		 	 		</div>
		 		</div>
			</div>
		</div>
</body>
</html>