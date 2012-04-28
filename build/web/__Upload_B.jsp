<xml version="1.0" encoding="iso-8859-1">    
<%@page import="org.apache.commons.fileupload.FileItemStream"%>
<%@page import="org.apache.commons.fileupload.FileItemIterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@page import="org.apache.commons.io.FilenameUtils" %>
<%@page import="java.util.*" %>
<%@page import="java.io.File" %>
<%@page import="java.lang.Exception" %>
<%@page import= "java.text.*" %>
<%@page import= "java.lang.*"%>
<%@page import="ConeccionBD.Sqls"%>

    <html><title>Concurso Sucursales</title>
        <body>
            <%
                HttpSession objSesion = request.getSession();                                                                                                                                                                
                String sucursal = (String)objSesion.getAttribute("codigosucursal");
                String usuario = (String)objSesion.getAttribute("usuario");                                
                String codigosucursal = (String)objSesion.getAttribute("codigosucursal");
                Concurso.ObtieneProperties f = new Concurso.ObtieneProperties();
                
                String[][] Matriz2 = new String[10][6];
                Sqls sqlGatilla = new Sqls();
                Matriz2 = sqlGatilla.SQL_DevuelveIdFoto();
                String idMax = Matriz2[1][1];
                               
                int loopMatriz = 1;
                String ruta1 = "/webfolders/aplicaciones/apache-tomcat-6.0.18/webapps/bancoestado.cl/ImagenesConcursoBE/"; 
                
                String estado = "";
                String mensaje = "";

                if (ServletFileUpload.isMultipartContent(request)) {
                    ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                    List fileItemsList = servletFileUpload.parseRequest(request);

                    String optionalFileName = "";
                    FileItem fileItem = null;                    
                    Iterator it = fileItemsList.iterator();
                    while (it.hasNext()) {
                        FileItem fileItemTemp = (FileItem) it.next();

                        if (fileItemTemp.isFormField()) {
                            if (fileItemTemp.getFieldName().equals("filename")) {
                                optionalFileName = fileItemTemp.getString();
                            }
                        } else {
                            fileItem = fileItemTemp;                            
                        }
                    }

                    if (fileItem != null) {
                        String fileName = fileItem.getName();
                            try{
                                String nombreFinal = "";
                                String nombreCompleto = fileName;
                                nombreCompleto = nombreCompleto.replaceAll("\\\\", "&&&&&");

                                if (nombreCompleto.indexOf("&&&&&") != -1) {
                                    StringTokenizer tokens=new StringTokenizer(nombreCompleto, "&&");
                                    while(tokens.hasMoreTokens()){
                                       nombreFinal = tokens.nextToken();
                                    }
                                }else{
                                     nombreFinal = fileName ;
                                }                                
                                fileName = nombreFinal;
                                
                            }catch(Exception e ){
                                System.out.println("Error es : " + e);
                            }

                        if (fileItem.getSize() > 0) {

                            if (fileItem.getSize() > 4000000) {
                                mensaje = "El peso del archivo no puede Exceder los 4 MB.";
                            } else {                                
                               out.println("El peso del archivo es : " + fileItem.getSize());
                               out.println("<br>");
                                String dirName = ruta1;

                                fileName = fileName.replace(' ', '_');
                                fileName = fileName.toLowerCase();

                                int largo = fileName.length();
                                String nombreArchivo = fileName.substring(0, fileName.lastIndexOf("."));
                                optionalFileName = nombreArchivo;

                                StringTokenizer tokenizer = new StringTokenizer(fileName, ".");
                                String extensionArchivo = "";
                                while (tokenizer.hasMoreTokens()) {
                                    extensionArchivo = tokenizer.nextToken();
                                }

                                optionalFileName =  f.getNombreCategoria() + "_" + f.getCodigoConcurso() + "_" + codigosucursal.trim() ;

                                fileName = optionalFileName + "." + extensionArchivo;
                                if (extensionArchivo.trim().toLowerCase().equals("jpg")
                                        || extensionArchivo.trim().toLowerCase().equals("gif")) {
                                    File saveTo = new File(dirName + fileName);
                                    try {                                        
                                        fileItem.write(saveTo);
                                        estado = "OK";
                                        mensaje = "El archivo ha sido asociado Correctamente.";
                                        sqlGatilla.SQL_InsertaLog(usuario, "El archivo ha sido asociado Correctamente.");
                                        if(idMax ==null){idMax = "1";}
                                        
                                        sqlGatilla.SQL_InsertaImagenBD(usuario, idMax, optionalFileName, extensionArchivo, sucursal);
                                        sqlGatilla.SQL_InsertaLog(usuario, "Fotografia Cargada.");
                                    } catch (Exception e) {
                                        estado = "NO";
                                        mensaje = "A ocurrido un Error en el Procedimiento, favor intentar Nuevamente." + e;
                                        sqlGatilla.SQL_InsertaLog(usuario, "Error al cargar Fotografia .");
                                        out.println("ERROR :" + mensaje);
                                    }
                                } else {
                                    estado = "NO";
                                    mensaje = "La extensión del archivo no corresponda a las Extensiones Permitidas (gif , jpg)";
                                    sqlGatilla.SQL_InsertaLog(usuario, "La extensión del archivo no corresponda a las Extensiones Permitidas (gif , jpg)");
                                }
                            }
                        }
                    }
                } else {
                    mensaje = "No se ha adjuntado ningun Archivo";
                    sqlGatilla.SQL_InsertaLog(usuario, "No se ha adjuntado ningun Archivo");
                    estado = "NO";
                }
                //out.println("El mensaje es : " + mensaje);
                response.sendRedirect( "Principal.jsp");
            %>
        </body>
    </html> 