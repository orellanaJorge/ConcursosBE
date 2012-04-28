package ConeccionBD;

import ConeccionBD.OperacionBD.*;

public class Sqls {
    private String nombreCategoria;
    private String codigoCategoria;
    private String codigoConcurso;
    private String estadoCategoria;

    public String getCodigoCategoria() {
        return codigoCategoria;
    }

    public void setCodigoCategoria(String codigoCategoria) {
        this.codigoCategoria = codigoCategoria;
    }

    public String getCodigoConcurso() {
        return codigoConcurso;
    }

    public void setCodigoConcurso(String codigoConcurso) {
        this.codigoConcurso = codigoConcurso;
    }

    public String getEstadoCategoria() {
        return estadoCategoria;
    }

    public void setEstadoCategoria(String estadoCategoria) {
        this.estadoCategoria = estadoCategoria;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }

    public Sqls(){
     Concurso.ObtieneProperties f = new Concurso.ObtieneProperties();
        nombreCategoria = f.getNombreCategoria();
        codigoCategoria = f.getCodigoCategoria();
        codigoConcurso = f.getCodigoConcurso();
        estadoCategoria = f.getEstadoCategoria();
    }


public  String[][] SQL_EstadoVotacion() {
    String valor = "";
    String[][] Matriz = new String[200][200];
    try{
        OperacionBD OperaBD = new OperacionBD();
        String sql = " select  L.NMB_LUGAR||' ('||nombre||')' nombre ";
        sql+= " ,  U.CDG_LUGAR ";
        sql+= " ,  U.ID_USUARIO ";
        sql+= " ,( select count(*)  ";
        sql+= " from   VOTA_UPLOAD_FOTO  f ";
        sql+= " where F.CATEGORIA      =  " + this.codigoCategoria.trim();
        sql+= " and     F.ID_CONCURSO  =  " + this.codigoConcurso.trim();
        sql+= " and     id_sucursal          = U.CDG_LUGAR)  foto ";
        sql+= " ,(select count(*)   ";
        sql+= " from    VOTA_VOTACION ";
        sql+= " where  ID_CONCURSO =  " + this.codigoConcurso.trim();;
        sql+= " and     ID_USUARIO     = U.ID_USUARIO ";
        sql+= " and     ID_CATEGORIA = " + this.codigoCategoria.trim()+ ")  voto ";
        sql+= " from    VOTA_USUARIOS   u ";
        sql+= " , VOTA_DIM_LUGAR  l ";
        sql+= " where  cdg_grupo     = 1 ";
        sql+= " and    U.CDG_LUGAR  = L.CDG_LUGAR ";
        
        Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 5, 4);
        OperaBD = null;
    }catch  (Exception e) {
        Matriz[99][99] = "Error SQL_SubidaFotoUsuario: " + e;
        Matriz = null;
    }
    return Matriz;
}


public String[][] SQL_InsertaLog(String codigoUsuario, String accion) {
    String[][] Matriz = new String[200][200];
    try{
        OperacionBD OperaBD = new OperacionBD();
        String sql = " INSERT INTO VOTA_LOG (CODIGOUSUARIO, ACCION, LAST_UPDATE, ID_CONCURSO, ID_CATEGORIA) ";
        sql+= " VALUES (" +codigoUsuario + ",'" + accion+ "' , sysdate , " + this.codigoConcurso+ ", " + this.codigoCategoria+ " )";
        OperaBD.SQL_Ejecuta_Accion_Update_Insert_Delete(sql, 4, 0, 0);
        OperaBD = null;
    }catch  (Exception e) {
        Matriz[99][99] = "Error SQL_InsertaLog: " + e;
    }
    return Matriz;
}

public String SQL_SubidaFotoUsuario(String idUsuario) {
        String valor = "";
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = "select id_concurso from ";
            sql+= " VOTA_UPLOAD_FOTO a  ";
            sql+= " where a.categoria = " + this.codigoCategoria;
            sql+= " and a.id_concurso = " + this.codigoConcurso;
            sql+= " and id_usuario = " + idUsuario;
            System.out.println("SQL : " + sql);
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;

             if (Matriz[1][1].trim().equals("FIN")) {
                 valor="NO";
             }else{valor="SI";}
             Matriz = null;

        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_SubidaFotoUsuario: " + e;
        }
        return valor;
    }

