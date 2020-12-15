<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>

        <title>Inicio</title>
    </head>
    <body class="homepage">
        <%

            HttpSession sesion = request.getSession();

            if (sesion.getAttribute("logeadoCliente") == null) {
        %>
        <%@include file="jspf/NavegacionInicio.jsp" %>
        <%
        } else {
        %>
        <%@include file="jspf/NavegacionInicioCliente.jsp" %>
        <%            }

        %>

        <div >
            <section id="main-slider" class="no-margin">
                <div class="carousel slide">
                    <ol class="carousel-indicators">
                        <li data-target="#main-slider" data-slide-to="0" class="active"></li>
                        <li data-target="#main-slider" data-slide-to="1"></li>
                        <li data-target="#main-slider" data-slide-to="2"></li>
                        <li data-target="#main-slider" data-slide-to="3"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="item active" style="background-image: url(img/portada/05.jpg)">
                        </div>

                        <div class="item" style="background-image: url(img/portada/07.jpg)">
                        </div>

                        <div class="item active" style="background-image: url(img/portada/06.jpg)">
                        </div>

                        <div class="item" style="background-image: url(img/portada/08.jpg)">
                        </div>

                    </div>
                    <!--/.carousel-inner-->
                </div>
                <!--/.carousel-->
                <a class="prev hidden-xs hidden-sm" href="#main-slider" data-slide="prev">
                    <i class="fa fa-chevron-left"></i>
                </a>
                <a class="next hidden-xs hidden-sm" href="#main-slider" data-slide="next">
                    <i class="fa fa-chevron-right"></i>
                </a>
            </section>
        </div>



        <%@include file="jspf/JsScript.jsp" %>
        <%@include file="jspf/Footer.jsp" %>
    </body>
</html>
