<%@page import="ConeccionBD.Sqls"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            String user = request.getParameter("username");
            String pass = request.getParameter("password");
            user = user.replace("k","K");
            try {
                Sqls sqlGatilla = new Sqls();
                String[][] Matriz = new String[100][100];
                Matriz = sqlGatilla.SQL_LlenaObjetoSessionUsuario(user, pass);




                String codigoUsuario = Matriz[1][1].trim();
                String nombreCategoria = "";
                String codigoCategoria = "";

                // --- NOMBRE CATEGORIA MAS CODIGO CATEGORIA ACTIVOS SWITCH A CAMBIAR
                Concurso.ObtieneProperties f = new Concurso.ObtieneProperties();                
                nombreCategoria = f.getNombreCategoria();
                codigoCategoria = f.getCodigoConcurso();
                //  el id concurso esta dado por la tabla VOTA_CONCURSO
                // ---

                if ((!Matriz[1][1].trim().equals("FIN"))) {
                    HttpSession objSesion = request.getSession(true);
                    objSesion.setAttribute("usuario", Matriz[1][1].trim());
                    objSesion.setAttribute("nombre", Matriz[1][2].trim());
                    objSesion.setAttribute("email", Matriz[1][3].trim());
                    objSesion.setAttribute("puesto", Matriz[1][4].trim());
                    objSesion.setAttribute("lugar", Matriz[1][5].trim());
                    objSesion.setAttribute("area", Matriz[1][6].trim());
                    objSesion.setAttribute("rut", Matriz[1][7].trim());
                    objSesion.setAttribute("psw", Matriz[1][8].trim());
                    objSesion.setAttribute("vota", Matriz[1][9].trim());
                    objSesion.setAttribute("codigosucursal", Matriz[1][10].trim());
                    objSesion.setAttribute("codigocategoria", codigoCategoria.trim());
                    objSesion.setAttribute("nombrecategoria", nombreCategoria.trim());

                    Matriz = sqlGatilla.SQL_LlenaCuadroInformativoGeneral();
                    if ((!Matriz[1][1].trim().equals("FIN")) || (Matriz == null)) {
                        objSesion.setAttribute("idconcurso", Matriz[1][1].trim());
                        objSesion.setAttribute("fechainicio", Matriz[1][2].trim());
                        objSesion.setAttribute("fechafin", Matriz[1][3].trim());
                        objSesion.setAttribute("horainicio", Matriz[1][4].trim());
                        objSesion.setAttribute("horafin", Matriz[1][5].trim());
                        objSesion.setAttribute("totalvotos", Matriz[1][6].trim());
                        objSesion.setAttribute("totalusuarios", Matriz[1][7].trim());
                    }
                    sqlGatilla.SQL_InsertaLog(codigoUsuario, "Ingreso al Sistema.");
                    f=null;
                    response.sendRedirect("Principal.jsp");
                } else {
                    sqlGatilla.SQL_InsertaLog(user + "-" + pass, "Error al Ingresar al Sistema.");
                    f=null;
                    response.sendRedirect("index.jsp?Error=1");
                }
            } catch (Exception e) {
                System.out.println("Error Valida Usuario : " + e);
            }
%>