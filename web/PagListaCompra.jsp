<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.Compra"%>

<%@include file="jspf/JsScript.jsp" %>
<%
    ArrayList<Compra> lista = null;
    HttpSession sesion = request.getSession();
    int sizeCarrito = 0;
    if (sesion.getAttribute("Carrito") != null) {
        lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        sizeCarrito = lista.size();
    } else {
        lista = new ArrayList<>();
    }


%>
<div class="container">
    <h1>Mi Carrito</h1>
    <hr />
    <%    if (lista.size() > 0) {
    %>

    <a href="PagProductos.jsp" class="btn btn-success">Seguir Comprando</a>
    <a class="btn btn-danger" onclick="VacearCarrito()">Vacear Carrito</a>
    <br><br>
    <table class="table table-hover  text-center">
        <tr >
            <th ><span style="visibility: hidden;">Imagen</span></th>
            <th  class=" text-center">ARTICULO</th>
            <th class=" text-center">PRECIO</th>
            <th class=" text-center" style="width:70px">CANTIDAD</th>
            <th class=" text-center">IMPORTE</th>
            <th class=" text-center">ACCION</th>
        <tr>
        <tbody id="resultado">
            <%                        int contador = 0;
                double total = 0;
                for (Compra c : lista) {
            %>
            <tr>
                <td>

                    <div class="overlay">
                        <div class="recent-work-inner">
                            <a class="preview" href="img/picture/<%=c.getImagen()%>" rel="prettyPhoto"><i class="fa fa-plus"></i></a>
                            <img src="img/picture/<%=c.getImagen()%>"  class="card-img-top" width="70px" height="60px">
                        </div>
                    </div>

                </td>
                <td><%=c.getNombreArticulo()%> </td>
                <td><%=c.getPrecio()%> </td>
                <td>
                    <div class="quantity">
                        <input type="number" onclick ="ActualizarCarrito(<%=contador%>, this.value)"   name="cantidad"
                               id="cantidad" value="<%=c.getCantidad()%>" class="form-control" 
                               min="1">
                    </div>
                <td><%=new DecimalFormat("#.##").format(c.Total())%> </td>
                <td>
                    <a  class="btn btn-danger" onclick="EliminarArticuloCarrito(<%=contador%>)">Eliminar</a>
                </td>
            </tr>
            <%
                    contador++;
                    total += c.Total();
                }

            %>

        </tbody>
        <tr>
            <td colspan="3"></td>
            <td><h3><b>Total S/.</b></h3></td>
            <td><h2><b><%=new DecimalFormat("#.##").format(total)%></b></h2></td>
            <td>
                <%
                    if (sesion.getAttribute("logeadoCliente") != null) {
                %>
                <a href="javascript:void(0)" class="btn btn-success" onclick="Comprar()">Aceptar Compra</a>
                <%
                } else {
                %>
                <a href="javascript:void(0)" class="btn btn-success" onclick="AceptarCompra(<%=sizeCarrito%>)">Aceptar Compra</a>
                <%

                    }
                %>
            </td>
        </tr>
    </table>
    <%
    } else {
    %>
    <center>
        <img src="img/icon/carrito.png"  width="30%"/>
        <h2>Tu carrito está vacío, llénalo!</h2>
    </center>

    <%
        }

    %>
</div>
<%@include file="jspf/Footer.jsp" %>