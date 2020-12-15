<%@page import="java.util.Calendar"%>
<%
Calendar calendario = Calendar.getInstance();
int anioActual = calendario.get(Calendar.YEAR);
%>

<footer id="footer" class="midnight-blue">
    <div class="container">
        <div class="row">
            <div class="col-sm-10">
                &copy; <%=anioActual %><a> Carrito de compras</a>. Todos los derechos reservados
            </div>
            <div class="col-sm-2">
                <img src="img/ico/Carrito.svg" width="32%">
        </div>
    </div>
</footer>