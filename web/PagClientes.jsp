<%@page import="entidad.Venta"%>
<%@page import="dao.VentaDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="jspf/CssNavegacion.jsp" %>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap.min.css"/>


        <title>Pagina Admnistrador</title>
    </head>
    <style>
        #example_paginate {
            width: 180px;
            margin: auto;
        }
    </style>
    <body class="homepage" >
        <%@include file="jspf/NavegacionAdministrador_Clientes.jsp" %>
        <div id="resultado">

        </div>


        <!--  <%@include file="jspf/Footer.jsp" %> -->

        <!--  <%@include file="jspf/JsScript.jsp" %> -->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>

        <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>
        <script src="bootbox/bootbox.min.js" type="text/javascript"></script>
    </body>
    <script type="text/javascript">
        $(function(){
            $("#resultado").load("listado_pag/Clientes.jsp");
        });
    </script>
    
</html>
