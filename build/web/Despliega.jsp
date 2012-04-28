<%@page import="ConeccionBD.Sqls"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<%
            HttpSession objSesion = request.getSession();

            if (objSesion == null) {
                response.sendRedirect("index.jsp");
            } else {
                String imagen = request.getParameter("imagen");

//String vota = (String)objSesion.getAttribute("vota");
                String vota = request.getParameter("b");
                ;
                request.getParameter("imagen");

//String usuario = (String)objSesion.getAttribute("usuario");

                String usuario = request.getParameter("a");
                ;
                String sucursal = request.getParameter("sucursal");
                String idfoto = request.getParameter("idfoto");

                Sqls sqlGatilla = new Sqls();

                String[][] NombreSucursal = new String[100][1];
                String[][] CuentaVotosxSucursal = new String[100][1];
                String[][] PoderVotar = new String[100][1];
                String[][] PoderVotarRepetir = new String[100][1];
                NombreSucursal = sqlGatilla.SQL_NombreSucursal(sucursal);
                CuentaVotosxSucursal = sqlGatilla.SQL_CuentaVotosxSucursal(idfoto);

                PoderVotar = sqlGatilla.SQL_PuedesVotar(usuario, sucursal);
                PoderVotarRepetir = sqlGatilla.SQL_PuedesVotarRepetir(usuario);
                String puedes = "";

                try {
                    if (PoderVotar == null || PoderVotar[1][1].trim().equals("") || PoderVotar[1][1].trim().equals("FIN")) {
                        PoderVotar[1][1].trim().equals("0");
                    }
                    if (PoderVotarRepetir == null || PoderVotarRepetir[1][1].trim().equals("")) {
                        PoderVotarRepetir[1][1].trim().equals("0");
                    }

                    if (PoderVotar[1][1].trim().equals("0") && PoderVotarRepetir[1][1].trim().equals("0")) {
                        puedes = "SI";
                    } else {
                        puedes = "NO";
                    }
                } catch (Exception e) {
                }

                Concurso.ObtieneProperties f = new Concurso.ObtieneProperties();
                String ruta = ruta = f.getRuta();


%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="Css/jquery.ad-gallery.css">
        <script type="text/javascript" src="Js/jquery.min.js"></script>
        <script type="text/javascript" src="Js/jquery.ad-gallery.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Concurso Sucursales</title>


        <style type="text/css">
            <!--
            .g {
                font-family: Verdana, Geneva, sans-serif;
            }
            .gg {
                font-family: "MS Serif", "New York", serif;
            }
            .gg {
                font-family: Verdana, Geneva, sans-serif;
            }
            .gg {
                font-size: 10px;
            }
            .hh {
                font-family: Verdana, Geneva, sans-serif;
            }
            .hh {
                font-family: Verdana, Geneva, sans-serif;
                font-size: 12px;
                font-weight: bold;
                color: #FFF;
            }
            -->
        </style>
    </head>
    <%try {%>
    <body>

        <table width="1000" border="0">
            <tr>
                <td width="600" rowspan="2">
                    <div style = "position:left ; top:55px ; right:15px ; width:600px;">
                        <img src="<%=ruta + imagen.trim()%>" width="600px" border="1" align="center">
                    </div>
                </td>
                <td width="390"><table width="350" align="center" cellspacing="0">
                        <tr bgcolor="#F79935">
                            <td height="21" colspan="3" class="hh">Votación de Usuario</td>
                        </tr>
                        <tr>
                            <td><span class="gg">Sucursal</span></td>
                            <td><span class="gg">:</span></td>
                            <td><span class="gg"><%=NombreSucursal[1][1].trim()%></span></td>
                        </tr>
                        <tr>
                            <td><span class="gg">Campaña</span></td>
                            <td><span class="gg">:</span></td>
                            <td><span class="gg"><%=f.getCodigoConcurso()%> - Cajas</span></td>
                        </tr>
                        <tr>
                            <td><span class="gg">Votación</span></td>
                            <td><span class="gg">:</span></td>
                            <td><span class="gg"><%=CuentaVotosxSucursal[1][1].trim()%> Votos.</span></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td><span class="gg">Votar aqui</span></td>
                            <td><span class="gg">:</span></td>
                            <td>
                                <%
                                    //out.println("vota : " + vota);
                                    //out.println("puedes : " + puedes);
%>
                                <%if (vota.trim().equals("No Vota")) {%>
                                <span class="gg">
                                    Este perfil de Usuario no tiene privilegios para Votar.<br>
                                    <input type="button" onclick="cerrar()" value="Cerrar">
                                </span>
                                <%} else {%>
                                <%if (puedes.trim().equals("SI")) {%>


                                <%

                                    if (f.getEstadoCategoria().trim().equals("Vota")) {
                                %>
                                <span class="gg">
                                    <form id="login" method="post" action="GrabaVoto.jsp">
                                        <span class="gg">
                                            <input type="button" onclick="submit()" value="Votar">
                                            <input type="hidden" name="sucursal" value ="<%=sucursal%>">
                                            <input type="hidden" name="iduser" value ="<%=usuario%>">
                                            <input type="hidden" name="idfoto" value ="<%=idfoto%>">
                                            <input type="hidden" name="idsucursal" value ="<%=sucursal%>">
                                            <input type="hidden" name="idcategoria" value ="<%=f.getCodigoCategoria()%>">
                                            </form>
                                        </span>
                                        <%} else {%>
                                        <span class="gg">
                                            El sistema de votación para esta Categoría aún no está activo.<br>
                                            <input type="button" onclick="cerrar()" value="Cerrar">
                                        </span>
                                        <%}%>




                                        <%} else {%>
                                        <%if (!PoderVotarRepetir[1][1].trim().equals("0")) {%>
                                        <span class="gg">
                                            Usted ya voto por esta Categoria.<br>
                                            <input type="button" onclick="cerrar()" value="Cerrar">
                                        </span>
                                        <%} else {%>
                                        <span class="gg">
                                            No puede efectuar Votaciones por su propia sucursal.<br>
                                            <input type="button" onclick="cerrar()" value="Cerrar">
                                        </span>
                                        <%}%>

                                        <%}%>
                                        <%}%>
                                        </td>
                                        </tr>
                                        </table>
                                        <br>
                                        <br></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                        </tr>
                                        </table>
                                        <%} catch (Exception e) {
        out.println("");
    }%>
                                        </body>
                                        </html>
                                        <%}%>
