<%@page import="entidad.Venta"%>
<%@page import="dao.VentaDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>

        <title>Pagina Admnistrador</title>
    </head>

    <body >
        <%@include file="jspf/NavegacionAdministrador.jsp" %>

        <section id="bottom">
            <div class="container">

                <div class="row">
                    <div class="card">
                        <div class="col-sm-6 col-md-4">
                            <div class="media services-wrap fadeInDown">
                                <div class="pull-left">
                                    <img class="img-responsive" src="img/icon/clientes.png" width="80px">
                                </div>
                                <div class="media-body">
                                    <h2 class="media-heading">Clientes</h2>
                                    <h1 id="cantClientes"><strong></strong></h1>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 col-md-4">
                        <div class="media services-wrap fadeInDown">
                            <div class="pull-left">
                                <img class="img-responsive" src="img/icon/pedidos12.png" width="80px">
                            </div>
                            <div class="media-body">
                                <h2 class="media-heading">Pedidos</h2>
                                <h1 id="cantPedidos"><strong></strong></h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/.row-->
            <div class="container">
                <br>
                <div  style="background-color: #0066ff">
                    <%
                        Calendar calen = Calendar.getInstance();
                        int actual = calen.get(Calendar.YEAR);
                    %>
                    <h1 class="text-center" style="color: #ffffff;">RESUMEN DE VENTAS DEL AÑO <%=actual%></h1>
                </div>
                <br>
                <table class="table" >
                    <thead style="background-color: #245269;color: #ffffff; " >
                        <tr > 
                            <th style="text-align: center;">Año</th>
                            <th style="text-align: center;">Mes</th>
                            <th style="text-align: center;">Total</th>
                        </tr>
                    </thead>
                    <tbody style="background: #ffffff;" class="table text-center">
                        <%
                            ArrayList<Venta> lista = new VentaDAO().ListaResumenVentas();

                            for (Venta t : lista) {
                        %>
                        <tr>
                            <td><%=t.getAnio()%></td>
                            <td><%=t.getMes()%></td>
                            <td><%=t.getSumaTotal()%></td>
                        </tr>
                        <%
                            }

                        %>

                    </tbody>
                </table>
            </div>
        </div>
        <!--/.container-->
    </section>
    <%@include file="jspf/Footer.jsp" %>
    <%@include file="jspf/JsScript.jsp" %>
    <%@include file="jspf/Alerta.jsp" %>
</body>

<script type="text/javascript">
    $(function () {
        $.ajax({
            url: "ControllerAdministrador",
            type: 'POST',
            data: {
                accionAdmi: 'CantRegistrosInicio'
            },
            success: function (data, textStatus, jqXHR) {

                var array = data.split("-");
                $("#cantClientes").html(array[0]);
                $("#cantPedidos").html(array[1]);
            }
        });
    });
</script>
</html>
