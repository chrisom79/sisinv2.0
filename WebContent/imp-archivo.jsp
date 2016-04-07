<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="header.jsp" />
<title>SISINV 2.0</title>
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
                                <i class="fa fa-file-excel-o"></i> Importar archivo de productos
                            </li>
                        </ol>
                    </div>
                </div>
				<!-- End Page Heading -->
				<!-- Row -->
				<form role="form" action="ArchivoAction" method="POST" enctype="multipart/form-data">
					<input type="hidden" value="importar" id="task" name="task">
					<div class="row">
						<div class="form-group">
	                        <label>File input</label>
	                        <input type="file" id="file" name="file" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
	                    </div>
					</div>
					<button id="crear-pedido" type="submit" class="btn btn-primary" >Importar</button>
				</form>
				<!-- End Row -->
			</div>
		</div>
	</div>
</body>
</html>