<%@page import="dao.FacturaDAO"%>
<%@page import="entidad.Factura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidad.Cliente"%>
<%

    int idClien = 1;

%>
<div class="container">
    <br>
    <h2>Lista de Compras</h2>

    <div class="col-lg-12 col-xs-12">

        <table id="example"class="table table-hover progress-table text-center" style="width: 100%;">
            <thead>
                <tr>
                    <th class="text-center"># Factura</th>
                    <th class="text-center">Fecha</th>
                    <th class="text-center">Cliente</th>
                    <th class="text-center">Monto</th>
                    <th class="text-center">Estado</th>
                    <th class="text-center">Ver Detalle</th>
                </tr>
            </thead>
            <tbody>
                <%                    ArrayList<Factura> lista = new FacturaDAO().ListadoPedidosClientes();
                    for (Factura f : lista) {
                        String clase = f.isEstado() == true ? "danger" : "success";
                %>
                <tr>
                    <td><%=f.getNroFactura()%></td>
                    <td><%=f.getFecha()%></td>
                    <td><%=f.getNombres() + " " + f.getApePaterno() + " " + f.getApeMaterno()%></td>
                    <td ><%=f.getMonto()%></td>
                    <td><span class="btn btn-<%=clase%>"><%=f.isEstado() == true ? "Cancelado" : "Pendiente"%></span></td>
                    <td>
                        <a href="javascript:void(0)"  onclick="CargarDatos('<%=f.getNroFactura()%>' , '<%=f.getFecha()%>' , <%=f.isEstado()%>)" class="btn btn-success" data-toggle="modal" data-target="#VerDetalle">Ver Detalle</a>
                    </td>
                </tr>
                <%
                    }
                %>


            </tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function () {
        CargarDataTable();
    });

    function CargarDataTable() {
        $('#example').DataTable({
            language: {
                "lengthMenu": "Mostrar _MENU_ registros",
                "zeroRecords": "No se encontraron resultados",
                "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                "infoFiltered": "(filtrado de un total de _MAX_ registros)",
                "loadingRecords": "Cargando...",
                "sSearch": "Buscar:",
                "oPaginate": {
                    "sFirst": "<span>Primero</span>",
                    "sLast": "<span >Último</span>",
                    "sNext": "<span  style='text-align: right;'>Siguiente</span>",
                    "sPrevious": "<span style='display: flex;'>Anterior</span>"
                },
                "sProcessing": "Procesando...",
            },
            //para usar los botones   
            // frtipB  
            // Original : Bfrtilp
            responsive: "true"
                    //   dom: 'Bfrtip',

        });
    }
</script>
