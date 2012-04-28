/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Concurso;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *
 * @author Jorge
 */
public class ObtieneProperties {
    private String nombreCategoria;
    private String codigoCategoria;
    private String codigoConcurso;
    private String estadoCategoria;
    private String ruta;

    public String getRuta() {
        return ruta;
    }

    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

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


    public ObtieneProperties(){
        try{
            Properties prop = new Properties();
            prop.load( getClass().getResourceAsStream("Concursos.properties") );
            String a = prop.getProperty("Concurso");
            this.setNombreCategoria(prop.getProperty("nombreCategoria"));
            this.setCodigoCategoria(prop.getProperty("codigoCategoria"));
            this.setCodigoConcurso(prop.getProperty("codigoConcurso"));
            this.setEstadoCategoria(prop.getProperty("estadoCategoria"));
            this.setRuta(prop.getProperty("ruta"));
        }catch (Exception e) {}
    }
    
}
