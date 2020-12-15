
package conexion;

import dao.ClienteDAO;
import dao.UsuarioDAO;
import entidad.Cliente;

public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       Cliente c = new UsuarioDAO().IniciarSesion("admin", "123456");
       if(c == null){
           System.out.println("no existe");
       }
        System.out.println(c.getDireccion());
    }
    
}
