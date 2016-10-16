<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="header.jsp" />
	<script>
		$(function() {
			$('#tab_ofertas').DataTable();
			
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
		});
		
		function search(){
			$("#task").val('<%= SISINVConstants.TASKS.TASK_BUSCAR %>');
			$("#producto").val(selected.id);
			$("#buscarForm").submit();
		}
		
		function edit(id, idProducto){
			$("#task").val('<%= SISINVConstants.TASKS.GET_ITEM %>');
			$("#idOferta").val(id);
			$("#producto").val(idProducto);
			$("#buscarForm").submit();
		}
		
		function delOferta(id, idProducto){
			var n = noty({
	            text        : '¿Deseas borrar la oferta?',
	            type        : 'information',
	            dismissQueue: true,
	            layout      : 'center',
	            theme       : 'defaultTheme',
	            modal		: true,
	            buttons     : [
	                {
	                	addClass: 'btn btn-primary', text: 'Si', onClick: function ($noty) {
	                		$("#task").val("borrar");
	        				$("#idOferta").val(id);
	        				$("#producto").val(idProducto);
	        				$("#buscarForm").submit();
	                    	$noty.close();
	                	}
	                },
	                {
	                	addClass: 'btn btn-default', text: 'No', onClick: function ($noty) {
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
	                                <i class="fa fa-search"></i> Buscar ofertas
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	                
	             
	             <!-- row -->
	             
             	<form id="buscarForm" role="form" action="OfertaAction" method="POST">
             		<input type="hidden" value="buscar" name="task" id="task"/>
             		<input type="hidden" value="" name="idOferta" id="idOferta"/>
             		<input type="hidden" value="" name="producto" id="producto"/>
             		<div class="row">
             			<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Nombre de la oferta</label>
                                <input class="form-control" placeholder="Nombre de la oferta" name="txtNombre" value="${txtBuscar}">
                            </div>  
                        </div>
                    </div>
                    <div class="row">
             			<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Tipo de oferta</label>
                                <label class="radio-inline">
                                    <input type="radio" name="tipo" id="tipo" value="desc">Descuento
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="tipo" id="tipo" value="compra-lleva">Compra-Llevate
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="tipo" id="tipo" value="compra-por">Compra-Por
                                </label>
                                
                            </div>  
                        </div>
                    </div>
                    <div class="row">
						<div class="col-lg-12">
					 		<div  class="form-group">
					 			<label>Producto en oferta</label>
					             <input id="searchProd" class="form-control" type="text" placeholder="Nombre del producto">
					         </div>
					     </div>
					</div>
                   	<button type="submit" class="btn btn-info" onclick='search()'>Buscar</button>
             		 </form>
		             	
		         
	             </div>
	             <!-- row -->
	             <div class="row">
                    <div class="col-lg-24">
                       	<div class="panel-heading">
                               <h3 class="panel-title"><i class="fa fa-shopping-cart fa-fw"></i> Lista de productos</h3>
                           </div>
                           <div class="panel-body">
                               <div class="table-responsive">
                                   <table id="tab_ofertas" class="table table-bordered table-hover table-striped">
                                       <thead>
                                           <tr>
                                               <th>Nombre</th>
                                               <th>Tipo</th>
                                               <th>Producto</th>
                                               <th>Editar</th>
                                               <th>Borrar</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${ofertas}" var="item">
											    <tr>
											      <td><c:out value="${item.descripcion}" /></td>
											      <td><c:out value="${item.nombreTipo}" /></td>
											      <td><c:out value="${item.nombre}" /></td>
											      <td><button class='btn btn-info fa fa-edit' type='button' onclick='edit("${item.id}", "${item.codigo}")'></button></td>
											      <td><button class='btn btn-info fa fa-trash' type='button' onclick='delOferta("${item.id}", "${item.codigo}")'></button></td>
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