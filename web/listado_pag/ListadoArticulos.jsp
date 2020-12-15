<%@page import="recurso.Funciones"%>
<%@page import="entidad.Articulo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ArticuloDAO"%>
<%
    int code = Integer.parseInt(request.getParameter("categoria"));
    String resultado = "";
    String eliminar, modificar = "";
    String estado = "";
%>

<table class="table table-hover">
    <tr>
        <th>Codigo</th>
        <th>Articulo</th>
        <th>Precio Unitario</th>
        <th>Stock</th>
        <th>Imagen</th>
        <th>Estado</th>
        <th colspan="2">Accion</th>
    </tr>
    <tbody>
        <%
            
            ArrayList<Articulo> lista = new ArticuloDAO().ListadoArticuloDisponible(code);
            for (Articulo a : lista

            
                ) {
                 String clase = a.isEstadoCategoria() == true ? "success" : "danger";
        %>
        <tr>
            <td><%=a.getCodigoArticulo()%></td>
            <td><%=new Funciones().Palabra(a.getNombreArticulo()) %></td>
            <td><%=a.getPrecioArticulo()%></td>
            <td><%=a.getStock()%></td>
            <td>
                <img src="img/picture/<%=a.getImagenArticulo()%>" width='90px' height='100px' onerror="src='img/error/SinImagen.jpg'">
            </td>
            <td>
                <a href="javascript:onclick(CambiarEstado(<%=a.isEstadoCategoria()%>, '<%=a.getNombreArticulo()%> ', <%=a.getCodigoArticulo()%>))" class='btn btn-<%=clase%>'><%=(a.isEstadoCategoria() == true ? "Activo" : "Inactivo")%></a>
            </td>
            <td>
                <a href="javascript:onclick(CargarDatosModal(<%=a.getCodigoCategoria()%> , '<%=a.getNombreArticulo()%>' ,
                   <%=a.getPrecioArticulo()%>,<%=a.getStock()%> , '<%=a.getDescripcionArticulo()%>' , 
                   '<%=a.getImagenArticulo()%>' , <%=a.getCodigoArticulo()%>))" class='btn btn-info' class="btn btn-success" >Modificar</a>
                <a href="javascript:onclick:EliminarArticulo( '<%=a.getNombreArticulo()%>' , <%=a.getCodigoArticulo()%>)" class='btn btn-danger'>Eliminar</a>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>

</table>