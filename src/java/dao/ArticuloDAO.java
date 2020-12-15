package dao;

import conexion.*;
import entidad.*;
import java.sql.*;
import java.util.ArrayList;

public class ArticuloDAO {
    
    Connection cn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Articulo a = null;
    
    
    public int ActualizarEstadoArticulo(int code, boolean estado) {
        int res = 0;
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_ACTUALIZAR_ESTADO_ARTICULO(?,?)}");
            cs.setInt(1, code);
            cs.setBoolean(2, estado);
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
    
    public int AgregarArticulo(Articulo a) {
        int res = 0;
        
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_AGREGAR_ARTICULO(?,?,?,?,?,?)}");
            cs.setInt(1, a.getCodigoCategoria());
            cs.setString(2, a.getNombreArticulo());
            cs.setDouble(3, a.getPrecioArticulo());
            cs.setInt(4, a.getStock());
            cs.setString(5, a.getDescripcionArticulo());
            cs.setString(6, a.getImagenArticulo());
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
                
            } catch (Exception ex) {
            }
            
        }
        return res;
    }
    
      public int ModificarArticulo(Articulo a) {
        int res = 0;
        
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_ACTUALIZAR_ARTICULO(?,?,?,?,?,?,?)}");
            cs.setInt(1, a.getCodigoCategoria());
            cs.setString(2, a.getNombreArticulo());
            cs.setDouble(3, a.getPrecioArticulo());
            cs.setInt(4, a.getStock());
            cs.setString(5, a.getDescripcionArticulo());
            cs.setString(6, a.getImagenArticulo());
            cs.setInt(7, a.getCodigoArticulo());
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
                
            } catch (Exception ex) {
            }
            
        }
        return res;
    }
    
       public int EliminarArticulo(int code) {
        int res = 0;
        
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_ELIMINAR_ARTICULO(?)}");
            cs.setInt(1, code);
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
                
            } catch (Exception ex) {
            }
            
        }
        return res;
    }
    
    public ArrayList<Articulo> ListadoArticuloDisponible(int code) {
        ArrayList<Articulo> lista = new ArrayList<>();
        
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_ARTICULO_DISPONIBLE(?)}");
            cs.setInt(1, code);
            rs = cs.executeQuery();
            
            while (rs.next()) {
                a = new Articulo();
                a.setCodigoArticulo(rs.getInt(1));
                a.setCodigoCategoria(rs.getInt(2));
                a.setNombreArticulo(rs.getString(3));
                a.setPrecioArticulo(rs.getDouble(4));
                a.setStock(rs.getInt(5));
                a.setDescripcionArticulo(rs.getString(6));
                a.setImagenArticulo(rs.getString(7));
                a.setEstadoCategoria(rs.getBoolean(8));
                lista.add(a);
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
    
     public ArrayList<Articulo> ListadoArticuloDisponible2(int code) {
        ArrayList<Articulo> lista = new ArrayList<>();
        
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_ARTICULO_DISPONIBLES(?)}");
            cs.setInt(1, code);
            rs = cs.executeQuery();
            
            while (rs.next()) {
                a = new Articulo();
                a.setCodigoArticulo(rs.getInt(1));
                a.setCodigoCategoria(rs.getInt(2));
                a.setNombreArticulo(rs.getString(3));
                a.setPrecioArticulo(rs.getDouble(4));
                a.setStock(rs.getInt(5));
                a.setDescripcionArticulo(rs.getString(6));
                a.setImagenArticulo(rs.getString(7));
                a.setEstadoCategoria(rs.getBoolean(8));
                lista.add(a);
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
    
    
     public Articulo DetalleArticulo(int code) {
       
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_DETALLE_ARTICULO(?)}");
            cs.setInt(1, code);
            rs = cs.executeQuery();
            
            if (rs.next()) {
                a = new Articulo();
                a.setCodigoArticulo(rs.getInt(1));
                a.setCodigoCategoria(rs.getInt(2));
                a.setNombreArticulo(rs.getString(3));
                a.setPrecioArticulo(rs.getDouble(4));
                a.setStock(rs.getInt(5));
                a.setDescripcionArticulo(rs.getString(6));
                a.setImagenArticulo(rs.getString(7));
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
        return a;
    }
    
     public ArrayList<Articulo> ListadoArticulos() {
        ArrayList<Articulo> lista = new ArrayList<>();
        
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_ARTICULO()}");
            rs = cs.executeQuery();
            
            while (rs.next()) {
                a = new Articulo();
                a.setCodigoArticulo(rs.getInt(1));
                a.setCodigoCategoria(rs.getInt(2));
                a.setNombreArticulo(rs.getString(3));
                a.setPrecioArticulo(rs.getDouble(4));
                a.setStock(rs.getInt(5));
                a.setDescripcionArticulo(rs.getString(6));
                a.setImagenArticulo(rs.getString(7));
                lista.add(a);
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
