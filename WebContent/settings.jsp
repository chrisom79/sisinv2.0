<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="header.jsp" />
	
	<script  type="text/javascript">
		var selected = null;
		var sum;
		$(document).ready(function() {
			$(window).keydown(function(event){
				if(event.keyCode == 13) {
					event.preventDefault();
					return false;
				}
			});
		    
		    $("#acc_ajustes").accordion({
		        heightStyle: "content"
		    });
		    
		    $("#txtNvoPass").tooltipster({ 
		    	trigger : 'custom', 
		    	onlyOne : false, 
		    	position : 'right' 
		    });
		    
		    $("#txtConfNvoPass").tooltipster({ 
		    	trigger : 'custom', 
		    	onlyOne : false, 
		    	position : 'right' 
		    });
		    
		    $("#form-settings").validate({
		    	rules: {
		    		txtNvoPass: "required",
		    		txtConfNvoPass: {
		    			equalTo: "#txtNvoPass"
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
		    
		    $("#cambiar-pass").on("click", function(){
		    	$("#task").val("<%= SISINVConstants.SETTINGS_TASKS.CAMBIAR_PASSWORD %>");
		    	$("#form-settings").submit();
		    })
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
	                                <i class="fa fa-cog"></i>  Ajustes
	                            </li>
	                        </ol>
	                    </div>
	                </div>
	             <!-- row -->
	             <form id="form-settings" role="form" action="SettingsAction" method="POST">
	             	<input type="hidden" value="" id="task" name="task"/>           	
	                <div id="acc_ajustes">
	                	<h3>Cambiar password</h3>
	                	<div>
				         	<div class="row">
	             		 		<div class="col-lg-8">
		             		 		<div class="form-group">
	                                	<label>Nuevo password</label>
	                                	<input type="password" class="form-control" id="txtNvoPass" name="txtNvoPass">
	                            	</div>
	                        	</div>
				         	</div>
				         	<div class="row">
	             		 		<div class="col-lg-8">
		             		 		<div class="form-group">
	                                	<label>Confirma nuevo password</label>
	                                	<input type="password" class="form-control" id="txtConfNvoPass" name="txtConfNvoPass">
	                            	</div>
	                        	</div>
	                        
				         	</div>
				         	<div class="row">
	             		 		<div class="col-lg-4">
				         			<button id="cambiar-pass" type="button" class="btn btn-primary" >Cambiar</button>
				         		</div>
				         	</div>
				     	</div>
			    	</div>
			    	<br/>
		         </form>
	          </div>
			</div>
		</div>
</body>
</html>