<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Concurso Sucursales</title>
    <style type="text/css">
<!--
body {
	background-image: url(Img/FondoAdjuntar.jpg);
	background-repeat: repeat-x;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.Estilo2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
.Estilo4 {
	color: #000;
	font-family: Verdana, Geneva, sans-serif;
	font-weight: bold;
	font-size: 12px;
}
.Estilo5 {
	color: #990000;
	font-family: "Courier New", Courier, monospace;
	font-weight: bold;
	font-size: 12px;
}
.dff {
	color: #F79935;
}
.gf {
	color: #F79935;
}
fr {
	color: #FFF;
}
fr {
	font-weight: bold;
}
fr {
	font-weight: bold;
}
fr {
	font-family: Verdana, Geneva, sans-serif;
}
.dsf {
	color: #C93;
}
.ddd {
	color: #FFF;
	font-weight: bold;
	font-family: Verdana, Geneva, sans-serif;
	font-size: 12px;
}
-->
    </style></head>
    <body>

<form action="__Upload_B.jsp" method="post" enctype="multipart/form-data">

<br>
<table width="600" border="1" align="center" cellspacing="0">
  <tr bgcolor="#FF3333">
    <td colspan="2" bgcolor="#F79935"><div align="center" class="ddd">Adjuntar Archivo</div></td>
    </tr>
  <tr>
    <td><span class="Estilo2">Seleccione el archivo:</span></td>
    <td><span class="Estilo2">
      <input name="myFile" type="file"/>
    </span></td>
    </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" value="Adjuntar"/>
    </div></td>
    </tr>
</table>
  <br>
</form>

</body> 
</html>
