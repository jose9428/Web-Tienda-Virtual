<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <title>Pagina Admnistrador</title>
    </head>
    <body class="homepage" onload="CargaLista()">
        <%@include file="jspf/NavegacionAdministrador_Categoria.jsp" %>

        <div class="container mt-4">
            <br>
            <div class="row">
                <div class="col-sm-4">
                    <h1>Categorias</h1>
                    <form method="post" enctype="multipart/form-data" action="PagGuardarCategoria.jsp" id="form">
                        <div class="form-group">
                            <label>Categoria</label>
                            <input type="text" class="form-control input-sm" name="categoria" id="categoria" required="">
                        </div>
                        <div class="form-group">
                            <label>Imagen</label>
                            <input type="file" class="form-control-file" name="imagen" id="imagen" required="">
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Agregar" class="btn btn-success" id="Agregar">
                        </div>
                    </form>
                </div>
                <div class="col-sm-8">
                    <div id="tablaCategoriaLoad">

                    </div>
                </div>
            </div>
        </div>



        <div class="modal fade" id="ModalModificarCategoria" tabindex="-1" data-backdrop="static"  role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <h5 class="modal-title" ><strong style="font-size: 16px;">Modificar Categoria</strong></h5>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  >
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="modal-body">
                        <form method="post" enctype="multipart/form-data" action="PagModificarCategoria.jsp" id="formM">
                            <div class="form-group">
                                <label>Categoria</label>
                                <input type="text" class="form-control input-sm" name="categoriaM" id="categoriaM" required="">
                            </div>
                            <div class="form-group">
                                <label>Imagen</label>
                                <img width="60" id="imagenMod" >
                                <input type="file" class="form-control-file" name="imagenM" id="imagenM" >
                            </div>
                            <div class="form-group">
                                <input type="hidden" id="codCategoriaM" name="codCategoriaM">
                                <input type="submit" value="Modificar" class="btn btn-success" id="Modificar">
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

        function CargarDatosModal(categoria, imagen, codeCategoria) {
            $("#imagenMod").attr('src', "img/picture/" + imagen);
            $("#categoriaM").val(categoria);
            $("#codCategoriaM").val(codeCategoria);
            $("#ModalModificarCategoria").modal("show");
        }
        function CambiarEstado(estado, categoria, codigo) {

            var cadena = estado === false ? "activar" : "desactivar";
            bootbox.confirm({
                message: "¿Esta Seguro que desea " + cadena + " la categoria " + categoria + "?",
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
                                accionAdmi: 'CambiarEstadoCategoria'
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
                                            dialog.find('.bootbox-body').html("Se actualizo correctamente el estado de la categoria " + categoria + ".");
                                            CargaLista();
                                        }, 1000);
                                    });
                                } else {
                                    dialog.init(function () {
                                        setTimeout(function () {
                                            dialog.find('.bootbox-body').html("No se ha podido actualizar el estado de la categoria " + categoria + ".");
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

        function CargaLista() {
            $("#tablaCategoriaLoad").load("PagListaCategoria.jsp");
        }

        function ConfEliminarCategoria(categoria, nro) {

            bootbox.confirm({
                message: "¿Esta Seguro que desea eliminar la categoria " + categoria + "?",
                buttons: {
                    confirm: {
                        label: 'SI',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'No',
                        className: 'btn-success'
                    }
                },
                callback: function (result) {
                    if (result) {
                        EliminarCategoria(nro,categoria);
                    }

                }
            });
        }

        function EliminarCategoria(nro,categoria) {

            $.ajax({
                url: "ControllerAdministrador",
                type: 'POST',
                data: {
                    nro: nro,
                    accionAdmi: 'EliminarCategoria'
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
                                dialog.find('.bootbox-body').html("Se elimino correctamente la categoria " + categoria + ".");
                                 CargaLista();
                            }, 1000);
                        });
                    } else {
                        dialog.init(function () {
                            setTimeout(function () {
                                dialog.find('.bootbox-body').html("No se ha podido eliminar la categoria " + categoria + ".");
                            }, 1000);
                        });
                    }

                   
                }, error: function (jqXHR, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        }
    </script>
</html>
