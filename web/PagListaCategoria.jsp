<%@page import="entidad.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoriaDAO"%>
<table class="table table-hover">
    <tr>
        <th>
            Codigo
        </th>
        <th>
            Categoria
        </th>
        <th>
            Imagen
        </th>
        <th>
            Estado
        </th>
        <th>
            Accion
        </th>
    </tr>
    <%
        CategoriaDAO objCategoria = new CategoriaDAO();
        ArrayList<Categoria> lista = objCategoria.ListadoTodasCategoria();
        for (Categoria c : lista) {
            String clase = c.isEstadoCategoria()==true?"success":"danger";
    %>
    <tr>
        <td><%=c.getCodigoCategoria()%></td>
        <td><%=c.getNombreCategoria()%></td>
        <td><img src="img/picture/<%=c.getImagenCategoria()%>" onerror="src='img/error/SinImagen.jpg'" width="100px" ></td>
        <td>   <a href="javascript:onclick(CambiarEstado(<%=c.isEstadoCategoria() %> , '<%=c.getNombreCategoria()%>' , <%=c.getCodigoCategoria()%>))" class="btn btn-<%=clase%>"><%=c.isEstadoCategoria()==true?"Activo":"Inactivo" %></a></td>
        <td>
            <a href="javascript:onclick(CargarDatosModal('<%=c.getNombreCategoria()%>' , '<%=c.getImagenCategoria()%>' ,<%=c.getCodigoCategoria()%> ))" class="btn btn-info">Modificar</a>
            <a href="javascript:void(0)" class="btn btn-danger" 
               onclick="ConfEliminarCategoria('<%=c.getNombreCategoria()%>', <%=c.getCodigoCategoria()%>)">Eliminar</a>
        </td>
        
    </tr>
    <%
        }

    %>
</table>