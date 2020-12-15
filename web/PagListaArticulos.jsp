<%@page import="dao.ArticuloDAO"%>
<%@page import="entidad.Articulo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidad.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <title>Pagina Admnistrador</title>
    </head>
    <body class="homepage" onload="ConsultarArticulo()">
        <%@include file="jspf/NavegacionAdministrador_Articulos.jsp" %>

        <div class="container">

            <br>
            <a href="PagAgregarArticulos.jsp" class="btn btn-success" >Nuevo Articulo</a>
            <br>
            <h1>Lista de Articulos</h1>
            <br>
            <div class="col-sm-12">
                <form method="post" class="form-sample">
                    <div class="col-md-12">
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label"><b> Categoria</b></label>
                            <div class="col-sm-6">
                                <select class="form-control" name="categoria" id="categoria" onchange="ConsultarArticulo()">
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
                </form>
                <div id="resultado">
                </div>
            </div>

        </div>

        <div class="modal fade" id="ModalModificarArticulo" tabindex="-1" data-backdrop="static"  role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <h5 class="modal-title" ><strong style="font-size: 16px;">Modificar Articulo</strong></h5>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  >
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="modal-body">
                        <form method="post" enctype="multipart/form-data" id="FrmModificar" action="PagModificarArticulo.jsp">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label" style="text-align: right;"><b> Categoria</b></label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="categoriaM" id="categoriaM" >
                                        <%
                                            ArrayList<Categoria> lista2 = new CategoriaDAO().ListadoCategoria();

                                            for (Categoria c2 : lista2) {
                                        %>
                                        <option value="<%=c2.getCodigoCategoria()%>"><%=c2.getNombreCategoria()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label" style="text-align: right;"><b> Articulo</b></label>
                                <div class="col-sm-9">
                                    <input type="text" name="articuloM" id="articuloM" class="form-control" required="">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label" style="text-align: right;"><b> Precio Unidad</b></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="precioM" name="precioM"  maxlength="6" minlength="1" required="" onkeypress="return soloNumeros(event)" >
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label" style="text-align: right;"><b> Stock</b></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="stockM" name="stockM"  maxlength="6" minlength="1" required="" onkeypress="return soloNumeros(event)" >
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label" style="text-align: right;"><b>Imagen</b></label>
                                <div class="col-sm-9">
                                    <img width="60" id="imagenM" >
                                    <input type="file"  name="imagen" id="imagen">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label" style="text-align: right;"><b>Descripcion</b></label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" maxlength="1000" required="" rows="3" id="descripcionM" name="descripcionM">
                                        
                                    </textarea>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <div class="row">
                                    <input type="hidden" name="codeArticulo" id="codeArticulo">
                                    <input type="submit"   class="btn btn-success" id="BtnModificar" value="Modificar">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--<%@include file="jspf/JsScript.jsp" %> -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="bootbox/bootbox.min.js" type="text/javascript"></script>
    </body>
    <script type="text/javascript">
                    
                                        function CargarDatosModal(categoria, articulo, precio, stock, descripcion, imagen, codeArticulo) {
                                            $("#imagenM").attr('src', "img/picture/" + imagen);

                                            $("#articuloM").val(articulo);
                                            $("#categoriaM").val(categoria);
                                            $("#precioM").val(precio);
                                            $("#stockM").val(stock);
                                            $("#descripcionM").val(descripcion);
                                            $("#codeArticulo").val(codeArticulo);
                                            $("#ModalModificarArticulo").modal("show");
                                        }

                                        function CambiarEstado(estado, articulo, codigo) {
                                            var cadena = estado === false ? "activar" : "desactivar";
                                            bootbox.confirm({
                                                message: "¿Esta Seguro que desea " + cadena + " el articulo " + articulo + "?",
                                                buttons: {
                                                    confirm: {
                                                        label: 'Si',
                                                        className: 'btn-danger'
                                                    },
                                                    cancel: {
                                                        label: 'No',
                                                        className: 'btn-success'
                                                    }
                                                },
                                                callback: function (result) {
                                                    if (result) {
                                                        $.ajax({
                                                            url: "ControllerAdministrador",
                                                            type: 'POST',
                                                            data: {
                                                                estado: estado,
                                                                codigo: codigo,
                                                                accionAdmi: 'CambiarEstadoArticulo'
                                                            },
                                                            success: function (data, textStatus, jqXHR) {
                                                                var dialog = bootbox.dialog({
                                                                    title: '<strong>Mensaje del Sistema</strong>',
                                                                    message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
                                                                    buttons: {
                                                                        cancel: {
                                                                            label: '<i class="fa fa-times"></i> Cerrar'
                                                                        }
                                                                    }
                                                                }).find('.modal-content').css({
                                                                    color: '#081932',
                                                                    font: 'lato sans-serif'
                                                                });

                                                                if (parseInt(data) > 0) {
                                                                    dialog.init(function () {
                                                                        setTimeout(function () {
                                                                            dialog.find('.bootbox-body').html("Se actualizo correctamente el estado del articulo " + articulo + ".");
                                                                            ConsultarArticulo();
                                                                        }, 1000);
                                                                    });
                                                                } else {
                                                                    dialog.init(function () {
                                                                        setTimeout(function () {
                                                                            dialog.find('.bootbox-body').html("No se ha podido actualizar el estado del articulo " + articulo + ".");
                                                                        }, 1000);
                                                                    });
                                                                }
                                                            }, error: function (jqXHR, textStatus, errorThrown) {
                                                                alert(textStatus);
                                                            }
                                                        });
                                                    }

                                                }
                                            });
                                        }

                                        function ConsultarArticulo() {
                                            var code = $("#categoria").val();

                                            $("#resultado").load("listado_pag/ListadoArticulos.jsp?categoria=" + code);
                                        }

                                        function EliminarArticulo(articulo, code) {
                                            bootbox.confirm({
                                                message: "¿Esta Seguro que desea eliminar el articulo " + articulo + "?",
                                                buttons: {
                                                    confirm: {
                                                        label: 'Si',
                                                        className: 'btn-danger'
                                                    },
                                                    cancel: {
                                                        label: 'No',
                                                        className: 'btn-success'
                                                    }
                                                },
                                                callback: function (result) {
                                                    if (result) {
                                                        $.ajax({
                                                            type: 'POST',
                                                            url: "ControllerAdministrador",
                                                            data: {
                                                                categoria: code,
                                                                accionAdmi: "EliminarArticulo"
                                                            },
                                                            success: function (data, textStatus, jqXHR) {
                                                                var dialog = bootbox.dialog({
                                                                    title: '<strong>Mensaje del Sistema</strong>',
                                                                    message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
                                                                    buttons: {
                                                                        cancel: {
                                                                            label: '<i class="fa fa-times"></i> Cerrar'
                                                                        }
                                                                    }
                                                                }).find('.modal-content').css({
                                                                    color: '#081932',
                                                                    font: 'lato sans-serif'
                                                                });

                                                                if (parseInt(data) > 0) {
                                                                    dialog.init(function () {
                                                                        setTimeout(function () {
                                                                            dialog.find('.bootbox-body').html("Se elimino correctamente el articulo " + articulo + ".");
                                                                            ConsultarArticulo();
                                                                        }, 1000);
                                                                    });
                                                                } else {
                                                                    dialog.init(function () {
                                                                        setTimeout(function () {
                                                                            dialog.find('.bootbox-body').html("No se ha podido eliminar el articulo " + articulo + ".");
                                                                        }, 1000);
                                                                    });
                                                                }
                                                            }, error: function (jqXHR, textStatus, errorThrown) {
                                                                alert(textStatus);
                                                            }
                                                        });
                                                    }

                                                }
                                            });





                                        }
    </script>
</html>
