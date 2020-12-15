<%@page import="dao.ArticuloDAO"%>
<%@page import="entidad.Articulo"%>
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
        <title>Pagina Admnistrador</title>
    </head>

    <%
        String nomImg = "", img = "";
        int registro = 0;
        out.print("Enviando a la pagina...<br>");

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
                    img = items.getName();
                    if (!img.equals("")) {
                        nomImg = ("Art" + formato.format(new java.util.Date()) + items.getName());
                        File file = new File(ruta, nomImg);
                        items.write(file);
                    }
                }
            }

            Articulo a = new Articulo();
            a.setCodigoCategoria(Integer.parseInt(partes.get(0).getString().trim()));
            a.setCodigoArticulo(Integer.parseInt(partes.get(6).getString().trim()));
            a.setNombreArticulo(partes.get(1).getString().trim());
            a.setPrecioArticulo(Double.parseDouble(partes.get(2).getString().trim()));
            a.setStock(Integer.parseInt(partes.get(3).getString().trim()));
            a.setDescripcionArticulo(partes.get(5).getString().trim());
            a.setImagenArticulo(img.equals("") ? "" : nomImg);

            out.println("Codigo Categoria : " + partes.get(0).getString().trim() + "<br>");
            out.println("Nombre Articulo : " + partes.get(1).getString().trim() + "<br>");
            out.println("Precio : " + partes.get(2).getString().trim() + "<br>");
            out.println("Stock : " + partes.get(3).getString().trim() + "<br>");
            out.println("Descripcion : " + partes.get(5).getString().trim() + "<br>");
            out.println("Codigo : " + partes.get(6).getString().trim() + "<br>");

            if (!img.equals("")) {
                out.print("Imagen : " + nomImg + "<br>");
            }

            new ArticuloDAO().ModificarArticulo(a);
            response.sendRedirect("PagListaArticulos.jsp");

            /*
            ArticuloDAO objArticulo = new ArticuloDAO();
            Articulo a = new Articulo();
            a.setCodigoCategoria(Integer.parseInt(partes.get(0).getString().trim()));
            a.setNombreArticulo(partes.get(1).getString().trim());
            a.setPrecioArticulo(Double.parseDouble(partes.get(2).getString().trim()));
            a.setStock(Integer.parseInt(partes.get(3).getString().trim()));
            a.setImagenArticulo(nomImg.trim());
            a.setDescripcionArticulo(partes.get(5).getString().trim());

            registro = objArticulo.AgregarArticulo(a);

            if (registro > 0) {
               response.sendRedirect("PagListaArticulos.jsp");
            }
             */
        } catch (Exception e) {
            registro = 0;
            out.print(e.getMessage());
        }
    %>

    <body>

    </body>
</html>
