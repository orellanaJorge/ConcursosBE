<%-- 
    Document   : EstadoVotacion
    Created on : 13-mar-2012, 6:37:35
    Author     : Jorge
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ConeccionBD.Sqls"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
        
    <head>
     
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Concurso Sucursales</title>
    <style type="text/css">
<!--
.UY {
	text-align: center;
}
.TTR {
	font-family: Verdana, Geneva, sans-serif;
	color: #FFF;
}
TTR {
	font-size: 12px;
}
TTR {
	color: #FFF;
}
.YYH {
	font-weight: bold;
}
.HHYH {
	color: #FFF;
}
.GG {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 12;
}
GG {
	font-size: 14px;
}
GG {
	color: #FFF;
}
GG {
	font-weight: bold;
}
#GG {
	color: #FFF;
	font-weight: bold;
}
.GG {
	font-size: 10px;
}
.JJ {
	font-family: Verdana, Geneva, sans-serif;
}
.JJ {
	font-size: 10px;
}
.dddd {
	text-align: center;
}
.ghg {
	text-align: center;
}
-->
    </style>
    </head>


    <%
    String idCategoria = "2";
    String idConcurso = "1";
    String[][] SQL_LlenaSucursales = new String[200][200];
    Sqls sqlGatilla = new Sqls();
    SQL_LlenaSucursales = sqlGatilla.SQL_EstadoVotacion();
    sqlGatilla = null;

    String h = "";

    %>

    <body>
        <table width="850" border="1" align="center" cellspacing="0">
          <tr>
            <td><table width="850" border="0" align="center">
              <tr class="GG" id="GG">
                <td width="596" height="26" bgcolor="#F79935">NOMBRE SUCURSAL</td>
                <td width="150" bgcolor="#F79935">FOTOGRAFIA CARGADA</td>
                <td width="140" bgcolor="#F79935">VOTO DE AGENTE</td>
              </tr>
              <%try{%>
              <%int loopMatriz=1;String estado = "";%>
              <%while(!SQL_LlenaSucursales[loopMatriz][1].trim().equals("FIN")){%>
              <tr>
                <%//System.out.println("Es : " + SQL_LlenaSucursales[loopMatriz][3].trim());%>
                <td width="596" class="GG">
                    <%=SQL_LlenaSucursales[loopMatriz][1].trim()%>
                </td>

                <td class="ghg">
                    <%
                    try{
                    estado=SQL_LlenaSucursales[loopMatriz][4].trim();
                    if (estado==null || estado.trim().equals("")){estado="";}
                    }catch(Exception e){estado="";}
                    %>
                    <%if(estado.trim().equals("1")){%>
                        <img src="Img/tick_ok_sign_4190.jpg" width="11" height="11">
                    <%}else{%>
                        <img src="Img/not-ok-mark-clip-art_423235.jpg" width="11" height="11">
                    <%}%>
                </td>


                <td class="ghg">
                    <%
                    try{
                    estado=SQL_LlenaSucursales[loopMatriz][5].trim();
                    if (estado==null || estado.trim().equals("")){estado="";}
                    }catch(Exception e){estado="";}
                    %>
                    
                    <%if(estado.trim().equals("1")){%>
                        <img src="Img/tick_ok_sign_4190.jpg" width="11" height="11">
                    <%}else{%>
                        <img src="Img/not-ok-mark-clip-art_423235.jpg" width="11" height="11">
                    <%}%>

                </td>
              </tr>

            <%loopMatriz++;}%>
            <%
            }catch(Exception e){out.println("A Ocurrido un Error : " + e);}
            %>
            </table></td>
          </tr>
        </table>
        <br>
    <br>
 
      
    </body>

</html>
