<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="header.jsp" />
<script type="text/javascript">
	$(document).ready(function() {
		 $("#form-prod input[class='form-control']").tooltipster({ 
	    	trigger : 'custom', 
	    	onlyOne : false, 
	    	position : 'right' 
	    });
		 
		 $("#form-prod").validate({
	    	rules : {
	    		txtCodigo : {
	    			required : true
	    		},
	    		txtNombre : {
	    			required : true
	    		},
	    		txtPrecioComp : {
	    			required : true,
	    			number : true
	    		},
	    		txtGanancia : {
	    			required : true,
	    			number : true
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
                                <i class="fa fa-plus-square"></i>  Editar productos
                            </li>
                        </ol>
                    </div>
                </div>
             <!-- row -->
             <form id="form-prod" role="form" action="ProductoAction" method="POST">
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