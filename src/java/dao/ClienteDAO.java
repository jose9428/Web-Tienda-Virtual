package dao;

import conexion.Conexion;
import entidad.*;
import java.sql.*;
import java.util.*;

public class ClienteDAO {

    Connection cn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Categoria c = null;

    public ArrayList<Cliente> ListadoClientes() {
        ArrayList<Cliente> lista = new ArrayList<>();

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_CLIENTES()}");
            rs = cs.executeQuery();

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setDni(rs.getString(3));
                c.setNombres(rs.getString(4));
                c.setApePaterno(rs.getString(5));
                c.setApeMaterno(rs.getString(6));
                c.setDireccion(rs.getString(7));
                c.setTelefono(rs.getString(8));
                c.setFechaNacimiento(rs.getString(9));
                c.setEmail(rs.getString(10));
                c.setNombreUsuario(rs.getString(11));
                lista.add(c);
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
        return lista;
    }

    public String AgregarCliente(Cliente c) {
        String res = "";

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_AGREGAR_CLIENTE(?,?,?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter(1, Types.VARCHAR);
            cs.setString(2, c.getNombreUsuario());
            cs.setString(3, c.getContraseña());
            cs.setString(4, c.getDni());
            cs.setString(5, c.getNombres());
            cs.setString(6, c.getApePaterno());
            cs.setString(7, c.getApeMaterno());
            cs.setString(8, c.getDireccion());
            cs.setString(9, c.getTelefono());
            cs.setString(10, c.getFechaNacimiento());
            cs.setString(11, c.getEmail());
            cs.executeUpdate();

            res = cs.getString(1);

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

            } catch (Exception ex) {
            }

        }
        return res;
    }

    public int CantCliente() {
        int cant = 0;

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_CANTIDAD_CLIENTES()}");
            rs = cs.executeQuery();

            if (rs.next()) {
                cant = rs.getInt(1);
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

            } catch (Exception ex) {
            }

        }
        return cant;
    }
}
