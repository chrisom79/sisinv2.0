<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chrisom.sisinv.utils.SISINVConstants"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<jsp:include page="header.jsp" />
</head>
<body>
	<div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
				<div class="row">
					<h1 class="page-header">Login</h1>
					<!-- Main Form -->
					<div class="col-lg-6">
					</div>
					<div class="col-lg-12">
						<form id="login-form" role="form" action="LoginAction" method="POST">
							<div class="login-form-main-message">${message}</div>
							<div class="row">
		             			<div class="col-lg-12">
			             		 	<div class="form-group">
		                                <label>Usuario</label>
		                                <input class="form-control" name="txtUsuario" placeholder="usuario">
		                            </div>  
		                        </div>
		                    </div>
		                    <div class="row">
		             			<div class="col-lg-12">
			             		 	<div class="form-group">
		                                <label>Password</label>
		                                <input class="form-control" name="txtPassword" placeholder="password">
		                            </div>  
		                        </div>
		                    </div>
		                    <button type="submit" class="btn btn-info">Acceder</button>
							<div class="etc-login-form">
								<p>¿Olvidaste tu password? <a href="#">click aquí</a></p>								
							</div>
						</form>
					</div>
					<div class="col-lg-6">
					</div>
					<!-- end:Main Form -->
				</div>
			</div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
</body>
</html>