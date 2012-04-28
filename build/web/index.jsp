
<%
String Error = request.getParameter("Error");
if( (Error==null) || (Error.length()==0) ){Error = "";}


String password = request.getParameter("password");
if( (password==null) || (password.length()==0) ){password = "";}
String username = request.getParameter("username");
if( (username==null) || (username.length()==0) ){username = "";}
%>
<style type="text/css">
<!--
.dds {
	font-family: Verdana, Geneva, sans-serif;
	font-weight: bold;
	font-size: 12px;
	color: #FFF;
}
.fgf {
	font-family: Verdana, Geneva, sans-serif;
}
.fdf {
	font-size: 10px;
}
.dffd {
	font-size: 14px;
}
.dds table tr td32 {
	font-size: 10px;
}
.ggh {
	font-family: Verdana, Geneva, sans-serif;
}
.hhhhh {
	font-size: 12px;
}
.ggh {
	font-size: 12px;
}
.hhhhg {
	font-size: 12px;
}
.hhnb {
	font-family: Verdana, Geneva, sans-serif;
}
.jhkjkj {
	font-size: 12px;
}
-->
</style>



<title>Concurso Sucursales</title>
<form name="form1" method="post" action="ValidaUsuario.jsp">
<br />
<br />
<br />
<table width="550" border="1" align="center" cellspacing="0">
  <tr>
    <td><table width="540" border="0" align="center" cellspacing="0">
      <tr bgcolor="#F79935">
        <td height="28" colspan="3" class="dds">Acceso Concurso Fotograf&iacute;as por Sucursal</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="145" class="hhnb"><span class="dffd">Usuario (Rut)</span></td>
        <td width="11"><span class="dffd">:</span></td>
        <td width="378"><span class="dffd">
                <input type="text" name="username" id="username" value="<%=username%>" />
          </span><span class="hhhhh"><span class="ggh">Ej: 13462179-5</span></span></td>
      </tr>
      <tr>
        <td class="hhnb"><span class="dffd">Password </span></td>
        <td><span class="dffd">:</span></td>
        <td><span class="hhhhh">
          <input name="password" id="password" type="password" value="<%=password%>"/>
        </span><span class="ggh">(Sus 4 primeros digitos del rut)</span></td>
      </tr>
      <tr>
        <td>
           
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3"><div align="center"> <span class="dffd">
          <input type="submit" name="button" id="button" value="Aceptar" />
        </span></div></td>
      </tr>
    </table></td>
  </tr>
</table>
<%if(Error.trim().equals("1")){%>
<br>
    <div align="center" class="ggh">
    <span class="ggh">Usuario o claves incorrectas, favor intente nuevamente. </span></div>
<%}%>

</form>

