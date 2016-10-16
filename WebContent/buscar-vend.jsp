<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="header.jsp" />
	<script type="text/javascript">
		$(function() {
			$('#tab_vends').DataTable();
		});
		
		function editVendedor(id){
			$("#task").val('<%= SISINVConstants.TASKS.GET_ITEM %>');
			$("#vendId").val(id);
			$("#buscarForm").submit();
		}
		
		function delVendedor(id){
			
			var n = noty({
	            text        : '¿Deseas borrar el vendedor?',
	            type        : 'information',
	            dismissQueue: true,
	            layout      : 'center',
	            theme       : 'defaultTheme',
	            modal		: true,
	            buttons     : [
	                {addClass: 'btn btn-primary', text: 'Si', onClick: function ($noty) {
	                	$("#task").val("borrar");
	        			$("#vendId").val(id);
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
	                                <i class="fa fa-search"></i> Buscar vendedor
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	                
	             
	             <!-- row -->
	             <div class="row">
             		 <form role="form" action="VendedorAction" method="POST" id="buscarForm">
             		 	<input type="hidden" value="buscar" name="task" id="task"/>
             		 	<input type="hidden" value="" name="vendId" id="vendId"/>
             		 	<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Nombre o usuario</label>
                                <input class="form-control" placeholder="Texto a buscar" name="txtBuscar">
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
                               <h3 class="panel-title"><i class="fa fa-users fa-fw"></i> Lista de vendedores</h3>
                           </div>
                           <div class="panel-body">
                               <div class="table-responsive">
                                   <table id="tab_vends" class="table table-bordered table-hover table-striped">
                                       <thead>
                                           <tr>
                                               <th>Identificador</th>
                                               <th>Nombre</th>
                                               <th>Direccion</th>
                                               <th>Telefono</th>
                                               <th>Usuario</th>
                                               <th>Editar</th>
                                               <th>Borrar</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       		 <c:forEach items="${vends}" var="item">
											    <tr>
											      <td><c:out value="${item.id}" /></td>
											      <td><c:out value="${item.nombre}" /></td>
											      <td><c:out value="${item.direccion}" /></td>
											      <td><c:out value="${item.telefono}" /></td>
											      <td><c:out value="${item.usuario}" /></td>
											      <td><button class='btn btn-info fa fa-edit' type='button' onclick='editVendedor("${item.id}")'></button></td>
											      <td><button class='btn btn-info fa fa-trash' type='button' onclick='delVendedor("${item.id}")'></button></td>
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
	</div>
</body>
</html>