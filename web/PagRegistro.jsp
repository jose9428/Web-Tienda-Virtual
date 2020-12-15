<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <!--  
                <link href="bootbox/font-awesome.min.css" rel="stylesheet" type="text/css"/>
                <link href="bootbox/animate.min.css" rel="stylesheet" type="text/css"/>
        -->
        <title>Pagina Registro</title>
    </head>
    <body class="homepage">
        <%@include file="jspf/NavegacionRegistro.jsp" %>
        <div class="blog container">
            <section id="contact-page">
                <div class="container">
                    <div class="row contact-wrap"> 
                        <form  class="contact-form" id="FrmRegistrarse">
                            <div class="col-sm-3">

                                <div class="form-group">
                                    <div>
                                        <h3 class="badge badge-info" >Regístrate en la Tienda en Línea</h3>
                                    </div>
                                    <img src="img/icon/carritoPersonas.png" width="100%" >
                                </div>
                            </div>

                            <div class="col-sm-9">
                                <h2>
                                    <a href="" style="color:#428bca;" >
                                        Nuevo Cliente
                                    </a>
                                </h2>
                                <hr />

                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label >Nombres</label>
                                        <input type="text" class="form-control" id="nome" placeholder="Nombres" name="nome">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label >Apellido Paterno</label>
                                        <input type="text" class="form-control" id="apeP" placeholder="Apellido Paterno" name="apeP">
                                    </div>

                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>Apellido Materno</label>
                                        <input type="text" class="form-control" id="apeM" placeholder="Apellido Materno" name="apeM">
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label >Dni</label>
                                        <input type="text" class="form-control" id="dni" placeholder="DNI" name="dni" maxlength="8">
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label >Fecha Nac.</label>
                                        <input type="text"  class="form-control" id="fecha" placeholder="YYYY-MM-DD" name="fecha">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-6"> 
                                        <label >Direccion</label>
                                        <input type="text" class="form-control" id="direccion" placeholder="Direccion" name="direccion">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label >Telefono</label>
                                        <input type="text" class="form-control" id="telefono" placeholder="Telefono" name="telefono" maxlength="9">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label >Email</label>
                                        <input type="email" class="form-control" id="email" placeholder="Email" name="email">
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label >Usuario</label>
                                        <input type="text" class="form-control" id="usuario" placeholder="Usuario" name="usuario">
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label >Contraseña</label>  
                                        <input type="password" class="form-control" id="pass" placeholder="Contraseña" name="pass">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <input type="button"  class="btn btn-group-sm " style="background-color: #28a745;color: #ffffff;" onclick="Registrarse()" value="Registarse">
                                        <p>¿Ya tienes una cuenta?</p>
                                        <input type="hidden" name="accionCliente" value="RegistrarCliente">
                                        <a href="PagIniciarSesion.jsp" style="color: #3366ff;">Iniciar Sesion</a>
                                    </div>
                                </div>

                            </div>
                        </form> 
                    </div>
                </div>
            </section>
        </div>
        <%@include file="jspf/Footer.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="bootbox/bootbox.min.js" type="text/javascript"></script>
    </body>
    <script type="text/javascript">

                                            function ValidarCampos() {
                                                var cadena = "";

                                                if ($("#nome").val() === "") {
                                                    cadena += "<br>. El campo del nombre se encuentra vacio.";
                                                }

                                                if ($("#apeP").val() === "") {
                                                    cadena += "<br>. El campo del Apellido Paterno se encuentra vacio.";
                                                }
                                                if ($("#apeM").val() === "") {
                                                    cadena += "<br>. El campo del Apellido Materno se encuentra vacio.";
                                                }
                                                if ($("#dni").val() === "") {
                                                    cadena += "<br>. El campo del Dni se encuentra vacio.";
                                                }

                                                if ($("#fecha").val() === "") {
                                                    cadena += "<br>. El campo de la fecha de nacimiento se encuentra vacio.";
                                                }
                                                if ($("#direccion").val() === "") {
                                                    cadena += "<br>. El campo de la direccion se encuentra vacio.";
                                                }
                                                if ($("#telefono").val() === "") {
                                                    cadena += "<br>. El campo del telefono se encuentra vacio.";
                                                }
                                                if ($("#email").val() === "") {
                                                    cadena += "<br>. El campo del email se encuentra vacio.";
                                                }
                                                if ($("#usuario").val() === "") {
                                                    cadena += "<br>. El campo del usuario se encuentra vacio.";
                                                }
                                                if ($("#pass").val() === "") {
                                                    cadena += "<br>. El campo de la contrase se encuentra vacio.";
                                                }

                                                return cadena;

                                            }
                                            function Registrarse() {

                                                if (ValidarCampos().length > 0) {
                                                    var cadena = "<strong>Por favor corrija los siguientes errores :</strong>\n" + ValidarCampos();
                                                    Mensaje(cadena);
                                                    return false;
                                                }

                                                $.ajax({
                                                    type: 'POST',
                                                    url: "ControllerCliente",
                                                    data: $("#FrmRegistrarse").serialize(),
                                                    success: function (result) {
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

                                                        if (result === "OK") {
                                                            dialog.init(function () {
                                                                setTimeout(function () {
                                                                    dialog.find('.bootbox-body').html("Se registro correctamente los datos del cliente.");
                                                                    $("#FrmRegistrarse")[0].reset();
                                                                }, 1000);
                                                            });
                                                        } else {
                                                            dialog.init(function () {
                                                                setTimeout(function () {
                                                                    dialog.find('.bootbox-body').html(result);
                                                                }, 1000);
                                                            });

                                                        }
                                                    }
                                                });
                                            }

                                            function Mensaje(cadena) {
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

                                                dialog.init(function () {
                                                    setTimeout(function () {
                                                        dialog.find('.bootbox-body').html(cadena);
                                                    }, 1000);
                                                });
                                            }
    </script>
</html>
