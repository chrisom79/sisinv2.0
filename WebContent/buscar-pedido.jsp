<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SISINV 2.0</title>
	<link href="css/jquery-ui.css" rel="stylesheet">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/utils.js"></script>
	<script src="js/jquery.noty.packaged.js"></script>
  	<script>
		  $(function() {
		    $("#fechaInicio").datepicker({
		    	dateFormat: "dd/mm/yy"
		    });
		    if($("#fechaInicio").val() == null || $("#fechaInicio").val() == "")
		    	$("#fechaInicio").datepicker( "setDate", subtractMonthsDate(new Date(), 1));
		    
		    $("#fechaFinal").datepicker({
		    	dateFormat: "dd/mm/yy",
		    	maxDate: 'today'
		    });
		    $("#fechaFinal").datepicker( "setDate", new Date());
		  });
		  
		  function imprimirPedido(numeroPedido){
			   $.ajax({
					url:"PedidoAction",
					type:"GET",
					data:{
						task : "imprimir",
						id: numeroPedido
					},
					dataType: "text",
					success : function (data) {
						noty({
							  text: "Se ha enviado el pedido a sesion de impresion",
							  type:data,
							  layout:"topRight",
							  closeWith: ['click', 'hover']
						});
						response(data);
					}
				}); 
			  
		  }
		  
		  function cargarPedido(numeroPedido){
			  $("#task").val('<%= SISINVConstants.PEDIDO_TASKS.LOAD_PEDIDO %>');
			  $("#pedidoId").val(numeroPedido);
			  $("#buscarForm").submit();
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
                                <i class="fa fa-search"></i> Buscar pedidos
                            </li>
                        </ol>
                    </div>
                </div>
				<!-- End Page Heading -->
				
				 <form id="buscarForm" role="form" action="PedidoAction" method="POST">
				 	<!-- row -->
					<div class="row">
					 	<input type="hidden" value="buscar" name="task" id="task"/>
					 	<input type="hidden" value="" name="pedidoId" id="pedidoId"/>
					 	<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Nombre o número de pedidos</label>
                                <input class="form-control" placeholder="Texto a buscar" name="txtBuscar" value="${nombre}">
                            </div>
                        </div>
					</div>
					<!-- end row -->
					<!-- row -->
					<div class="row">
						<div class="col-lg-4">
                        	<div class="form-group">
                                <label>Fecha inicio</label>
                                <input class="form-control" name="fechaInicio" id="fechaInicio" value="${fechaInicio}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                        	<div class="form-group">
                                <label>Fecha final</label>
                                <input class="form-control" name="fechaFinal" id="fechaFinal" value="${fechaInicio}">
                            </div>
                        </div>
					</div>
					<!-- end row -->
					<button type="submit" class="btn btn-info" >Buscar</button>
				</form>	
					 <!-- row -->
					 <div class="row">
					 	<div class="col-lg-24">
					 		<div class="panel-heading">
					 			<h3 class="panel-title"><i class="fa fa-shopping-cart fa-fw"></i> Lista de pedidos</h3>
					 		</div>
					 		<div class="panel-body">
					 			<div class="table-responsive">
					 				 <table class="table table-bordered table-hover table-striped">
                                       <thead>
                                           <tr>
                                               <th># Pedido</th>
                                               <th>Fecha</th>
                                               <th>Cliente</th>
                                               <th>Total</th>
                                               <th>Imprimir</th>
                                               <th>Cargar pedido</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${pedidos}" var="item">
											    <tr>
											      <td><c:out value="${item.id}" /></td>
											      <td><fmt:formatDate pattern="dd/MM/yyyy" value="${item.fecha}" /></td>
											      <td><c:out value="${item.nombre}" /></td>
											      <td><c:out value="${item.total}" /></td>
											      <td><button class='btn btn-info fa fa-print' type='button' onclick='imprimirPedido("${item.id}")'></button></td>
											      <td><button class='btn btn-info fa fa-arrow-circle-o-up' type='button' onclick='cargarPedido("${item.id}")'></button></td>
											    </tr>
											  </c:forEach>
                                       </tbody>
                                      </table>
					 			</div>
					 		</div>
					 	</div>
					 </div>
					 <!-- end row -->
				
				
			</div>
		</div>
	</div>
</body>
</html>