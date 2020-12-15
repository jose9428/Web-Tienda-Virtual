package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    static String Driver = "com.mysql.jdbc.Driver";
    static String url = "jdbc:mysql://localhost/tiendaVirtual";
    static String user = "root";
    static String password = "";

    public static Connection getConexion() {
        Connection con = null;
        try {

            Class.forName(Driver);
            con = DriverManager.getConnection(url, user, password);
      System.out.println("Conexion Exitosa.!!");
        } catch (ClassNotFoundException ex) {
            System.out.println("No hay Driver!!");
        } catch (SQLException ex) {
            System.out.println("Error con la BD");
        }
        return con;
    }
}
