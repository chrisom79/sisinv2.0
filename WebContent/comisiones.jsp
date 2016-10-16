<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="header.jsp" />
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
	    	var list = "";
	    	$("#list-pedidos > tbody > tr[class!='selected']").each(function(i, row) {
	    		list += $(row).find("td[id*='t-id']").text() + ",";
	    	});
	    	$("#comision-pedido").val(list);
	    	$("#com-form").submit();
	    });
	    
	    $("#com-form input[type='text']").tooltipster({ 
	    	trigger : 'custom', 
	    	onlyOne : false, 
	    	position : 'right' 
	    });
		 
		 $("#com-form").validate({
	    	rules : {
	    		searchVend : {
	    			required : true
	    		},
	    		fechaInicio : {
	    			required : true
	    		},
	    		fechaInicio : {
	    			required : true
	    		}
	    	},
	    	 errorPlacement: function (error, element) {
	             $(element).tooltipster('update', $(error).text());
	             $(element).tooltipster('show');
	         },
	         success: function (label, element) {
	             $(element).tooltipster('hide');
	         }
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
				<input type="hidden" value="" id="comision-pedido" name="comision-pedido">
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
                                <input type="text" class="form-control" name="fechaInicio" id="fechaInicio" value="${fechaInicio}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                        	<div class="form-group">
                                <label>Fecha final</label>
                                <input type="text" class="form-control" name="fechaFinal" id="fechaFinal" value="${fechaInicio}">
                            </div>
                        </div>
					</div>
					<button id="crear-pedido" type="button" class="btn btn-info" >Buscar</button>
				
	
				<!-- End Row -->
				 <!-- row -->
					 <div class="row">
					 	<div class="col-lg-24">
					 		<div class="panel-heading">
					 			<h3 class="panel-title"><i class="fa fa-truck fa-fw"></i> Lista de productos por pedido</h3>
					 		</div>
					 		<div class="panel-body">
					 			<div class="table-responsive">
					 				 <table class="table table-bordered table-hover table-striped" id="list-pedidos">
                                       <thead>
                                           <tr>
                                               <th>No. Pedido</th>
                                               <th>Codigo</th>
                                               <th>Descripcion</th>
                                               <th>Cantidad</th>
                                               <th>Total</th>
                                               <th>Comision</th>
                                               <th>Pagado</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${items}" var="item">
											    <tr id="${item.id}" <c:if test="${not empty item.pagoComision}">class="selected"</c:if>>
											    <td><c:out value="${item.pedidoNo}" /></td>
											    <td id="t-id"><c:out value="${item.id}" /></td>
										      	<td><c:out value="${item.articulo}" /></td>
											    <td><c:out value="${item.cantidad}" /></td>
											      <td><c:out value="${item.importe}" /></td>
											      <td><c:out value="${item.comision}" /></td>
											      <td><c:if test="${not empty item.pagoComision}"><i class="fa fa-check fa-fw"></i></c:if></td>
											    </tr>
											  </c:forEach>
                                       </tbody>
                                      </table>
					 			</div>
					 		</div>
					 	</div>
					 </div>
					 <c:if test="${fn:length(items) gt 0}">
					 <div class="row">
                    	<div class="col-lg-24">
                    		<div  class="alert alert-success">
			    				<p id="importe-total">Comision: <c:if test="${empty comision}">0.00</c:if> <c:if test="${not empty comision}">${comision}</c:if></p>
			    			</div>
                    	</div>
                    </div>
                    <button id="pagar-comision" type="submit" class="btn btn-primary" >Pagar</button>
                    </c:if>
			</div>
		</div>
	</div>
</body>
</html>