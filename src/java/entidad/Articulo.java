package entidad;

public class Articulo extends Categoria {

    private int codigoArticulo;
    private String nombreArticulo;
    private double precioArticulo;
    private int stock;
    private String descripcionArticulo;
    private String imagenArticulo;

    public int getCodigoArticulo() {
        return codigoArticulo;
    }

    public void setCodigoArticulo(int codigoArticulo) {
        this.codigoArticulo = codigoArticulo;
    }

    public String getNombreArticulo() {
        return nombreArticulo;
    }

    public void setNombreArticulo(String nombreArticulo) {
        this.nombreArticulo = nombreArticulo;
    }

    public double getPrecioArticulo() {
        return precioArticulo;
    }

    public void setPrecioArticulo(double precioArticulo) {
        this.precioArticulo = precioArticulo;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDescripcionArticulo() {
        return descripcionArticulo;
    }

    public void setDescripcionArticulo(String descripcionArticulo) {
        this.descripcionArticulo = descripcionArticulo;
    }

    public String getImagenArticulo() {
        return imagenArticulo;
    }

    public void setImagenArticulo(String imagenArticulo) {
        this.imagenArticulo = imagenArticulo;
    }

}
