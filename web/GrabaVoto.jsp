<%-- 
    Document   : GrabaVoto
    Created on : 04-mar-2012, 23:48:29
    Author     : Jorge
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ConeccionBD.Sqls"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<script language="javascript">
function cerrar() {
    window.open("","_parent","");
    var ventana = window.self;
    ventana.opener = window.self;
    ventana.close();
}
</script>
<html>
<%
String sucursal = request.getParameter("sucursal");
String iduser = request.getParameter("iduser");
String idfoto = request.getParameter("idfoto");
String idsucursal = request.getParameter("idsucursal");
String[][] Matriz = new String[200][200];
Sqls sqlGatilla = new Sqls();
Matriz = sqlGatilla.SQL_InsertaVotoBD(iduser.trim(), idfoto.trim(), idsucursal);
%>
    <head>
        <SCRIPT language="JavaScript" type="text/javascript">
            function cerrar (){
                window.open("","_parent","");
                var ventana = window.self;
                ventana.opener = window.self;
                ventana.close();
            }
        </SCRIPT>
    
    <style type="text/css">
<!--
.ds {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 12px;
	font-weight: bold;
	color: #FFF;
}
-->
    </style>
    <title>Concurso Sucursales</title><br>
    <br>
    <br>
    <br>
    <br>
    <table width="474" border="0" align="center">
      <tr bgcolor="#F79935">
        <td><table width="221" border="0" align="center">
        <tr>
              <td width="215" class="ds">Voto Ingresado Correctamente. </td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="67" border="0" align="center">
          <tr>
              <td width="79"><input type="button" onclick="cerrar()" value="Aceptar"></td>
          </tr>
        </table></td>
      </tr>
    </table>    
    </head> 
</html>
