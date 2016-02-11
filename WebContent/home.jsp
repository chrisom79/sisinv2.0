<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script  type="text/javascript">
		$(document).ready(function() {
			$.ajax({
				url:"PedidoAction",
				type:"GET",
				data:{
					task : "specific"
				},
				dataType: "json",
				success : function (data) {

					var monthNames = [
					  "Ene", "Feb", "Mar",
					  "Abr", "May", "Jun", "Jul",
					  "Ago", "Sep", "Oct",
					  "Nov", "Dic"
					];
					
					$.map(data, function(m){
						var originDate = new Date(m.fecha);
						var formatDate = originDate.getDate() + "/" + monthNames[originDate.getMonth()] + "/" + originDate.getFullYear();
						$("#last-pedidos > tbody:last-child").append("<tr>"+
			        			  "<td id='t-cantidad'>"+ m.id +"</td>"
			        			  +"<td>"+ formatDate +"</td>"
			        			  +"<td>"+ m.nombre +"</td>"
			        			  +"<td>"+ m.total+"</td>"
			        			  +"</tr>");
					});
					
					
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
                                <i class="fa fa-desktop"></i> Inicio
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
				
				<!-- row -->
	             <c:if test="${not empty mensaje}">
	             <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <i class="fa fa-info-circle"></i>  <c:out value="${mensaje}" />
                        </div>
                    </div>
                </div>
	             </c:if>
	             <c:if test="${not empty error}">
	             <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-danger alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <i class="fa fa-info-circle"></i>  <c:out value="${error}" />
                        </div>
                    </div>
                </div>
	             </c:if>
	             
                <div class="row">
                	<div class="col-lg-6 col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-truck fa-5x"></i>
                                    </div>
                                    <div class="col-xs-18 text-right">
                                        <div>Pedidos</div>
                                    </div>
                                </div>
                            </div>
                            <a href="crear-pedido.jsp">
                                <div class="panel-footer">
                                    <span class="pull-left">Crear</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    
                    <div class="col-lg-6 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-dropbox fa-5x"></i>
                                    </div>
                                    <div class="col-xs-18 text-right">
                                        <div>Productos</div>
                                    </div>
                                </div>
                            </div>
                            <a href="buscar-prods.jsp">
                                <div class="panel-footer">
                                    <span class="pull-left">Buscar</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    
                    <div class="col-lg-6 col-md-6">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i>
                                    </div>
                                    <div class="col-xs-18 text-right">
                                        <div>Vendedores</div>
                                    </div>
                                </div>
                            </div>
                            <a href="buscar-vend.jsp">
                                <div class="panel-footer">
                                    <span class="pull-left">Buscar</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-24">
                        <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-truck fa-fw"></i> Ultimos pedidos</h3>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table id="last-pedidos" class="table table-bordered table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th># Pedido</th>
                                                <th>Fecha</th>
                                                <th>Cliente</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                    </div>
                </div>
                <!-- /.row -->

                
                  
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    
</body>
</html>