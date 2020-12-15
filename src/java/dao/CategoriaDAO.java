package dao;

import conexion.Conexion;
import entidad.*;
import java.sql.*;
import java.util.*;

public class CategoriaDAO {

    Connection cn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Categoria c = null;

    public int AgregarCategoria(Categoria c) {
        int res = 0;

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_AGREGAR_CATEGORIA(?,?)}");
            cs.setString(1, c.getNombreCategoria());
            cs.setString(2, c.getImagenCategoria());
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

    public int ModificarCategoria(Categoria c) {
        int res = 0;

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_ACTUALIZAR_CATEGORIA(?,?,?)}");
            cs.setString(1, c.getNombreCategoria());
            cs.setString(2, c.getImagenCategoria());
            cs.setInt(3, c.getCodigoCategoria());
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

    public int EliminarCategoria(int categoria) {
        int res = 0;

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_ELIMINAR_CATEGORIA(?)}");
            cs.setInt(1, categoria);
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

    public ArrayList<Categoria> ListadoCategoria() {
        ArrayList<Categoria> lista = new ArrayList<>();

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_CATEGORIA()}");
            rs = cs.executeQuery();

            while (rs.next()) {
                c = new Categoria();
                c.setCodigoCategoria(rs.getInt(1));
                c.setNombreCategoria(rs.getString(2));
                c.setImagenCategoria(rs.getString(3));
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

    public ArrayList<Categoria> ListadoTodasCategoria() {
        ArrayList<Categoria> lista = new ArrayList<>();

        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_LISTA_CATEGORIA_TODOS()}");
            rs = cs.executeQuery();

            while (rs.next()) {
                c = new Categoria();
                c.setCodigoCategoria(rs.getInt(1));
                c.setNombreCategoria(rs.getString(2));
                c.setImagenCategoria(rs.getString(3));
                c.setEstadoCategoria(rs.getBoolean(4));
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

    public String NombreCateg(int code) {
        String nombre = "";
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_NOMBRE_CATE(?)}");
            cs.setInt(1, code);
            rs = cs.executeQuery();

            if (rs.next()) {
                nombre = rs.getString(1);
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
        return nombre;
    }

    public String NombreCategoria(int code) {
        String nombre = "";
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_NOMBRE_CATEGORIA(?)}");
            cs.setInt(1, code);
            rs = cs.executeQuery();

            if (rs.next()) {
                nombre = rs.getString(1);
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
        return nombre;
    }

    public int ActualizarEstadoCategoria(int code, boolean estado) {
        int res = 0;
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_ACTUALIZAR_ESTADO_CATEGORIA(?,?)}");
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

    public String ImagenCategoria(int code) {
        String nombre = "";
        try {
            cn = Conexion.getConexion();
            cs = cn.prepareCall("{call SP_IMAGEN_CATEGORIA(?)}");
            cs.setInt(1, code);
            rs = cs.executeQuery();

            if (rs.next()) {
                nombre = rs.getString(1);
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
        return nombre;
    }
}
