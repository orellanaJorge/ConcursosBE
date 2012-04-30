<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ConeccionBD.Sqls"%>
<!DOCTYPE html>
<%
Sqls sqlGatilla = new Sqls();
HttpSession objSesion = request.getSession();
String usuario = (String) objSesion.getAttribute("usuario");
if (usuario == null) {
    response.sendRedirect("index.jsp");
} else {
    String nombre = (String) objSesion.getAttribute("nombre");           
    String vota = (String) objSesion.getAttribute("vota");
    String idconcurso = (String) objSesion.getAttribute("idconcurso");        
    String totalusuarios = (String) objSesion.getAttribute("totalusuarios");
    String codigosucursal = (String) objSesion.getAttribute("codigosucursal");
    String lugar = (String) objSesion.getAttribute("lugar");
    String nombrecategoria = (String) objSesion.getAttribute("nombrecategoria");
    String codigocategoria = (String) objSesion.getAttribute("codigocategoria");

%>
<html>
<%
Concurso.ObtieneProperties f = new Concurso.ObtieneProperties();

String[][] LlenaSliders = new String[100][7];
String[][] SQL_LlenaTopPositions = new String[100][3];
String[][] TotalVotosxCat = new String[100][3];

LlenaSliders = sqlGatilla.SQL_LlenaSlidersImagenes();

int loopMatriz = 1;
String ruta = ruta = f.getRuta();

SQL_LlenaTopPositions = sqlGatilla.SQL_LlenaTopPositions();
TotalVotosxCat = sqlGatilla.SQL_TotalVotosxCategorias();
if(TotalVotosxCat[1][1].trim().equals("FIN")){TotalVotosxCat[1][1] = "0";}
%>
<head>
        <link rel="stylesheet" type="text/css" href="Css/jquery.ad-gallery.css">
        <script type="text/javascript" src="Js/jquery.min.js"></script>
        <script type="text/javascript" src="Js/jquery.ad-gallery.js"></script>
    <script type="text/javascript">
            $(function() {
                $('img.image1').data('ad-desc', '-');
                $('img.image1').data('ad-title', '-');
                $('img.image4').data('ad-desc', '-');
                $('img.image5').data('ad-desc', '-');
                var galleries = $('.ad-gallery').adGallery();
                $('#switch-effect').change(
                function() {
                    galleries[0].settings.effect = $(this).val();
                    return false;
                }
            );
                $('#toggle-slideshow').click(
                function() {
                    galleries[0].slideshow.toggle();
                    return false;
                }
            );
                $('#toggle-description').click(
                function() {
                    if(!galleries[0].settings.description_wrapper) {
                        galleries[0].settings.description_wrapper = $('#descriptions');
                    } else {
                        galleries[0].settings.description_wrapper = false;
                    }
                    return false;
                }
            );
            });
        </script>

    <style type="text/css">
            * {
                font-family: "Lucida Grande", "Lucida Sans Unicode", "Lucida Sans", Verdana, Arial, sans-serif;
                color: #333;
                line-height: 140%;
            }
            select, input, textarea {
                font-size: 1em;
            }
            body {
	padding: 30px;
	font-size: 70%;
	width: 800px;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
            }
            h2 {
                margin-top: 1.2em;
                margin-bottom: 0;
                padding: 0;
                border-bottom: 1px dotted #dedede;
            }
            h3 {
                margin-top: 1.2em;
                margin-bottom: 0;
                padding: 0;
            }
            .example {
                border: 1px solid #CCC;
                background: #f2f2f2;
                padding: 10px;
            }
            ul {
                list-style-image:url(list-style.gif);
            }
            pre {
                font-family: "Lucida Console", "Courier New", Verdana;
                border: 1px solid #CCC;
                background: #f2f2f2;
                padding: 10px;
            }
            code {
                font-family: "Lucida Console", "Courier New", Verdana;
                margin: 0;
                padding: 0;
            }

            #gallery {
                padding: 30px;
                background: #E6E6E6;
            }
            #descriptions {
                position: relative;
                height: 50px;
                background: #EEE;
                margin-top: 10px;
                width: 640px;
                padding: 10px;
                overflow: hidden;
            }
            #descriptions .ad-image-description {
                position: absolute;
            }
            #descriptions .ad-image-description .ad-description-title {
                display: block;
            }
            #apDiv1 {
                position:absolute;
                left:34px;
                top:38px;
                width:932px;
                height:582px;
                z-index:1;
            }
        .wqe {
	color: #FFF;
	font-weight: bold;
}
        .aa {
	font-weight: bold;
}
        .qwwq {
	color: #F79935;
}
        .qwwq td2 {
	font-weight: bold;
}
        .RR {
	text-align: left;
}
        .RR {
	text-align: left;
}
        .RR {
	text-align: left;
}
        .RR {
	text-align: left;
}
        .RR {
}
        .yyh {
	color: #F79935;
	font-weight: bold;
}
        yy {
	font-size: 16%;
}
        yy {
	font-size: 16px;
}
        .yy {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #FFF;
}
    uu {
	font-weight: bold;
}
    uu {
	font-weight: bold;
}
    uu {
	font-weight: bold;
}
    .uuu {
	font-family: Verdana, Geneva, sans-serif;
	font-weight: bold;
}
    uuu {
	font-size: 70px;
}
    uuu {
	font-size: 16%;
}
    .uuuu {
	font-size: 14px;
	font-family: "Arial Black", Gadget, sans-serif;
}
    a:link {
	color: #FFF;
}
a:visited {
	color: #FFF;
	font-weight: bold;
	font-size: 16%;
}
.tgr {
	color: #FFF;
}
    </style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><title>Concurso Sucursales</title></head>
    <body>
    <form>
        <%
            String[][] muestracategoria = new String[100][7];
            String[][] estadovotaciones = new String[100][7];
            muestracategoria = sqlGatilla.SQL_PuedeIngresarFoto(codigosucursal);
        %>

       
        <table width="1046" border="0">        
          <tr>
            
            <%if (!LlenaSliders[loopMatriz][1].trim().equals("FIN")) {%>
            <td width="610" rowspan="3">
            <div id="gallery" class="ad-gallery"> 
                <div class="ad-image-wrapper">
                </div>
                <div class="ad-controls">
                </div>
                <div class="ad-nav"> 
                    <div class="ad-thumbs">
                        <ul class="ad-thumb-list">
                            <%if (!LlenaSliders[loopMatriz][1].trim().equals("FIN")) {%>
                                 <%while (!LlenaSliders[loopMatriz][1].trim().equals("FIN")) {%>
                            <li>
                                <a href="<%=ruta + LlenaSliders[loopMatriz][5].trim()%>">
                                    <img src="<%=ruta + LlenaSliders[loopMatriz][5].trim()%>" title="<%=nombrecategoria%>"
                                         alt="<%=LlenaSliders[loopMatriz][4].trim()%>" longdesc="Despliega.jsp?imagen=<%=LlenaSliders[loopMatriz][5].trim()%>&sucursal=<%=LlenaSliders[loopMatriz][6].trim()%>&idfoto=<%=LlenaSliders[loopMatriz][7].trim()%>&categoria=<%=codigocategoria.trim()%>&a=<%=usuario.trim()%>&b=<%=vota.trim()%>">
                                </a>
                            </li>
                            <%loopMatriz++;
                                }%>
                            <%}%>
                        </ul>
                    </div>
                        </div>
                        </div>

            </td>
            <%}else{%>
                   <td width="52" rowspan="3"><table width="200" border="0" align="center" cellspacing="0">
                  <tr>
                    <td><table border="0" align="center">
                      <tr>
                        <td>
                            <img src="Img/AvisoConcurso.jpg" width="294" height="352">
                        <%if (f.getCodigoCategoria().trim().equals("1")){%><img src="Img/Aes.jpg" width="294" height="352"><%}%>
                        <%if (f.getCodigoCategoria().trim().equals("2")){%><img src="Img/Aca.jpg" width="294" height="352"><%}%>
                        <%if (f.getCodigoCategoria().trim().equals("3")){%><img src="Img/Ase.jpg" width="294" height="352"><%}%>
                        <%if (f.getCodigoCategoria().trim().equals("4")){%><img src="Img/Acaj.jpg" width="294" height="352"><%}%>
                        <%if (f.getCodigoCategoria().trim().equals("5")){%><img src="Img/Aha.jpg" width="294" height="352"><%}%>
                        <%if (f.getCodigoCategoria().trim().equals("6")){%><img src="Img/Aex.jpg" width="294" height="352"><%}%>
                        </td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>

            <%}%>
            


            <td width="673">
            <div align="center">           
                <table width="370" border="0" align="center">
                  <tr bgcolor="#F79935">
                    <td colspan="3" class="yy">&nbsp;Antecedentes Concurso - (<a href="EstadoVotacion.jsp" target="_blank">Ver Estado</a>)</td>
                  </tr>
                  <tr>
                    <td width="100" class="RR">Categoria</td>
                    <td width="3">:</td>
                    <td width="383" class="RR">

                    <span class="yyh"><%=nombrecategoria%></span></td>
                  </tr>
                  <tr>
                    <td class="RR">Concurso</td>
                    <td>:</td>
                    <td class="RR"><%=idconcurso%></td>
                  </tr>
                  <tr>
                    <td class="RR">Total Usuarios</td>
                    <td>:</td>
                    <td class="RR"><%=totalusuarios%></td>
                  </tr>
                  <tr>
                    <td class="RR">Votos Realizados</td>
                    <td>:</td>
                    <td class="RR"><%=TotalVotosxCat[1][1]%></td>
                  </tr>
                  <tr>
                    <td class="RR">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td class="RR">&nbsp;</td>
                  </tr>
                    <tr bgcolor="#F79935">
                    <td height="24" colspan="3" class="RR"><a href="Resultados.jsp" target="_blank"><span class="yy">Ganadores del Concurso.</span></a></td>
                  </tr>
                    
                    
             

                  <tr>
                    <td colspan="3"><br>
                      <table width="200" border="0" align="center">
                          <%if (f.getEstadoCategoria().trim().equals("Sube")) {%>
                            <%
                            estadovotaciones  = sqlGatilla.SQL_PuedeIngresarFotoAun(codigosucursal);
                            if(estadovotaciones[1][1].trim().equals("1")){}else{
                            %>
                              <tr>
                                <td>
                                    <a href="DireccionaVoto.jsp?id=1"DireccionaVoto.jsp?id=1"><img src="Img/Files-Upload-File-icon.jpg" width="146" height="26" border="0"></a>
                                </td>
                              </tr>
                          <%}%>
                          <%}%>



                  
                    </table></td>
                  </tr>

                  <!--Aviso para VOTAR SE ACTIVA EN VOTAR -->
                  <%
                  if(f.getEstadoCategoria().trim().equals("Vota")){
                  %>
                  <tr>
                    <td colspan="3"><table width="100" border="0" align="center">
                      <tr>
                          <td><img src="Img/Aviso.png" width="278" height="68"></td>
                      </tr>
                    </table></td>
                  </tr>
                  <%}%>


                </table>
            </div>
            </td>
          </tr>
          <tr>
            <td>
            <div align="center">
              <table width="370" border="0" align="center">
                <tr bgcolor="#F79935">
                  <td colspan="3" class="yy">&nbsp;Usuario Actual</td>
                </tr>
                <tr>
                  <td width="100" class="RR">Usuario</td>
                  <td width="3">:</td>
                  <td width="383" class="RR"><%=nombre%></td>
                </tr>
                <tr>
                  <td class="RR">Sucursal</td>
                  <td>:</td>
                  <td class="RR"><%=lugar%></td>
                </tr>
                <tr>
                  <td class="RR">Permisos</td>
                  <td>:</td>
                  <td class="RR"><%=vota%></td>
                </tr>                
              </table>              
            </div>
            </td>
          </tr>
          <tr>
          <br>
            
              
            <td>
            <div align="center">
                <br>
              <table width="370" border="0" align="center">
                <%int i=1;if(SQL_LlenaTopPositions[i][1].trim().equals("FIN")){%>
                    <tr class="RR">
                      <td width="231"><span class="tgr"><%="x"%>d</span></td>
                      <td width="3"></td>
                      <td width="122"><span class="tgr"><%="x"%></span></td>
                    </tr>
                    <tr class="RR">
                      <td width="231"><span class="tgr"><%="x"%></span></td>
                      <td width="3"></td>
                      <td width="122"><span class="tgr"><%="x"%></span></td>
                    </tr>
                    <tr class="RR">
                      <td width="231"><span class="tgr"><%="x"%></span></td>
                      <td width="3"></td>
                      <td width="122"><span class="tgr"><%="x"%></span></td>
                    </tr>
                <%}else{%>
                    <%
                    int ghj = 1;
                    while(!SQL_LlenaTopPositions[i][1].trim().equals("FIN")){if(i==4){break;}%>
                    <%if(ghj==1){%>
                        <tr bgcolor="#F79935" class="qwwq">
                        <td colspan="3" class="yy">&nbsp;Votaciones por <%=nombrecategoria%></td>
                        </tr>
                    <%ghj++;}%>
                    <tr class="RR">
                      <td width="231"><%=i + " - Sucursal " + SQL_LlenaTopPositions[i][2].trim()%></td>
                      <td width="3">:</td>
                      <td width="122"><%=SQL_LlenaTopPositions[i][1].trim()%></td>
                    </tr>
                    <%i++;}%>
                <%}%>

              </table>
            </div>
            </td>
          </tr>
      </table>
 </form>
    </body>
</html>
<%}%>