package controlador;

import com.google.gson.Gson;
import dao.ArticuloDAO;
import dao.CategoriaDAO;
import dao.Compra;
import dao.FacturaDAO;
import entidad.Articulo;
import entidad.Cliente;
import entidad.Factura;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ControllerCarrito extends HttpServlet {

    ArticuloDAO objArticulo = new ArticuloDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        if (accion.equalsIgnoreCase("IrPaginaListarArticuloCategoria")) {
            IrPaginaListarArticuloCategoria(request, response);
        }

        if (accion.equalsIgnoreCase("IrPaginaDetalleArticulo")) {
            IrPaginaDetalleArticulo(request, response);
        }

        if (accion.equalsIgnoreCase("IrListaCarrito")) {
            IrListaCarrito(request, response);
        }

        if (accion.equalsIgnoreCase("AñadirCarrito")) {
            AñadirCarrito(request, response);
        }
        if (accion.equalsIgnoreCase("AñadirCarritoUnidad")) {
            AñadirCarritoUnidad(request, response);
        }

        if (accion.equalsIgnoreCase("ActualizarArticuloCarrito")) {
            ActualizarArticuloCarrito(request, response);
        }

        if (accion.equalsIgnoreCase("EliminarArticuloCarrito")) {
            EliminarArticuloCarrito(request, response);
        }
        if (accion.equalsIgnoreCase("VacearCarritoCompras")) {
            VacearCarritoCompras(request, response);
        }

        if (accion.equalsIgnoreCase("ProcesarCarrito")) {
            ProcesarCarrito(request, response);
        }

        if (accion.equalsIgnoreCase("VerDetalleCompra")) {
            VerDetalleCompra(request, response);
        }

        if (accion.equalsIgnoreCase("CancelarPedido")) {
            CancelarPedido(request, response);
        }

    }

    protected void CancelarPedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String nro = request.getParameter("nro");

        int res = new FacturaDAO().CancelarPedido(nro);

        out.print("Pedido cancelado.!! : " + res);
    }

    protected void VerDetalleCompra(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String nro = request.getParameter("nro");
        Gson gson = new Gson();

        ArrayList<Compra> lista = new FacturaDAO().ListadoDetalleFactura(nro);

        gson.toJson(lista);

        out.print(gson.toJson(lista));
    }

    protected void ProcesarCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession sesion = request.getSession();
        ArrayList<Compra> lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        Cliente c = (Cliente) sesion.getAttribute("logeadoCliente");

        Factura f = new Factura();
        f.setIdCliente(c.getCodigoUsuario());

        String nroFactura = new FacturaDAO().GenerarFactura(f, lista);

        lista.removeAll(lista);
        sesion.setAttribute("Carrito", lista);

        out.print(nroFactura);
    }

    protected void IrListaCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ArrayList<Compra> lista;

        HttpSession sesion = request.getSession();

        if (sesion.getAttribute("Carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        }

        sesion.setAttribute("Carrito", lista);
        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagCompra.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }
    }

    protected void VacearCarritoCompras(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ArrayList<Compra> lista;

        HttpSession sesion = request.getSession();

        if (sesion.getAttribute("Carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        }

        lista.removeAll(lista);

        sesion.setAttribute("Carrito", lista);
        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagCompra.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }
    }

    protected void EliminarArticuloCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int posicion = Integer.parseInt(request.getParameter("posicion"));

        ArrayList<Compra> lista;

        HttpSession sesion = request.getSession();

        if (sesion.getAttribute("Carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        }

        lista.remove(posicion);

        sesion.setAttribute("Carrito", lista);
        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagCompra.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }
    }

    protected void ActualizarArticuloCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int posicion = Integer.parseInt(request.getParameter("posicion"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        ArrayList<Compra> lista;

        HttpSession sesion = request.getSession();

        if (sesion.getAttribute("Carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        }

        Compra c = ObtenerCarrito(posicion, lista);
        c.setCantidad(cantidad);
        lista.set(posicion, c);

        sesion.setAttribute("Carrito", lista);

        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagCompra.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }
    }

    protected void AñadirCarritoUnidad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int codeArticulo = Integer.parseInt(request.getParameter("code"));

        ArrayList<Compra> lista;

        Articulo a = objArticulo.DetalleArticulo(codeArticulo);

        Compra c = new Compra();
        c.setCodigoArticulo(codeArticulo);
        c.setCantidad(1);
        c.setNombreArticulo(a.getNombreArticulo());
        c.setImagen(a.getImagenArticulo());
        c.setPrecio(a.getPrecioArticulo());

        HttpSession sesion = request.getSession();

        if (sesion.getAttribute("Carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        }

        int posc = BuscarProducto(lista, codeArticulo);
        if (posc == -1) {
            lista.add(c);
        } else {
            Compra cmp = ObtenerCarrito(posc, lista);
            c.setCantidad(cmp.getCantidad() + 1);
            lista.set(posc, c);
        }

        sesion.setAttribute("Carrito", lista);

        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagCompra.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }
    }

    protected void AñadirCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        int codeArticulo = Integer.parseInt(request.getParameter("codigo"));

        ArrayList<Compra> lista;

        Articulo a = objArticulo.DetalleArticulo(codeArticulo);

        Compra c = new Compra();
        c.setCodigoArticulo(codeArticulo);
        c.setCantidad(cantidad);
        c.setNombreArticulo(a.getNombreArticulo());
        c.setImagen(a.getImagenArticulo());
        c.setPrecio(a.getPrecioArticulo());

        HttpSession sesion = request.getSession();

        if (sesion.getAttribute("Carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<Compra>) sesion.getAttribute("Carrito");
        }

        int posc = BuscarProducto(lista, codeArticulo);
        if (posc == -1) {
            lista.add(c);
        } else {
            Compra cmp = ObtenerCarrito(posc, lista);
            c.setCantidad(cmp.getCantidad() + cantidad);
            lista.set(posc, c);
        }

        sesion.setAttribute("Carrito", lista);
        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("PagCompra.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }

    }

    protected void IrPaginaListarArticuloCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int code = Integer.parseInt(request.getParameter("code").trim());

        HttpSession sesion = request.getSession();
        sesion.setAttribute("codeCategoria", code);
        response.sendRedirect("PagListaArtCategoria.jsp");
    }

    protected void IrPaginaDetalleArticulo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int code = Integer.parseInt(request.getParameter("code"));
        String categoria = new CategoriaDAO().NombreCategoria(code);
        String imagen = new CategoriaDAO().ImagenCategoria(code);

        HttpSession sesion = request.getSession();
        sesion.setAttribute("codeArticulo", code);
        sesion.setAttribute("categoria", categoria);
        sesion.setAttribute("imagen", imagen);
        response.sendRedirect("PagDetalleArticulo.jsp");
    }

    public Compra ObtenerCarrito(int posc, ArrayList<Compra> lista) {
        return lista.get(posc);
    }

    public int BuscarProducto(ArrayList<Compra> lista, int producto) {
        for (int i = 0; i < lista.size(); i++) {
            Compra c = lista.get(i);

            if (c.getCodigoArticulo() == producto) {
                return i;
            }
        }
        return -1;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
