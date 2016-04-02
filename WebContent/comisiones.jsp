<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="css/jquery-ui.css" rel="stylesheet">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/utils.js"></script>
	<script src="js/jquery.noty.packaged.js"></script>
<script type="text/javascript">
	var selUser;
	$(document).ready(function() {
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
				$("#idVendedor").val(ui.item.id);
			}
		})
		.autocomplete( "instance" )._renderItem = function( ul, item ) {
				return $( "<li>" )
				.append( "<a><strong>" + item.label + "</strong><br><i>" + item.usuario + "</i></a>" )
				.appendTo( ul );
		};
		
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
	    
	    $("#crear-pedido").on('click', function() {
	    	$("#task").val("<%= SISINVConstants.TASKS.TASK_BUSCAR %>");
	    	$("#com-form").submit();
	    });
	    
	    $("#pagar-comision").on('click', function() {
	    	$("#task").val("<%= SISINVConstants.REPORT_TYPES.PAGAR_COMISION %>");
	    	$("#com-form").submit();
	    });
	});
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
                                <i class="fa fa-money"></i>  Reporte de comisiones a pagar
                            </li>
                        </ol>
                    </div>
                </div>
				<!-- End Page Heading -->
				<!-- Row -->
				<form role="form" action="ReporteAction" method="POST" id="com-form">
				<input type="hidden" value="<%= SISINVConstants.TASKS.TASK_BUSCAR %>" id="task" name="task">
				<input type="hidden" value="<%= SISINVConstants.REPORT_TYPES.COMISIONES %>" id="tipo" name="tipo">
				<input type="hidden" value="${idVendedor}" id="idVendedor" name="idVendedor">
					<div class="row">
	                	<div class="col-lg-12">
	             		 	<div  class="form-group">
                                <input id="searchVend" class="form-control" type="text" placeholder="Nombre o usuario del vendedor" name="searchVend" value="${searchVend}" >
                            </div>
                        </div>
	                </div>
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
					<button id="crear-pedido" type="button" class="btn btn-info" >Buscar</button>
				
	
				<!-- End Row -->
				 <!-- row -->
					 <div class="row">
					 	<div class="col-lg-24">
					 		<div class="panel-heading">
					 			<h3 class="panel-title"><i class="fa fa-truck fa-fw"></i> Lista de pedidos por usuario</h3>
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
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${pedidos}" var="item">
											    <tr>
											      <td><c:out value="${item.id}" /></td>
											      <td><fmt:formatDate pattern="dd/MM/yyyy" value="${item.fecha}" /></td>
											      <td><c:out value="${item.nombre}" /></td>
											      <td><c:out value="${item.total}" /></td>
											    </tr>
											  </c:forEach>
                                       </tbody>
                                      </table>
					 			</div>
					 		</div>
					 	</div>
					 </div>
					 <div class="row">
                    	<div class="col-lg-24">
                    		<div  class="alert alert-success">
			    				<p id="importe-total">Comision: <c:if test="${empty comision}">0.00</c:if> <c:if test="${not empty comision}">${comision}</c:if></p>
			    			</div>
                    	</div>
                    </div>
                    <button id="pagar-comision" type="submit" class="btn btn-primary" >Pagar</button>
			</div>
		</div>
	</div>
</body>
</html>