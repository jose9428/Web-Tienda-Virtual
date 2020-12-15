
<%@page import="dao.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <title>Mi Carrito</title>
    </head>

    <body class="homepage" onload="CargarCarrito()">
        <%
            HttpSession sesion = request.getSession();

            ArrayList<Compra> listaCarrito = (ArrayList<Compra>) sesion.getAttribute("Carrito");
            int SizeCarrito = listaCarrito.size();
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

        <div id="ListaCarrito">
        </div>

  
    <%@include file="jspf/JsScript.jsp" %>
    <%@include file="jspf/Alerta.jsp" %>
</body>
<script type="text/javascript">
    function AceptarCompra(carrito) {

        if (parseInt(carrito) <= 0) {
            swal({
                title: "Mensaje",
                text: "El carrito se encuentra vacio.!!",
                type: "info",
            });
        } else {
            window.location.href = "PagProcesarCompra.jsp";
        }
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
        $("#ListaCarrito").load("PagListaCompra.jsp");
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
