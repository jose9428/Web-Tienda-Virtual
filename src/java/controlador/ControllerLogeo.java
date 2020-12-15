package controlador;

import dao.UsuarioDAO;
import entidad.Cliente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ControllerLogeo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accionLogeo");

        if (accion.equalsIgnoreCase("IniciarSesion")) {
            IniciarSesion(request, response);
        }

    }

    protected void IniciarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession();
        String usuario = request.getParameter("usuario");
        String contraseña = request.getParameter("pass");
        String resultado;

        Cliente c = new UsuarioDAO().IniciarSesion(usuario, contraseña);

        if (c == null) {
            resultado = "0";
        } else if (c.getNombreUsuario().toLowerCase().equals("administrador")) {
            resultado = "admin";
            sesion.setAttribute("logeadoCliente", c);
        } else if (c.getNombreUsuario().toLowerCase().equals("cliente")) {
            resultado = "cliente";
            sesion.setAttribute("logeadoCliente", c);
        } else {
            resultado = "0";
        }
        out.print(resultado);
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
