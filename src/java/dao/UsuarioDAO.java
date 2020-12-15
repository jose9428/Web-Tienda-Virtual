package dao;

import conexion.Conexion;
import entidad.*;
import java.sql.*;
import java.util.*;

public class UsuarioDAO {

    Connection cn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Categoria c = null;

    public Cliente IniciarSesion(String user, String pass) {
        Cliente c = null;

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LOGEAR_USUARIO(?,?)}");
            cs.setString(1, user);
            cs.setString(2, pass);
            rs = cs.executeQuery();

            if (rs.next()) {
                c = new Cliente();
                c.setNombreUsuario(rs.getString(1));
                c.setCodigoUsuario(rs.getInt(2));
                c.setNombres(rs.getString(3));
                c.setApePaterno(rs.getString(4));
                c.setApeMaterno(rs.getString(5));
                c.setDireccion(rs.getString(6));
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }

                if (cs != null) {
                    cs.close();
                }

                if (rs != null) {
                    rs.close();
                }

            } catch (Exception ex) {
            }

        }
        return c;
    }
}
