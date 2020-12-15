package recurso;

public class Funciones {

    public static String Palabra(String palabra) {
        String cadena = "";

        if (palabra.length() <= 38) {
            cadena = palabra;
        } else {
            for (int i = 0; i < 38; i++) {
                cadena += palabra.charAt(i);
            }
            cadena += "...";
        }

        return cadena;
    }
}
