<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script language="JavaScript" type="text/javascript"  src="js/jquery.js"></script>
	<script  type="text/javascript">
	$(document).ready(function() {
		$("#chkIVA").on('click', function(){
			if($('#chkIVA:checked').length > 0) {
				$("#chkIVA").val(true);
			} else {
				$("#chkIVA").val(false);
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
	                                <i class="fa fa-plus-square"></i>  Agregar productos
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	             <!-- row -->
	             <form role="form" action="ProductoAction" method="POST">
	             	<input type="hidden" value="crear" name="task"/>
		             <div class="row">
             		 	<div class="col-lg-8">
	             		 	<div class="form-group">
                                <label>Código</label>
                                <input class="form-control" name="txtCodigo">
                            </div>
                        </div>
			         </div>
			         <div class="row">
             		 	<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Nombre</label>
                                <input class="form-control" name="txtNombre">
                            </div>
                        </div>
			         </div>
			         <div class="row">
             		 	<div class="col-lg-5">
             		 		<label>Precio compra</label>
	             		 	<div class="form-group input-group">
                                <span class="input-group-addon">$</span>
                                <input type="text" class="form-control" name="txtPrecioComp">
                            </div>
                        </div>
                        <div class="col-lg-3">
                        	<label>Ganancia</label>
	             		 	<div class="form-group input-group">
	             		 		
                                <span class="input-group-addon">%</span>
                                <input type="text" class="form-control" name="txtGanancia">
                            </div>
                        </div>
                        <div class="col-lg-3">
	             		 	<div class="form-group">
	             		 		<label>
                                    <input id="chkIVA" type="checkbox" value="" name="txtIVA">IVA
                                </label>
                            </div>
                        </div>
			         </div>
		         	<button type="submit" class="btn btn-default" >Crear</button>
		         </form>
	          </div>
			</div>
		</div>
	</div>
</body>
</html>