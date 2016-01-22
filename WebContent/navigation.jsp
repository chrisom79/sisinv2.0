<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SISINV - Abarrotera Hermanos Cervantes</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/plugins/morris.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css/jquery-ui.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<!-- jQuery -->
    <script language="JavaScript" type="text/javascript"  src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>
    <script src="js/jquery.js"></script>
    <script src="js/jquery-ui.js"></script>
	<script src="js/typeahead.jquery.js"></script>
	<script src="js/typeahead.bundle.js"></script>
</head>

<body>
	<div id="wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="home.jsp">SISINV Abarrotes Hermanos Cervantes</a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu alert-dropdown">
                        <li>
                            <a href="#">Alert Name <span class="label label-default">Alerta</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-primary">Alerta</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-success">Alerta</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-info">Alerta</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-warning">Alerta</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-danger">Alerta</span></a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">View All</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> Juan Cervantes <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#"><i class="fa fa-fw fa-user"></i> Perfil</a>
                        </li>
                
                        <li>
                            <a href="#"><i class="fa fa-fw fa-gear"></i> Ajustes</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li class="active">
                        <a href="home.jsp"><i class="fa fa-fw fa-desktop"></i> Inicio</a>
                    </li>
                    <li>
                        <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-prods"><i class="fa fa-fw fa-dropbox"></i> Productos<i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="mngmt-prods" class="collapse">
                            <li>
                                <a href="crear-prods.jsp">Agregar</a>
                            </li>
                            <li>
                                <a href="buscar-prods.jsp" id="bscrprods">Buscar</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-pedidos"><i class="fa fa-fw fa-truck"></i> Pedidos<i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="mngmt-pedidos" class="collapse">
                            <li>
                                <a href="crear-pedido.jsp">Crear</a>
                            </li>
                            <li>
                                <a href="#">Buscar</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-users"><i class="fa fa-fw fa-users"></i> Vendedores<i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="mngmt-users" class="collapse">
                            <li>
                                <a href="crear-vend.jsp">Agregar</a>
                            </li>
                            <li>
                                <a href="buscar-vend.jsp">Buscar</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>
      </div>
</body>
</html>