
<%@page import="dao.FacturaDAO"%>
<%@page import="entidad.Factura"%>
<%@page import="entidad.Cliente"%>
<%@page import="dao.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <%@include file="jspf/CssNavegacion.jsp" %> 
        <title>Mis Pedidos</title>

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap.min.css"/>

    </head>

    <%
        HttpSession sesion = request.getSession();
        Cliente c = null;
        String nombres = "";
        int idCliente = 0;
        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagIniciarSesion.jsp");
        } else {
            c = (Cliente) sesion.getAttribute("logeadoCliente");
            nombres = c.getNombres() + " , " + c.getApePaterno() + " " + c.getApeMaterno();
            idCliente = c.getCodigoUsuario();
        }
    %>

    <style>
        #example_paginate {
            width: 180px;
            margin: auto;
        }
    </style>

    <body class="homepage" onload="MiListaPedidos()">
        <%
            if (sesion.getAttribute("logeadoCliente") == null) {
        %>
        <%@include file="jspf/NavegacionPedidos.jsp" %>
        <%        } else {
        %>
        <%@include file="jspf/NavegacionPedidos.jsp" %>
        <%            }

        %>
        <br />
        <div class="container">
            <div id="MiListaPedidos">


            </div>

        </div>
        <br>

        <div class="modal fade" id="VerDetalle" tabindex="-1" data-backdrop="static"  role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <h5 class="modal-title" ><strong style="font-size: 16px;">Detalle Compra</strong></h5>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  >
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <h3><strong># Factura : </strong><span id="nro">000000</span></h3>
                        <h3><strong>Fecha de Entrega : </strong><span id="fecha"> 12/02/2020</span></h3>

                        <div class="row">
                            <div class="col-sm-4">
                                <h3><strong>Estado : </strong><span id="estado">Atendido</span></h3>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                        <table class="table table-hover  text-center">
                            <tr>
                                <th ><span style="visibility: hidden;">Imagen</span></th>
                                <th  class=" text-center">ARTICULO</th>
                                <th class=" text-center">PRECIO</th>
                                <th class=" text-center" style="width:70px">CANTIDAD</th>
                                <th class=" text-center">IMPORTE</th>
                            <tr>
                            <tbody id="detalle">

                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <input type="hidden" name="nroFact" id="nroFact">
                            <a href="javascript:void(0)" class="btn btn-danger" id="BotonCancelarPedido" onclick="ConfCancelarPedido()">Cancelar Pedido</a>
                            <button type="button" class="btn btn-success" data-dismiss="modal">Cerrar</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>


        <%@include file="jspf/Footer.jsp" %>

        <!--  <%@include file="jspf/JsScript.jsp" %> -->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>

        <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>
        <script src="bootbox/bootbox.min.js" type="text/javascript"></script>
    </body>

</html>
<script type="text/javascript">
                                $(document).on('hidden.bs.modal', function (event) {
                                    if ($('.modal:visible').length) {
                                        $('body').addClass('modal-open');
                                    }
                                });

                                function ConfCancelarPedido() {
                                    //   $("#VerDetalle").hide("fast");
                                    $("#VerDetalle").modal("hide");
                                    var nro = $("#nroFact").val();
                                    bootbox.confirm({
                                        message: "¿Esta Seguro que desea cancelar su pedido?",
                                        buttons: {
                                            confirm: {
                                                label: 'Aceptar',
                                                className: 'btn-danger'
                                            },
                                            cancel: {
                                                label: 'Cerrar',
                                                className: 'btn-success'
                                            }
                                        },
                                        callback: function (result) {
                                            if (result) {
                                                CancelarPedido(nro);
                                                $("#VerDetalle").modal("hide");
                                            } else {
                                                $("#VerDetalle").modal("show");
                                                //  $("#VerDetalle").show();
                                            }
                                        }
                                    });
                                }

                                function CancelarPedido(nro) {
                                    $.ajax({
                                        url: "ControllerCarrito",
                                        type: 'POST',
                                        data: {
                                            nro: nro,
                                            accion: 'CancelarPedido'
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            MiListaPedidos();
                                        }, error: function (jqXHR, textStatus, errorThrown) {
                                            alert(textStatus);
                                        }
                                    });
                                }


                                function CargarDatos(nro, fecha, estado) {
                                    $("#nro").html(nro);
                                    $("#fecha").html(fecha);
                                    $("#estado").html(estado);

                                    if (estado === "Atendido") {
                                        $("#BotonCancelarPedido").hide("fast");
                                    } else {
                                        $("#BotonCancelarPedido").show();
                                    }

                                    $("#nroFact").val(nro);

                                    $.ajax({
                                        url: "ControllerCarrito",
                                        type: 'POST',
                                        //dataType: 'JSON',
                                        data: {
                                            nro: nro,
                                            accion: 'VerDetalleCompra'
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            var cadena = "";
                                            var total = 0;
                                            $(JSON.parse(data)).each(function (i, v) { // indice, valor
                                                total += v.cantidad * v.precio;
                                                cadena += "<tr>";
                                                cadena += "<td><img src='img/picture/" + v.imagen + "' width='80px' height='70px'></td>";
                                                cadena += "<td>" + v.nombreArticulo + "</td>";
                                                cadena += "<td>" + v.precio + "</td>";
                                                cadena += "<td>" + v.cantidad + "</td>";
                                                cadena += "<td>" + (v.cantidad * v.precio) + "</td>";
                                                cadena += "</tr>";
                                            });

                                            cadena += "<tr><td colspan='3'><td><strong>Importe Total</strong>\n\
                                                    </td></td><td>" + total + "</td></tr>";
                                            $("#detalle").html(cadena);

                                        }, error: function (jqXHR, textStatus, errorThrown) {
                                            alert(textStatus);

                                        }
                                    });
                                }


                                function MiListaPedidos() {
                                    $("#MiListaPedidos").load("listado_pag/PedidosCliente.jsp");
                                }


</script>
