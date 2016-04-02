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
	                                <i class="fa fa-pencil-square"></i>  Editar vendedor
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	             <!-- row -->
	             <form role="form" action="VendedorAction" method="POST">
	             	<input type="hidden" value="editar" name="task"/>
	             	<input type="hidden" value="${vend.id}" name="id"/>
		             
			         <jsp:include page="campos-vend.jsp" />
		         	<button type="submit" class="btn btn-primary" >Guardar</button>
		         </form>
	          </div>
			</div>
		</div>
	</div>
</body>
</html>