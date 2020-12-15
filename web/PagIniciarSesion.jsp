<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <title>Pagina Iniciar Sesion</title>
    </head>
    <body class="homepage">
        <%@include file="jspf/NavegacionLogin.jsp" %>

        <section id="bottom">  
            <div class="container fadeInDown">
                <div class="row contact-wrap"> 
                    <div class="inner">
                        <div class="team-content">
                            <form  class="contact-form">
                                <div class="col-sm-5">
                                    <div class="form-group">
                                        <img src="img/icon/carritoPersonas.png" width="100%" >
                                    </div>
                                </div>

                                <div class="col-sm-5 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="large-title text-center">   
                                            <img src="img/icon/tienda4-1.png" width="25%">
                                        </div> 
                                    </div>
                                    <div class="form-group">
                                        <label><b>Usuario</b></label>
                                        <input type="text"  name="usuario" id="usuario" class="form-control" required="required" placeholder="Digite su usuario">
                                    </div>
                                    <div class="form-group">
                                        <label><b>Contraseña</b></label>
                                        <input type="password" name="contraseña" id="contraseña" class="form-control" required="required" placeholder="Digite su contraseña">
                                    </div>
                                    <div class="form-group">
                                        <input type="button"  class="btn btn-primary btn-group-sm " style="background-color: #0066ff;color: #ffffff;" onclick="IniciarSesion()" value="Iniciar Sesion">
                                    </div>
                                    <div class="form-group">
                                        <p>¿No tienes una cuenta?</p>
                                        <a href="PagRegistro.jsp" style="color: #3366ff;">Registrarse</a>
                                    </div>
                                </div>
                            </form> 
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@include file="jspf/Footer.jsp" %>
        <%@include file="jspf/JsScript.jsp" %>
        <%@include file="jspf/Alerta.jsp" %>
    </body>
    <script type="text/javascript">
        function IniciarSesion() {
            var usuario = $("#usuario").val();
            var pass = $("#contraseña").val();
            if (usuario.length < 1) {
                swal({
                    title: "Mensaje",
                    text: "El campo del usuario se encuentra vacio.",
                    type: "info",
                });
                return false;
            }

            if (pass.length < 1) {
                swal({
                    title: "Mensaje",
                    text: "El campo de la contraseña se encuentra vacio.",
                    type: "info",
                });
                return false;
            }

            $.ajax({
                type: 'POST',
                url: "ControllerLogeo",
                data: {
                    usuario: usuario,
                    pass: pass,
                    accionLogeo: "IniciarSesion"
                },
                success: function (result) {

                    if (result === "0") {
                        swal({
                            title: "Mensaje",
                            text: "Clave y/o Usuario Incorrecto.",
                            type: "error",
                        });
                        // Limpiar Casillas
                        $("#usuario").val("");
                        $("#contraseña").val("");
                    } else if (result === "admin") {
                        window.location.href = "ControllerAdministrador?usuario=" + usuario +
                                "&pass=" + pass + "&accionAdmi=IniciarSesion";
                    } else if (result === "cliente") {
                        window.location.href = "ControllerCliente?accionCliente=IniciarSesion";
                    }


                }
            });
        }
    </script>
</html>
