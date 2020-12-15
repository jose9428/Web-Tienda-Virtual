<%@page import="dao.FacturaDAO"%>
<%@page import="entidad.Factura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidad.Cliente"%>
<%
    HttpSession ses = request.getSession();
    Cliente cli = null;
    String nombres = "";
    int idClien = 0;
    if (ses.getAttribute("logeadoCliente") == null) {
        response.sendRedirect("PagIniciarSesion.jsp");
    } else {
        cli = (Cliente) ses.getAttribute("logeadoCliente");
        idClien = cli.getCodigoUsuario(); 
    }
%>
<img src="img/icon/icono_pedido.png" width="100px"/>
<h1>Mis Pedidos</h1>

<%                    ArrayList<Factura> lista = new FacturaDAO().ListadoFacturas(idClien);

    if (lista.size() > 0) {
%>
<div class="col-lg-12 col-xs-12">

    <table id="example"class="table table-hover progress-table text-center" style="width: 100%;">
        <thead>
            <tr>
                <th class="text-center"># Factura</th>
                <th class="text-center">Fecha</th>
                <th class="text-center">Monto</th>
                <th class="text-center">Estado</th>
                <th class="text-center">Ver Detalle</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Factura f : lista) {
                    String estado = f.isEstado() == true ? "Atendido" : "Pendiente";
                    String clase = f.isEstado() == true ? "alert-info" : "alert-danger";
            %>

            <tr>
                <td><%=f.getNroFactura()%></td>
                <td><%=f.getFecha()%></td>
                <td><%=f.getMonto()%></td>
                <td ><span class="<%=clase%>"><%=estado%> </span></td>
                <td>
                    <a href="javascript:void(0)"  onclick="CargarDatos('<%=f.getNroFactura()%>', '<%=f.getFecha()%>', '<%=estado%>')" class="btn btn-success" data-toggle="modal" data-target="#VerDetalle">Ver Detalle</a>
                </td>
            </tr>

            <%
                }
            %>
        </tbody>
    </table>
</div>
<%
} else {
%>
<center>
    <br>
    <img src="img/icon/pedidos.png"  width="50%"/>
    <br><br>
    <h2>Aun no tienes pedidos? Que esperas? <a href="PagProductos.jsp" class="alert-success" style="font-size: 14px;"> Ver Productos</a> </h2>
</center>
<br><br>
<%
    }

%>


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
