<%@page import="dao.CategoriaDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidad.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <title>Pagina Admnistrador</title>
    </head>
    <body class="homepage">
        <%@include file="jspf/NavegacionAdministrador_Articulos.jsp" %>

        <div class="container">
            <div class="container">
                <br>
                <a href="PagListaArticulos.jsp" class="btn btn-success" >Ver Articulos</a>
                <br>
                <h1>Nuevo Articulo</h1>
                <br>

                <div class="col-sm-12">
                    <form method="post" enctype="multipart/form-data" action="PagGuardarArticulo.jsp" class="form-sample">


                        <div class="col-md-12">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><b>Seleccione Categoria</b></label>
                                <div class="col-sm-9" >
                                    <select class="form-control " name="categoria" id="categoria" required="" >
                                        <%
                                            CategoriaDAO objCategoria = new CategoriaDAO();
                                            ArrayList<Categoria> lista = objCategoria.ListadoCategoria();

                                            for (Categoria c : lista) {
                                        %>
                                        <option value="<%=c.getCodigoCategoria()%>"><%=c.getNombreCategoria()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><b>Articulo</b></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="articulo" name="articulo"  maxlength="70" required="">
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><b>Precio Unidad</b></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="precio" name="precio"  maxlength="6" minlength="1" required="" onkeypress="return soloNumeros(event)" >
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><b>Stock</b></label>
                                <div class="col-sm-9">
                                    <input type="number" class="form-control" id="stock" name="stock"  maxlength="6" min="1" required="">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><b>Seleccione Imagen</b></label>
                                <div class="col-sm-9">
                                    <input type="file" class="custom-file-input" id="imagen" name="imagen">
                                </div>
                            </div>
                        </div>


                        <div class="col-md-12">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><b>Descripcion</b></label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" maxlength="1000" required="" id="descripcion" name="descripcion" rows="3">
                                        
                                    </textarea>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-9">
                            <div class="form-group row">

                                <div class="col-sm-9">
                                    <input type="submit" value="Agregar" class="btn btn-success" >
                                    <input type="reset" value="Nuevo" class="btn btn-danger" >
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>

        <%@include file="jspf/JsScript.jsp" %>
        <%@include file="jspf/Alerta.jsp" %>
    </body>
</html>
