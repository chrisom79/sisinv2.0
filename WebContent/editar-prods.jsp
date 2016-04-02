<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
	$(document).ready(function() {
		
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
                                <i class="fa fa-plus-square"></i>  Editar productos
                            </li>
                        </ol>
                    </div>
                </div>
             <!-- row -->
             <form role="form" action="ProductoAction" method="POST">
             	<input type="hidden" value="editar" name="task"/>
             	<input type="hidden" value="${prod.id}" name="prevId"/>
	            <jsp:include page="campos_prods.jsp" />
	            <button type="submit" class="btn btn-primary" >Guardar</button>
	         </form>
          </div>
		</div>
	</div>
</body>
</html>