package dao;

import conexion.Conexion;
import entidad.*;
import java.sql.*;
import java.util.*;

public class VentaDAO {

    Connection cn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Categoria c = null;
    
    public ArrayList<Venta> ListaResumenVentas() {
        ArrayList<Venta> lista = new ArrayList<Venta>();
        
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call sp_listado_ventas_resumen()}");
            rs = cs.executeQuery();
            
            while (rs.next()) {
                Venta v = new Venta();
                v.setAnio(rs.getInt(2));
                v.setMes(rs.getString(3));
                v.setSumaTotal(rs.getDouble(4));
                lista.add(v);
                
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
    
      public int CantPedidosPendientes() {
        int cant = 0;

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_CANTIDAD_PEDIDOS_PENDIENTES()}");
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