public String SQL_VotoFotoUsuario(String idUsuario) {
        String valor = "";
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = "select id_concurso from ";
            sql+= " VOTA_VOTACION ";
            sql+= " where id_concurso = " + this.codigoConcurso;
            sql+= " and id_categoria = " + this.codigoCategoria;
            sql+= " and id_usuario =  " + idUsuario;
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;

             if (Matriz[1][1].trim().equals("FIN")) {
                 valor="NO";
             }else{valor="SI";}
             Matriz = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_VotoFotoUsuario: " + e;
        }
        return valor;
    }


     public String[][] SQL_LlenaSituacionSucursales_1() {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = "select a.cdg_lugar, b.NMB_LUGAR , a.id_usuario";
            sql+= " from VOTA_USUARIOS a, VOTA_DIM_LUGAR b ";
            sql+= " where a.cdg_puesto in (360,120,170,270,150,300) ";
            sql+= " and a.CDG_LUGAR = b.CDG_LUGAR ";
            sql+= " order by nmb_lugar ";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 3, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_LlenaSituacionSucursales_1: " + e;
        }
        return Matriz;
    }

    public String[][] SQL_LlenaObjetoSessionUsuario(String user, String pass) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = "select ";
            sql += " a.id_usuario, ";
            sql += " a.nombre ,  ";
            sql += " a.email ,  ";
            sql += " b.NMB_PUESTO ,  ";
            sql += " c.NMB_LUGAR ,  ";
            sql += " d.NMB_AREA ,  ";
            sql += " a.rut ,  ";
            sql += " a.psw , ";
            sql +=  "e.NMB_GRUPO , ";
            sql +=  "c.CDG_LUGAR ";
            sql += " from vota_usuarios a ,  ";
            sql += " vota_dim_puesto b ,  ";
            sql += " VOTA_DIM_LUGAR c ,  ";
            sql += " VOTA_DIM_area d ,  ";
            sql += " VOTA_DIM_GRUPO e ";
            sql += " where a.CDG_PUESTO = b.CDG_PUESTO ";
            sql += " and a.CDG_LUGAR = c.CDG_LUGAR ";
            sql += " and a.cdg_area = d.CDG_AREA ";
            sql += " and a.CDG_GRUPO = e.CDG_GRUPO ";
            sql += " and a.rut = '" + user.trim() + "' ";
            sql += " and a.psw = '" + pass.trim() + "' ";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 10, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_LlenaObjetoSessionUsuario: " + e;
        }
        return Matriz;
    }

    public String[][] SQL_LlenaCuadroInformativoGeneral() {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = "";
            sql = " select id_concurso , ";
            sql+= " fx_inicio,  ";
            sql+= " fx_fin,  ";
            sql+= " hr_inicio, ";
            sql+= " hr_fin, ";
            sql+= " total_votos,  ";
            sql+= " total_usuarios ";
            sql+= " from VOTA_CONCURSO ";
            sql+= " where estado = 'A' ";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 7, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_LlenaCuadroInformativoGeneral: " + e;
        }
        return Matriz;
    }

    public String[][] SQL_LlenaSlidersImagenes() {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select ";
            sql += " a.ID_CONCURSO , ";
            sql += " c.NMB_LUGAR ,  ";
            sql += " b.REGION ,  ";
            sql += " c.NMB_LUGAR  , ";
            sql += " a.DSC_FOTO  ,  b.CDG_LUGAR , a.id_foto ";
            sql += " from ";
            sql += " VOTA_UPLOAD_FOTO a ,  ";
            sql += " vota_usuarios b ,  ";
            sql += " VOTA_DIM_LUGAR c ";
            sql += " where a.ID_USUARIO = b.ID_USUARIO ";
            sql += " and b.CDG_LUGAR = c.CDG_LUGAR ";
            sql += " and a.ID_CONCURSO = " + this.codigoConcurso;
            sql += " and a.CATEGORIA = " + this.codigoCategoria ;
            sql += " order by a.LAST_UPDATE desc ";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 7, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_LlenaSlidersImagenes: " + e;
        }
        return Matriz;
    }

     public String[][] SQL_LlenaTopPositions() {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " SELECT count(a.id_foto) , b.NMB_LUGAR ";
            sql += " FROM  ";
            sql += " VOTA_UPLOAD_FOTO a  ,    ";
            sql += " VOTA_DIM_LUGAR b ,  ";
            sql += " VOTA_VOTACION c ";
            sql += " where a.ID_SUCURSAL = b.CDG_LUGAR ";
            sql += " and a.ID_CONCURSO = " + this.codigoConcurso;
            sql += " and a.ID_FOTO = c.ID_FOTO ";
            sql += " and a.CATEGORIA = " + this.codigoCategoria;
            sql += " group by a.id_foto , b.NMB_LUGAR ";
            sql += " order by count(a.id_foto) desc ";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 2, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_LlenaTopPositions: " + e;
        }
        return Matriz;
    }

     public String[][] SQL_TotalVotosxCategorias() {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = "  select total_votos from ";
            sql+= " VOTA_CONCURSO ";
            sql+= " where id_concurso = " + this.codigoConcurso;
            sql += " and categoria = " + this.codigoCategoria;
            sql += " and estado = '" + "A'";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_TotalVotosxCategorias: " + e;
        }
        return Matriz;
    }

     public String[][] SQL_NombreSucursal(String sucursal) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select nmb_lugar ";
            sql+= " from VOTA_DIM_LUGAr ";
            sql+= " where cdg_lugar = " + sucursal.trim();
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_NombreSucursal: " + e;
        }
        return Matriz;
    }

     public String[][] SQL_CuentaVotosxSucursal(String foto) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select count(a.id_foto) ";
            sql+= " from ";
            sql+= " VOTA_VOTACION a,   ";
            sql+= " VOTA_UPLOAD_FOTO b  ";
            sql+= " where a.id_concurso = " + this.codigoConcurso;
            sql+= " and b.id_foto = " + foto.trim();
            sql+= " and a.ID_FOTO = b.ID_FOTO  ";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_NombreSucursal: " + e;
        }
        return Matriz;
    }

      public String[][] SQL_DevuelveIdFoto() {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select max(id_foto) + 1 ";
            sql+= " from ";
            sql+= " VOTA_UPLOAD_FOTO ";
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_DevuelveIdFoto: " + e;
        }
        return Matriz;
    }

       public String[][] SQL_DevuelveConcurso(String id) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select * from CONCURSO_SUCURSALES where id = " + id.trim();
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 6, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_DevuelveConcurso: " + e;
        }
        return Matriz;
    }

       public String[][] SQL_InsertaImagenBD(String usuario, String idMax , String optionalFileName, String extensionArchivo, String sucursal ) {
        String[][] Matriz = new String[200][200];
        try{           
            OperacionBD OperaBD = new OperacionBD();
            String sql = " insert into VOTA_UPLOAD_FOTO (id_concurso, id_usuario, id_foto, dsc_foto , id_sucursal , categoria , last_update) ";
            sql+= " values (" + this.codigoConcurso+ " , " + usuario.trim()+ " , " + idMax.trim()+ " , '" + optionalFileName + "." + extensionArchivo +"' , " + sucursal.trim()+ " , " + this.codigoCategoria+ " , sysdate )";
            OperaBD.SQL_Ejecuta_Accion_Update_Insert_Delete(sql, 4, 0, 0);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_InsertaImagenBD: " + e;
        }
        return Matriz;
    }

       public String[][] SQL_PuedeIngresarFoto(String idsucursal) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select * from ";
            sql+= " VOTA_UPLOAD_FOTO ";
            sql+= " where id_sucursal = " + idsucursal.trim();
            sql+= " and categoria =  " +this.codigoCategoria;
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_PuedeIngresarFoto: " + e;
        }
        return Matriz;
    }

       public String[][] SQL_PuedeIngresarFotoAun(String idsucursal) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select count(id_sucursal) from ";
            sql+= " VOTA_UPLOAD_FOTO ";
            sql+= " where id_sucursal = " + idsucursal.trim();
            sql+= " and (categoria = " + this.codigoCategoria+ " ) ";
            sql+= " and id_concurso =  " + this.codigoConcurso;
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_PuedeIngresarFotoAun: " + e;
        }
        return Matriz;
    }

        public String[][] SQL_PuedesVotar(String usuario, String sucursal) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " select count(*) from ";
            sql+= " VOTA_UPLOAD_FOTO ";
            sql+= " where id_usuario = " + usuario.trim();
            sql+= " and id_sucursal = " + sucursal.trim();
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_PuedesVotar: " + e;
        }
        return Matriz;
    }

        public String[][] SQL_PuedesVotarRepetir(String idusuario) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
           String sql = " select count(*) from ";
           sql+= " VOTA_VOTACION ";
           sql+= " where id_categoria =  " + this.codigoCategoria;
           sql+= " and id_usuario =  " + idusuario;
            Matriz = OperaBD.SQL_Dev_Matriz_Env_Sql(sql, 1, 4);
            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_PuedesVotarRepetir: " + e;
        }
        return Matriz;
    }

        public String[][] SQL_InsertaVotoBD(String iduser, String idfoto , String idsucursal) {
        String[][] Matriz = new String[200][200];
        try{
            OperacionBD OperaBD = new OperacionBD();
            String sql = " insert into VOTA_VOTACION (id_concurso, id_usuario, id_foto, id_sucursal , id_categoria) values (";
            sql+= this.codigoConcurso + "," +  iduser + "," + idfoto + "," + idsucursal + "," + this.codigoCategoria + ")";
            OperaBD.SQL_Ejecuta_Accion_Update_Insert_Delete(sql, 4, 0, 0);
            Matriz[1][1] = sql;

            sql = " update  VOTA_CONCURSO ";
            sql+= " set total_votos = total_votos + 1 ";
            sql+= " where id_concurso = " + this.codigoConcurso;
            sql+= " and categoria = " + this.codigoCategoria;
            Matriz[1][2] = sql;
            OperaBD.SQL_Ejecuta_Accion_Update_Insert_Delete(sql, 4, 0, 0);

            OperaBD = null;
        }catch  (Exception e) {
            Matriz[99][99] = "Error SQL_InsertaVotoBD: " + e;
        }
        return Matriz;
    }
     
}
