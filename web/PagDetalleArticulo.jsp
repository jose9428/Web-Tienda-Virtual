<%@page import="dao.ArticuloDAO"%>
<%@page import="entidad.Articulo"%>
<%@page import="entidad.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>

        <title>Pagina Detalle</title>
    </head>
    <%
        HttpSession sesion = request.getSession();
        Articulo a = null;
        int code = 1;
        String categoria = "", imagenCat = "";
        if (sesion.getAttribute("codeArticulo") != null) {
            code = Integer.parseInt(sesion.getAttribute("codeArticulo").toString());
            ArticuloDAO objArticulo = new ArticuloDAO();
            a = objArticulo.DetalleArticulo(code);
            categoria = (String) sesion.getAttribute("categoria");
            imagenCat = (String) sesion.getAttribute("imagen");
        } else {
            response.sendRedirect("PagProductos.jsp");
        }

    %>
    <body class="homepage">
        <%            if (sesion.getAttribute("logeadoCliente") == null) {
        %>
        <%@include file="jspf/NavegacionProductos.jsp" %>
        <%
        } else {
        %>
        <%@include file="jspf/NavegacionProductosCliente.jsp" %>
        <%            }
        %>

        <section id="feature">
            <div class="row">
                <div class="col-xs-12 col-sm-10 col-sm-offset-1 fadeInDown">
                    <div class="tab-wrap">
                        <div class="media">
                            <div class="parrent pull-left">
                                <ul class="nav nav-tabs nav-stacked">
                                    <li class="btn btn-primary">Categorias</li>
                                    <li ><a href="PagProductos.jsp">Todos</a></li>
                                        <%                                            String clase;
                                            CategoriaDAO objCategoria = new CategoriaDAO();
                                            for (Categoria c : objCategoria.ListadoCategoria()) {
                                                clase = "";
                                                if (c.getNombreCategoria().equals(categoria)) {
                                                    clase = "background: #F9DA78;";
                                                }
                                        %>
                                    <li style="<%=clase%>"><a href="ControllerCarrito?accion=IrPaginaListarArticuloCategoria&code=<%=c.getCodigoCategoria()%>&categoria=<%=c.getNombreCategoria()%>" data-toggle="" ><%=c.getNombreCategoria()%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </div>


                            <div class="parrent media-body">
                                <div class="content">

                                    <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 my-4 mx-auto text-center">

                                        <div class="inner-meta">
                                            <div class="social-btns">
                                                <a href="#" class="facebook-bg"> 
                                                    <div class="inner-meta">
                                                        <h1 style="color: #ffffff;">Detalle Articulo</h1>
                                                    </div>
                                                </a>
                                            </div>
                                            <br>
                                        </div>
                                    </div>

                                    <hr />
                                    <div class="col-md-12">
                                        <div class="container">

                                            <div class="row contact-wrap"> 
                                                <form  class="contact-form" action="ControllerCarrito" method="GET">
                                                    <div class="col-sm-5">
                                                        <div class="form-group">
                                                            <img src="img/picture/<%=a.getImagenArticulo()%>" width="100%"  height="600">
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-5 col-sm-offset-1">
                                                        <div class="form-group">
                                                            <div class="large-title text-center">   
                                                                <!--   <img src="img/icon/logoSesion.png" width="25%"> -->
                                                                <img src="img/picture/<%=imagenCat %>"  width="45%" class="img-thumbnail"
                                                                     onerror="src='img/icon/logoSesion.png' ">
                                                            </div> 
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group row">
                                                                    <label class="col-sm-4 col-form-label">Articulo</label>
                                                                    <div class="col-sm-8">
                                                                        <input type="text" class="form-control" value="<%=a.getNombreArticulo()%>" readonly="">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group row">
                                                                    <label class="col-sm-4 col-form-label">Precio</label>
                                                                    <div class="col-sm-8">
                                                                        <input type="text" class="form-control" value="<%=a.getPrecioArticulo()%>" readonly="">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group row">
                                                                    <label class="col-sm-4 col-form-label">Cantidad</label>
                                                                    <div class="col-sm-8">
                                                                        <input type="number" name="cantidad" class="form-control" min="1" maxlength="3" value="1" required="">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="form-group row">
                                                                <input type="hidden" name="codigo" value="<%=a.getCodigoArticulo()%>">
                                                                <input type="hidden" name="accion" value="AñadirCarrito">
                                                                <button class="btn btn-success">
                                                                    <i class="fa fa-truck"> </i>
                                                                    Añadir al Carrito
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                        </div>
                                    </div>       
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <section id="feature">
                <div class="row">
                    <div class="col-xs-12 col-sm-10 col-sm-offset-1 fadeInDown">
                        <div>
                            <h1><b>Descripcion</b></h1>
                            <hr />
                            <h3>
                                <p>
                                    <%=a.getDescripcionArticulo()%>
                                </p>
                            </h3>
                        </div>
                    </div>
                </div>
            </section>

        </section>
        <%@include file="jspf/Footer.jsp" %>
        <%@include file="jspf/JsScript.jsp" %>
    </body>
</html>
