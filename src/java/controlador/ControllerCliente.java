package controlador;

import dao.ClienteDAO;
import entidad.Cliente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ControllerCliente extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accionCliente");

        if (accion.equalsIgnoreCase("IniciarSesion")) {
            IniciarSesion(request, response);
        }

        if (accion.equalsIgnoreCase("CerrarSesion")) {
            CerrarSesion(request, response);
        }

        if (accion.equalsIgnoreCase("RegistrarCliente")) {
            RegistrarCliente(request, response);
        }
    }

    protected void RegistrarCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        Cliente c = new Cliente();
        c.setNombres(request.getParameter("nome"));
        c.setApePaterno(request.getParameter("apeP"));
        c.setApeMaterno(request.getParameter("apeM"));
        c.setTelefono(request.getParameter("telefono"));
        c.setFechaNacimiento(request.getParameter("fecha"));
        c.setDireccion(request.getParameter("direccion"));
        c.setEmail(request.getParameter("email"));
        c.setContraseña(request.getParameter("pass"));
        c.setDni(request.getParameter("dni"));
        c.setNombreUsuario(request.getParameter("usuario"));

        String rpta = new ClienteDAO().AgregarCliente(c);
        out.print(rpta);
    }

    protected void CerrarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession sesion = request.getSession();
        sesion.removeAttribute("logeadoCliente");

        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }
    }

    protected void IniciarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession sesion = request.getSession();

        if (sesion.getAttribute("logeadoCliente") == null) {
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("PagProcesarCompra.jsp");
        }
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
