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

        <title>Pagina Productos</title>
    </head>
    <%
        HttpSession sesion = request.getSession();
        int code = 1;
        String categoria = "";
        if (sesion.getAttribute("codeCategoria") != null) {
            code = Integer.parseInt(sesion.getAttribute("codeCategoria").toString());
            categoria = new CategoriaDAO().NombreCateg(code).trim();
        }
    %>
    <body class="homepage">
        <%
            if (sesion.getAttribute("logeadoCliente") == null) {
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
                                        <%
                                            String clase, estilo;
                                            CategoriaDAO objCategoria = new CategoriaDAO();
                                            for (Categoria c : objCategoria.ListadoCategoria()) {
                                                clase = "";
                                                estilo = "";
                                                if (c.getNombreCategoria().trim().equals(categoria)) {
                                                    clase = "background: #F9DA78;";
                                                }
                                        %>
                                    <li  style="<%=clase%>"><a href="ControllerCarrito?accion=IrPaginaListarArticuloCategoria&code=<%=c.getCodigoCategoria()%>" data-toggle="" ><%=c.getNombreCategoria()%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </div>


                            <div class="parrent media-body">
                                <div class="content">
                                    <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 my-4 mx-auto text-center">
                                        <h1 class="display-4 mt-4"><%=categoria %></h1>
                                    </div>
                                    <%
                                        ArticuloDAO objArticulo = new ArticuloDAO();
                                        for (Articulo a : objArticulo.ListadoArticuloDisponible2(code)) {
                                    %>
                                    <div class="col-md-4">
                                        <br>
                                        <div class="card-body  text-center ">
                                            <div class="recent-work-wrap">
                                                <img src="img/picture/<%=a.getImagenArticulo()%>" class="card-img-top" width="290px" height="290px">
                                                <div class="overlay">
                                                    <div class="recent-work-inner">
                                                        <a class="preview" href="img/picture/<%=a.getImagenArticulo()%>" rel="prettyPhoto"><i class="fa fa-plus"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-header">
                                                <h4 class="my-0 font-weight-bold"><%=a.getNombreArticulo()%></h4>
                                            </div>
                                            <h2 class="card-title pricing-card-title precio">S/. <span class=""><%=a.getPrecioArticulo()%></span></h2>

                                            <a href="ControllerCarrito?accion=IrPaginaDetalleArticulo&code=<%=a.getCodigoArticulo()%>"  class="btn btn-block btn-info" data-id="1">Ver detalle</a>
                                            <a href="ControllerCarrito?accion=AñadirCarritoUnidad&code=<%=a.getCodigoArticulo()%>" class="btn btn-block btn-success" data-id="1">Añadir al Carrito</a>
                                        </div>       
                                    </div>       

                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <%@include file="jspf/Footer.jsp" %>
        <%@include file="jspf/JsScript.jsp" %> 
    </body>
</html>
