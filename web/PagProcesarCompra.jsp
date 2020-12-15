
<%@page import="entidad.Cliente"%>
<%@page import="dao.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <title>Pagina Carrito</title>
    </head>

    <%
        HttpSession sesion = request.getSession();
        Cliente c = null;
        String nombres = "";
        String direccion = "";
        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagIniciarSesion.jsp");
        } else {
            c = (Cliente) sesion.getAttribute("logeadoCliente");
            nombres = c.getNombres() + " , " + c.getApePaterno() + " " + c.getApeMaterno();
            direccion = c.getDireccion();
        }
    %>

    <body class="homepage" onload="CargarCarrito()">

        <%
            if (sesion.getAttribute("logeadoCliente") == null) {
        %>
        <%@include file="jspf/NavegacionCarrito.jsp" %>
        <%
        } else {
        %>
        <%@include file="jspf/NavegacionCarritoCliente.jsp" %>
        <%            }

        %>
        <br>
        <input type="hidden" id="nome" name="nome" value="<%=nombres%>">
        <div id="ListaCarrito">
        </div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="bootbox/bootbox.min.js" type="text/javascript"></script>
        <!-- <%@include file="jspf/JsScript.jsp" %> -->
        <%@include file="jspf/Alerta.jsp" %>
    </body>
    <script type="text/javascript">
        function Comprar() {

            var dateValue = sumarDias(new Date(), 7);
            var M = "" + (dateValue.getMonth() + 1);
            var MM = "0" + M;
            MM = MM.substring(MM.length - 2, MM.length);
            var D = "" + (dateValue.getDate());
            var DD = "0" + D;
            DD = DD.substring(DD.length - 2, DD.length);

            var YYYY = "" + (dateValue.getFullYear());

            var FechaEntrega = (DD + "/" + MM + "/" + YYYY);

            $.ajax({
                type: 'POST',
                url: "ControllerCarrito",
                data: {
                    accion: "ProcesarCarrito"
                },
                success: function (result) {
                    var dialog = bootbox.dialog({
                        title: '<strong>Mensaje del Sistema</strong>',
                        message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
                        buttons: {
                            cancel: {
                                label: '<i class="fa fa-times"></i> Cerrar'
                            }
                        }
                    }).find('.modal-content').css({
                        color: '#081932',
                        font: 'lato sans-serif'
                    });

                    if (result === "") {
                        dialog.init(function () {
                            setTimeout(function () {
                                dialog.find('.bootbox-body').html("A ocurrido un error al momento de registrar el pedido.");
                            }, 2000);
                        });
                    } else {
                        dialog.init(function () {
                            setTimeout(function () {
                                var cadena = "";

                                cadena += "<h4><strong>Se registro correctamente el pedido.</strong> </h4><br>";
                                cadena += "<strong># Factura : </strong>" + result + "</br>";
                                cadena += "<strong>Lugar de entrega : </strong><%=direccion%></br>";
                                cadena += "<strong>Fecha de entrega : </strong>" + FechaEntrega + "</br></br>";
                                cadena += "<a href='PagMisPedidos.jsp' >Ver Pedidos</a>";

                                CargarCarrito();
                                dialog.find('.bootbox-body').html(cadena);
                            }, 2000);
                        });

                    }
                }
            });
        }

        function sumarDias(fecha, dias) {
            fecha.setDate(fecha.getDate() + dias);

            return fecha;
        }

        function ActualizarCarrito(posicion, cantidad) {

            $.ajax({
                type: 'POST',
                url: "ControllerCarrito",
                data: {
                    posicion: posicion,
                    cantidad: cantidad,
                    accion: "ActualizarArticuloCarrito"
                },
                success: function (result) {
                    $("#ListaCarrito").load("PagListaCompra.jsp");
                }
            });
        }

        function VacearCarrito() {
            swal({
                title: 'Eliminar Todo',
                text: "¿Esta Seguro que desea vacear todo el carrito de compras?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Confirmar',
                cancelButtonText: "Cancelar"
            }).then(function () {

                $.ajax({
                    type: 'POST',
                    url: "ControllerCarrito",
                    data: {
                        accion: "VacearCarritoCompras"
                    },
                    success: function () {
                        swal({
                            title: "¡OK!",
                            text: "Carrito eliminado correctamente.",
                            type: "success",
                        });
                        CargarCarrito();
                    }
                });
            }
            )
        }

        function CargarCarrito() {
            $("#ListaCarrito").load("PagListaCompraSesion.jsp");
        }

        function EliminarArticuloCarrito(posicion) {
            swal({
                title: 'Eliminar',
                text: "¿Esta Seguro que desea eliminar este articulo?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Confirmar',
                cancelButtonText: "Cancelar"
            }).then(function () {

                $.ajax({
                    type: 'POST',
                    url: "ControllerCarrito",
                    data: {
                        posicion: posicion,
                        accion: "EliminarArticuloCarrito"
                    },
                    success: function () {
                        swal({
                            title: "¡OK!",
                            text: "El articulo fue eliminado correctamente.",
                            type: "success",
                        });
                        CargarCarrito();
                    }
                });
            }
            )
        }
    </script>

</html>
