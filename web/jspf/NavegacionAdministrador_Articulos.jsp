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
                    <li ><a href="PagAdministrador.jsp">Inicio</a></li>

                    <li class="dropdown active">
                        <a  class="dropdown-toggle" data-toggle="dropdown">Administrar <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu">
                            <li ><a href="PagAgregarCategoria.jsp">Categorias</a></li>
                            <li class="active">

                                <a href="PagListaArticulos.jsp">Articulos</a>
                            </li>
                        </ul>
                    </li>

                    <li ><a href="PagCompraClientes.jsp">Compras</a></li>
                    <li><a href="PagClientes.jsp">Clientes</a></li>

                    <li class="dropdown">
                        <a  class="dropdown-toggle" data-toggle="dropdown">Mi Cuenta <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu ">
                            <li><a >Jorge Quispe Guevara</a></li>
                            <li><a href="ControllerAdministrador?accionAdmi=CerrarSesion">Cerrar Sesion</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!--/.container-->
    </nav>
    <!--/nav-->

</header>