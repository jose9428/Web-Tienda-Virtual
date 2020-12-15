<%@page import="entidad.Cliente"%>
<%
    HttpSession sesionCli = request.getSession();
    String nombresCli = "";
    if (sesionCli.getAttribute("logeadoCliente") != null) {

        Cliente cli = (Cliente) sesionCli.getAttribute("logeadoCliente");
        nombresCli = cli.getNombres() + " , " + cli.getApePaterno() + " " + cli.getApeMaterno();
    }
%>

<header id="header">

    <nav class="navbar navbar-inverse" role="banner">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Barra de Navegacion</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand"><img src="img/icon/tienda.png"></a>
            </div>

            <div class="collapse navbar-collapse navbar-right">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="index.jsp">Inicio</a></li>
                    <li ><a href="PagProductos.jsp">Articulos</a></li>
                    <li><a href="ControllerCarrito?accion=IrListaCarrito">Carrito</a></li>
                    <li ><a href="PagMisPedidos.jsp">Mis Pedidos</a></li>
                    <li class="dropdown">
                        <a  class="dropdown-toggle" data-toggle="dropdown">Mi Cuenta <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:void(0)"><%=nombresCli%></a></li>
                            <li><a href="ControllerCliente?accionCliente=CerrarSesion">Cerrar Sesion</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!--/.container-->
    </nav>
    <!--/nav-->

</header>