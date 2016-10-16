<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
           <ul id='left-menu' class="nav navbar-nav side-nav">
               <li id="home">
                   <a href="home.jsp"><i class="fa fa-fw fa-desktop"></i> Inicio</a>
               </li>
               
               <li>
                   <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-pedidos"><i class="fa fa-fw fa-truck"></i> Pedidos<i class="fa fa-fw fa-caret-down"></i></a>
                   <ul id="mngmt-pedidos" class="collapse">
                       <li id="crear_pedido">
                           <a href="crear-pedido.jsp">Crear</a>
                       </li>
                       <li id="buscar_pedido">
                           <a href="buscar-pedido.jsp">Buscar</a>
                       </li>
                   </ul>
               </li>
               
               <li>
                   <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-prods"><i class="fa fa-fw fa-dropbox"></i> Productos<i class="fa fa-fw fa-caret-down"></i></a>
                   <ul id="mngmt-prods" class="collapse">
                       <li id="cread_prod">
                           <a href="crear-prods.jsp">Agregar</a>
                       </li>
                       <li id="buscar_prod">
                           <a href="buscar-prods.jsp" id="bscrprods">Buscar</a>
                       </li>
                   </ul>
               </li>
               
               <li>
                   <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-users"><i class="fa fa-fw fa-users"></i> Vendedores<i class="fa fa-fw fa-caret-down"></i></a>
                   <ul id="mngmt-users" class="collapse">
                       <li id="crear-vend">
                           <a href="crear-vend.jsp">Agregar</a>
                       </li>
                       <li id="buscar-vend">
                           <a href="buscar-vend.jsp">Buscar</a>
                       </li>
                   </ul>
               </li>
               <li>
                   <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-ofertas"><i class="fa fa-fw fa-star"></i> Ofertas<i class="fa fa-fw fa-caret-down"></i></a>
                   <ul id="mngmt-ofertas" class="collapse">
                        <li id="crear_oferta">
                           <a href="crear-oferta.jsp">Crear</a>
                       </li>
                       <li id="buscar_oferta">
                           <a href="buscar-oferta.jsp">Buscar</a>
                       </li>
                   </ul>
               </li>
               <li>
                   <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-files"><i class="fa fa-fw fa-file"></i> Archivos<i class="fa fa-fw fa-caret-down"></i></a>
                   <ul id="mngmt-files" class="collapse">
                       <li id="importar">
                           <a href="imp-archivo.jsp">Importar productos</a>
                       </li>
                       <li id="exportar">
                           <a href="exp-archivo.jsp">Exportar productos</a>
                       </li>
                   </ul>
               </li>
               <li>
                   <a href="javascript:;" data-toggle="collapse" data-target="#mngmt-reports"><i class="fa fa-fw fa-bar-chart"></i> Reportes<i class="fa fa-fw fa-caret-down"></i></a>
                   <ul id="mngmt-reports" class="collapse">
                       <li id="comisiones">
                           <a href="comisiones.jsp">Comisiones</a>
                       </li>
                       <!-- <li id="facturacion">
                           <a href="facturacion.jsp">Facturación</a>
                       </li> -->
                   </ul>
               </li>
           </ul>
       </div>
       <!-- /.navbar-collapse -->
   </nav>
 </div>