<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="header.jsp" />
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
                                <i class="fa fa-file-excel-o"></i> Exportar archivo de productos a Excel
                            </li>
                        </ol>
                    </div>
                </div>
				<!-- End Page Heading -->
				<!-- Row -->
				<form role="form" action="ArchivoAction" method="POST" enctype="multipart/form-data">
				<input type="hidden" value="exportar" id="task" name="task">
					<div class="row">
						<div class="col-lg-12">
	             		 	<div class="form-group">
                                <label>Nombre de archivo</label>
                                <input class="form-control" id="txtNombre" name="txtNombre">
                            </div>
                        </div>
					</div>
					<button id="crear-pedido" type="submit" class="btn btn-primary" >Crear</button>
				</form>
				<!-- End Row -->
			</div>
		</div>
	</div>
</body>
</html>