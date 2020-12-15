<%@page import="dao.CategoriaDAO"%>
<%@page import="entidad.Categoria"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <title>Pagina Admnistrador</title>
    </head>

    <%
        String nomImg = "", img = "";
        int registro = 0;
        java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("yyMMddHHmmss");
        File reportfile = null;
        reportfile = new File(application.getRealPath("/img/picture"));

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(1024);

        String ruta = String.valueOf(reportfile);
        ruta = ruta.replace("\\build", "");

        factory.setRepository(reportfile);

        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            List<FileItem> partes = upload.parseRequest(request);

            for (FileItem items : partes) {
                if (!items.isFormField()) {
                    // Impresion a la carpeta IMG
                    img = items.getName();
                    if (!img.equals("")) {
                        nomImg = ("Cat" + formato.format(new java.util.Date()) + img);
                        File file = new File(ruta, nomImg);
                        items.write(file);
                    }
                }
            }

            //  out.print("Categoria : " + partes.get(0).getString() + "<br>");
            // out.print("Codigo Categoria : " + partes.get(2).getString() + "<br>");
            CategoriaDAO objCategoria = new CategoriaDAO();
            Categoria c = new Categoria();
            c.setNombreCategoria(partes.get(0).getString());
            c.setImagenCategoria(img.equals("") ? "" : nomImg);
            c.setCodigoCategoria(Integer.parseInt(partes.get(2).getString()));

            registro = objCategoria.ModificarCategoria(c);
            if (registro > 0) {
                response.sendRedirect("PagAgregarCategoria.jsp");
            }
        } catch (Exception e) {
            registro = 0;
        }
    %>

    <body>
        <section class="window-height" id="error" style="background-image: url(img/error/404.png)">
            <div class="container">
                <h1>Error</h1>
                <p>No se ha podido actualizar correctamente la categoria.</p>
                <p>Categoria ya existe.!</p>
                <a class="btn btn-primary" href="PagAgregarCategoria.jsp">Regresar</a>
            </div>
        </section>
    </body>
    <%@include file="jspf/JsScript.jsp" %>
    <%@include file="jspf/Alerta.jsp" %>
</html>
