package dao;

import conexion.*;
import entidad.*;
import java.sql.*;
import java.util.ArrayList;

public class FacturaDAO {

    Connection cn = null;
    CallableStatement cs = null;
    ResultSet rs = null;

    public ArrayList<Factura> ListadoPedidosClientes() {
        ArrayList<Factura> lista = new ArrayList<>();

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_PEDIDOS_CLIENTES()}");
            rs = cs.executeQuery();

            while (rs.next()) {
                Factura f = new Factura();
                f.setNroFactura(rs.getString(1));
                f.setFecha(rs.getString(2));
                f.setNombres(rs.getString(3));
                f.setApePaterno(rs.getString(4));
                f.setApeMaterno(rs.getString(5));
                f.setMonto(rs.getDouble(6));
                f.setEstado(rs.getBoolean(7));

                lista.add(f);
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

    public ArrayList<Factura> ListadoFacturas(int code) {
        ArrayList<Factura> lista = new ArrayList<>();

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LIST_PEDIDOS(?)}");
            cs.setInt(1, code);
            rs = cs.executeQuery();

            while (rs.next()) {
                Factura f = new Factura();
                f.setNroFactura(rs.getString(1));
                f.setIdCliente(rs.getInt(2));
                f.setFecha(rs.getString(3));
                f.setMonto(rs.getDouble(4));
                f.setEstado(rs.getBoolean(5));

                lista.add(f);
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

    public String GenerarFactura(Factura f, ArrayList<Compra> carrito) {
        String nro = "" + f.getIdCliente();
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_GENERAR_FACTURA(?,?,?)}");
            cs.registerOutParameter(1, Types.VARCHAR);
            cs.setInt(2, f.getIdCliente());
            cs.setDouble(3, TotalCompraCarrito(carrito));
            cs.executeUpdate();

            nro = cs.getString(1);

            for (Compra c : carrito) {
                CallableStatement cs2 = cn.prepareCall("{call SP_GENERAR_DETALLE_FACTURA(?,?,?,?)}");
                cs2.setString(1, nro);
                cs2.setInt(2, c.getCodigoArticulo());
                cs2.setDouble(3, c.getPrecio());
                cs2.setInt(4, c.getCantidad());
                cs2.executeUpdate();
            }

            System.out.println("Numero : " + nro);

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
        return nro;
    }

    public int CancelarPedido(String nroFact) {
        int res = 0;
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_CANCELAR_PEDIDO(?)}");
            cs.setString(1, nroFact);

            res = cs.executeUpdate();

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
        return res;
    }

    public double TotalCompraCarrito(ArrayList<Compra> lista) {
        double total = 0;
        for (Compra c : lista) {
            total += c.Total();
        }

        return total;
    }

    public ArrayList<Compra> ListadoDetalleFactura(String nro) {
        ArrayList<Compra> lista = new ArrayList<>();

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_DETALLE_FACTURA(?)}");
            cs.setString(1, nro);
            rs = cs.executeQuery();

            while (rs.next()) {
                Compra c = new Compra();
                c.setNombreArticulo(rs.getString(1));
                c.setImagen(rs.getString(2));
                c.setPrecio(rs.getDouble(3));
                c.setCantidad(rs.getInt(4));
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

}
