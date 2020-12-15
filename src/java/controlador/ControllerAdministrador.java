package controlador;

import dao.ArticuloDAO;
import dao.CategoriaDAO;
import dao.ClienteDAO;
import dao.VentaDAO;
import entidad.Articulo;
import entidad.Categoria;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ControllerAdministrador extends HttpServlet {

    ArticuloDAO objArticulo = new ArticuloDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String accion = request.getParameter("accionAdmi");

        if (accion.equalsIgnoreCase("IniciarSesion")) {
            IniciarSesion(request, response);
        }
        if (accion.equalsIgnoreCase("CerrarSesion")) {
            CerrarSesion(request, response);
        }
        if (accion.equalsIgnoreCase("ListadoArticulosDisponibles")) {
            ListadoArticulosDisponibles(request, response);
        }

        if (accion.equalsIgnoreCase("EliminarArticulo")) {
            EliminarArticulo(request, response);
        }

        if (accion.equalsIgnoreCase("EliminarCategoria")) {
            EliminarCategoria(request, response);
        }
        if (accion.equalsIgnoreCase("CantRegistrosInicio")) {
            CantRegistrosInicio(request, response);
        }
        if (accion.equalsIgnoreCase("CambiarEstadoCategoria")) {
            CambiarEstadoCategoria(request, response);
        }

        if (accion.equalsIgnoreCase("CambiarEstadoArticulo")) {
            CambiarEstadoArticulo(request, response);
        }

    }

    protected void CambiarEstadoArticulo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int codigo = Integer.parseInt(request.getParameter("codigo"));
        boolean estado = "true".equals(request.getParameter("estado")) ? false : true;

        int res = new ArticuloDAO().ActualizarEstadoArticulo(codigo, estado);
        out.print(res);
    }

    protected void CambiarEstadoCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int codigo = Integer.parseInt(request.getParameter("codigo"));
        boolean estado = "true".equals(request.getParameter("estado")) ? false : true;

        int res = new CategoriaDAO().ActualizarEstadoCategoria(codigo, estado);
        out.print(res);
    }

    protected void CantRegistrosInicio(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int cantClientes = new ClienteDAO().CantCliente();
        int cantPendientes = new VentaDAO().CantPedidosPendientes();

        String cad = cantClientes + "-" + cantPendientes;

        out.print(cad);
    }

    protected void EliminarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        int code = Integer.parseInt(request.getParameter("nro"));
        int res = new CategoriaDAO().EliminarCategoria(code);

        out.print(res);
    }

    protected void EliminarArticulo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        int code = Integer.parseInt(request.getParameter("categoria"));
        int res = objArticulo.EliminarArticulo(code);
        out.print(res);
    }

    protected void ListadoArticulosDisponibles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int code = Integer.parseInt(request.getParameter("categoria"));
        String resultado = "";
        String eliminar, modificar = "";
        String estado = "";

        PrintWriter out = response.getWriter();

        ArrayList<Articulo> lista = objArticulo.ListadoArticuloDisponible(code);
        for (Articulo a : lista) {
            String clase = a.isEstadoCategoria() == true ? "success" : "danger";
            eliminar = " <a onclick='EliminarArticulo(" + a.getCodigoArticulo() + ")' class='btn btn-danger'>Eliminar</a>";
            modificar = " <a href=' ' onclick='' class='btn btn-info'>Modificar</a>";
            estado = " <a href='javascript:onclick(CambiarEstado( " + a.isEstadoCategoria() + " , \'Luis\',  " + a.getCodigoArticulo() + " ))'  class='btn btn-" + clase + "'>" + (a.isEstadoCategoria() == true ? "Activo" : "Inactivo") + "</a>";
            resultado += "<tr><td>" + a.getCodigoArticulo() + "<td>" + a.getNombreArticulo() + "<td>" + a.getPrecioArticulo();
            resultado += "<td>" + a.getStock() + "<td><img src='img/picture/" + a.getImagenArticulo() + "' "
                    + " width='90px' height='110px' onerror=\"src='img/error/SinImagen.jpg' \"><td>" + estado + "<td>" + modificar + eliminar;
        }

        // onerror="src='img/error/SinImagen.jpg' "
        out.print(resultado);

    }

    protected void IniciarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String usuario = request.getParameter("usuario");
        String contraseña = request.getParameter("pass");

        response.sendRedirect("PagAdministrador.jsp");

    }

    protected void CerrarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Destruir Sesion
        HttpSession sesion = request.getSession();
        sesion.removeAttribute("logeadoCliente");
        response.sendRedirect("PagIniciarSesion.jsp");

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
