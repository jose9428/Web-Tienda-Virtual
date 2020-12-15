<%@page import="dao.ClienteDAO"%>
<%@page import="dao.FacturaDAO"%>
<%@page import="entidad.Factura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidad.Cliente"%>

<div class="container">
    <br>
    <h2>Lista de Clientes</h2>

    <div class="col-lg-12 col-xs-12">

        <table id="example"class="table table-hover progress-table text-center" style="width: 100%;">
            <thead>
                <tr>
                    <th class="text-center">DNI</th>
                    <th class="text-center">Usuario</th>
                    <th class="text-center">Nombres</th>
                    <th class="text-center">Apellido Paterno</th>
                    <th class="text-center">Apellido Materno</th>
                    <th class="text-center">Telefono</th>
                    <th class="text-center">Fecha Nac.</th>
                    <th class="text-center">Email</th>
                    <th class="text-center">Direccion</th>
                </tr>
            </thead>
            <tbody>
                <%                    ArrayList<Cliente> lista = new ClienteDAO().ListadoClientes();
                    for (Cliente c : lista) {

                %>
                <tr>
                    <td><%=c.getDni()%></td>
                    <td><%=c.getNombreUsuario()%></td>
                    <td><%=c.getNombres()%></td>
                    <td><%=c.getApePaterno()%></td>
                    <td><%=c.getApeMaterno()%></td>
                    <td><%=c.getTelefono()%></td>
                    <td><%=c.getFechaNacimiento()%></td>
                    <td><%=c.getEmail()%></td>
                    <td><%=c.getDireccion()%></td>
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
