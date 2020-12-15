drop database if exists tiendaVirtual;

create database tiendaVirtual;

use tiendaVirtual;


CREATE TABLE CATEGORIA (
  IDCATEGORIA INT AUTO_INCREMENT ,
  DESCRIPCION VARCHAR(120) NOT NULL  ,
  IMAGEN VARCHAR(150) ,
  ESTADO_CAT BOOLEAN , 
  PRIMARY KEY (IDCATEGORIA)
);  


CREATE TABLE ARTICULO(
IDARTICULO  INT AUTO_INCREMENT ,
IDCATEGORIA INT NOT NULL , 
NOMEARTICULO VARCHAR(120) NOT NULL  ,
PRECIOUNIDAD NUMERIC(8,3) NOT NULL,
STOCK INTEGER NOT NULL,
DESCRIPCION VARCHAR(1500),
IMAGEN VARCHAR(150) NOT NULL,
ESTADO_ART BOOLEAN ,
PRIMARY KEY (IDARTICULO),
FOREIGN KEY(IDCATEGORIA)REFERENCES CATEGORIA(IDCATEGORIA)
);


CREATE TABLE TIPO_USUARIO(
ID_TIPO INT AUTO_INCREMENT ,
NOMBRE VARCHAR(60) NOT NULL,
PRIMARY KEY (ID_TIPO)
);


CREATE TABLE USUARIO(
ID_USUARIO INT AUTO_INCREMENT ,
ID_TIPO INT NOT NULL,
DNI CHAR(8) NOT NULL,
NOMBRES VARCHAR(60) NOT NULL,
APE_PATERNO VARCHAR(60) NOT NULL,
APE_MATERNO VARCHAR(60) NOT NULL,
DIRECCION VARCHAR(70) NOT NULL,
TELEFONO CHAR(9) NOT NULL,
FECHA_NAC DATE NOT NULL,
EMAIL VARCHAR(50) UNIQUE NOT NULL,
USUARIO VARCHAR(60) UNIQUE NOT NULL,
CONTRASEÑA VARCHAR(60) NOT NULL,
PRIMARY KEY (ID_USUARIO),
FOREIGN KEY(ID_TIPO)REFERENCES TIPO_USUARIO(ID_TIPO)
);

CREATE TABLE FACTURA(
NRO_FACTURA CHAR(8) NOT NULL , 
ID_USUARIO INT NOT NULL,
FECHA DATE NOT NULL,
MONTO_TOTAL DECIMAL(9,2) NOT NULL,
ESTADO BOOLEAN ,
PRIMARY KEY (NRO_FACTURA),
FOREIGN KEY(ID_USUARIO)REFERENCES USUARIO(ID_USUARIO)
);

CREATE TABLE DETALLE_FACTURA(
NRO_FACTURA CHAR(8) NOT NULL,
IDARTICULO INT NOT NULL,
PRECIO_UNIDAD DECIMAL(8,2) NOT NULL,
CANTIDAD INTEGER NOT NULL ,
PRIMARY KEY(NRO_FACTURA , IDARTICULO),
FOREIGN KEY(NRO_FACTURA)REFERENCES FACTURA(NRO_FACTURA),
FOREIGN KEY(IDARTICULO)REFERENCES ARTICULO(IDARTICULO)
);


INSERT INTO TIPO_USUARIO VALUES(NULL , 'ADMINISTRADOR');
INSERT INTO TIPO_USUARIO VALUES(NULL , 'CLIENTE');


INSERT INTO USUARIO VALUES(NULL , 2 ,'10233462','Lucas' , 'Quispe' , 'Sanchez','Chorrillos 123' , '987456121' , '1996-12-12','lucas1223@gmail.com' ,  'Lucas12-23','123456' );
INSERT INTO USUARIO VALUES(NULL , 1 ,'10543477','Francisco' , 'Salazar' , 'Gomez','San Juan 123' , '999124364' , '1996-12-12','fgomes15@gmail.com' ,  'admin','123456' );

INSERT INTO USUARIO VALUES(NULL , 2 ,'00124355','Alberto' , 'Caceres' , 'Sanchez','San Genaro 124' , '989134341' , '1991-10-04','albert_874@gmail.com' ,  'albert12-45','123456' );
INSERT INTO USUARIO VALUES(NULL , 2 ,'10331255','Mauricio' , 'Fernandez' , 'Leon','Calle las Camelias 174, San Isidro 15046' , '7151146' , '1992-04-12','mauricio_34@gmail.com' ,  'maurcio34','123456' );
INSERT INTO USUARIO VALUES(NULL , 2 ,'10664522','Maria' , 'Calderon' , 'Aguilar','Calle Augusto Tamayo 180 San Isidro' , '999124357' , '1993-01-24','mariaCalderon_01@gmail.com' ,  'maria01','123456' );

INSERT INTO categoria VALUES(NULL, 'Tecnologia ', 'Cat191111215528Tecnologia.jpg' , true);
INSERT INTO categoria VALUES(NULL, 'Deporte', 'Cat191111222728Deporte.jpg' , true);
INSERT INTO categoria VALUES(NULL, 'Moda Hombre', 'Cat191111225746ModaHombre.jpg' , true);

INSERT INTO articulo VALUES(NULL, 1, 'Televisor LED 50 50U6295', 899.00, 230, 'Disfruta de tus series favoritas, películas o novelas con este LED de la marca AOC. Son 50 pulgadas de resolución 4K Ultra HD que te harán sentir como si estuvieras en la escena que visualizas en tu televisor. AOC es tecnologia que supera tus expectativas!', 'Art19111121592917010218_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Televisor 58 4K UHD SMART TV', 1299.00, 120, 'Experimenta una nueva manera de mirar televisión con la exclusiva LED 58PUD6513. Siéntete como si fueras parte de las escenas de tus series o películas favoritas con una resolución 4K Ultra HD y un desarrollado sistema de sonido de 20W. Finos acabados han sido diseñados para incorporados a un elegante presentación. Navega en las principales aplicaciones y disfruta de largas horas de entretenimiento con los que mas quieres.', 'Art19111122021016512404_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Televisor 55 4K Ultra HD Smar', 1999.00, 340, 'Tecnologia en tus manos con Sony! Los televisores LED 4K Ultra HD ofrecen una experiencia de visualización Única que te envolverá¡ en imágenes increíblemente nitidas. Sincroniza lo mejor del streaming con un potente sistema de sonido para sumergirte en tus mejores películas, revivir multitudinarios conciertos y repasar las mejores jugadas de tu equipo. Deja que tus imágenes tomen mayor protagonismo con la marca lider en tecnologia.', 'Art19111122040316998563_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Televisor 65 4K Ultra HD Smart TV Android XBR-65X805G LA8', 2999.00, 320, 'Disfruta de colores vivos y detalles realistas en este televisor 4K HDR con tecnología de conversión de señales 4K X-Reality PRO, la pantalla TRILUMINOS y Android TV 4K: 3840 x 2160 pixeles.', 'Art19111122075216804396_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Televisor 55 4K UHD SMART TV KD-55X725F LA8', 1999.00, 321, 'Con 4K X-Reality Pro, cada imagen se convierte a una calidad mas cercana a 4K real, para disfrutar de una claridad sorprendente. Las imágenes se hacen mas nítidas y se perfeccionan en tiempo real, para revelar detalles adicionales en los libros y la arquitectura de la biblioteca.', 'Art19111122092116250432_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Laptop Gamer Ci7 8750H 15.6 8GB+16GB Optane 1TB + 4GB Video Nvidia Ge', 3314.00, 67, 'Las Laptops Gamers poseen una capacidad de almacenamiento superior a una laptop convencional, cuyo procesador de alta potencia facilita que todos tus Juegos corran al máximo. Disfruta ademas de una calidad de imagen mas clara con su poderosa tarjeta de video.', 'Art191111221707881605906_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Camara T6 con Lente 18-55mm + Lente EF75-300mm III + Memoria + Maletin', 1399.00, 543, 'La cámara EOS Rebel T6 se maneja muy fácil y los amantes de la fotografía podrán capturar las mejores fotos y videos, gracias a su alta resolución de 18 MP, tendras imagenes con excelentes acabados. Ademas, en este combo, a la tecnologia que te ofrece Canon le suma un lente de 75-300mm, un maletín de transporte y una tarjeta SD de 16 GB compatible con el dispositivo.', 'Art19111122190214998463_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Audifonos AirPods MMEF2BE/A In-Ear Blanco', 529.00, 256, 'Ahora no querrás desprenderte de tu musica, ello gracias a estos increíble audifonos AirPods que Apple tiene para ti. Con un diseño anatomico que se amolda a tu oreja, estos audifonos podras conectarlos a cualquier dispositivo Apple. Asimismo, gracias a su tecnologia inalambrica te olvidaras de cables enredados. Pero ello no es todo, su potente bateria te permitira cargas rapidas de 15 minutos y una duracion de reproduccion de hasta 5 horas. No dejes pasar esta increible oportunidad!', 'Art19111122214216964904_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Audifonos HeadPhone SMS 10 Solid2 MID C/Micro Rosado', 69.00, 234, 'Los auriculares SMS-10 solid 2 de Maxell cautivan al oyente con su sonido profundo y reproducción realista. Con un diseño moderno y elegante con micrófono incorporado, habla por teléfono o en la PC y disfruta de unos auriculares livianos que brindan un confort excepcional con una diadema de cuero sintético.', 'Art19111122243316527523_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 1, 'Minicomponente TMAX40 1200W', 799.00, 540, 'La marca líder en tecnología ha desarrollado un exclusivo equipo de sonido que te envolverá¡ de principio a fin. Sincroniza un audio potente y conmovedor con el ultimo lanzamiento de Panasonic. Convierte cualquier Área de tu habitación en una verdadera sala de cine o disfruta la verdadera calidad de sonido de los últimos lanzamientos musicales con Panasonic ¡No esperes mas y adquiere esta sensacional presentación que Saga Falabella tiene para ti!', 'Art19111122255116933967_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 2, 'Polera Deportiva', 239.00, 450, 'La evolución de una leyenda. Hemos rediseñado nuestro icónico polar Denali para ahora confeccionarlo con tela de polar reciclado para seguir ofreciendo un gran poder de abrigo, comodidad y duración. La coleccion Denali esta¡ inspirada en en la chaqueta Denali original de 1988 que usaron Todd Skinner y Paul Piana durante su primera ascensión al Salath Wall. Polar abrigador confeccionado con tela reciclada. Calce relajado. Tela de refuerzo resistente al desgaste en los hombros, pecho y antebrazos. Dos bolsillos en el pecho. Tela elástica en los puntos. Bolsillos con cierre en el Área de la cintura. Bolsillo compatible con dispositivos electrónicos. Integración con otras prendas de The North Face gracias a su cierre compatible. Pretina ajustable con tirante elastico. Contiene al menos un 50% de contenido reciclado por peso.', 'Art19111122302716910275_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 2, 'Casaca Trail Running', 439.00, 560, 'Tecnología del material: Motion fit, pluma allied, advanced skin warm, advanced skin shield, upf 50, cierre inteligente, cierres compatibles con mochila, 4-way stretch.', 'Art19111122341416981811_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 2, 'Polera Deportiva Marmot', 231.200, 430, 'Información adicional: Cálido y acogedor polar de hombre con polar 100, con costuras planas muy durables y dos bolsillos para las manos con cierres. la protección ideal para el dia a dia o para una corta caminata en el cerro. polar 100 wt. cierre completo. bolsillos con cierre para manos. costuras planas.', 'Art19111122361416847831_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 2, 'Zapatillas de Futbol Niños', 104.30, 210, 'Al momento de recibir tu producto, ten en cuenta que la talla de la caja puede ser diferente a la que seleccionaste. Te recomendamos probarte primero las Zapatillas que compres antes de solicitar un cambio.', 'Art19111122402116275774_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 2, 'Camiseta de Arbitro 2.0 Naranja', 45.50, 76, 'La camiseta oficial del arbitro de Peak se caracteriza por su alta funcionalidad y un cómodo desgaste. El material transpirable garantiza una sensación de sequedad constante. Corte y tejido mejorados. El logo de la Federación Alemana de Baloncesto esta cosido en la manga izquierda y los logotipos PEAK se pueden ver discretamente en el pecho y el cuello.', 'Art19111122422316215082_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 2, 'Mitones Cloud 700 Talla L/XL Negro', 224.10, 210, 'Dakine nos trae lo ultimo de su colección para ciclistas, incluyendo su gran gama de accesorios para bikers, hechas en resistentes materiales que harán mucho mas comoda la practica de tu deporte favorito.', 'Art19111122490816200377_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 2, 'Ciclocomputador Digi 5IVE Negro', 116.10, 234, 'La marca PRO lleva años desarrollando accesorios para el deportista y en la mayoría de casos, desarrollando estos nuevos artículos con la colaboración de deportistas de Élite mundial y nacional, quienes les ayudan a mejorar con su experiencia. Uno de los máximos objetivos de PRO con sus accesorios es lograr el mejor rendimiento con el menor peso. Ciclocomputador inalámbrico con 5 funciones, funcionamiento lógico y cómodo, de montaje sencillo, rápido y efectivo. Cuenta con soporte multiposición (se ajusta en la barra y la tija) y es resistente al agua.', 'Art19111122550416200265_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 3, 'Camiseta Clover', 18.30, 540, 'Clover trae esta temporada la línea de Camisetas para que puedas sentir la satisfacción y confort en cada momento. No esperes mas! Ahora tendrás calidad y comodidad en una sola prenda. Siente el cambio.', 'Art19111123003115668371_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 3, 'Bibiri Clover', 24.50, 210, 'Clover trae esta temporada la linea de BVD para que puedas sentir la satisfacción y confort en cada momento. No esperes mas! Ahora tendrás calidad y comodidad en una sola prenda. Siente el cambio.', 'Art19111123041615669923_1.jpg' , true);
INSERT INTO articulo VALUES(NULL, 3, 'Polo CHRISTIAN LACROIX', 39.90, 210, 'Christian Lacroix te ofrece su nueva linea de polos fabricados cuidando cada detalle para brindarte comodidad en el uso. Resalta tu propio estilo con este lindo polo manga corta hecho a tu medida!', 'Art19111123053714499295_1.jpg' , true);


insert into factura values('00000001' , 1 , '2020-01-03' , 6896.00 , true);
insert into detalle_factura values('00000001' , 1 , 899.00 , 1 );
insert into detalle_factura values('00000001' , 3 , 1999.00 , 2);
insert into detalle_factura values('00000001' , 5 , 1999.00 , 1);

insert into factura values('00000002' , 1 , '2020-02-12' , 4998 , true);
insert into detalle_factura values('00000002' , 3 , 1999.00 , 1);
insert into detalle_factura values('00000002' , 4 , 2999.00 , 1);

insert into factura values('00000003' , 3 , '2020-01-06' , 4613.00 , true);
insert into factura values('00000004' , 3 , '2020-01-10' , 4921.50 , true);
insert into factura values('00000005' , 4 , '2020-01-10' , 1638.00 , true);
insert into factura values('00000006' , 4 , '2020-01-10' , 276.70 , true);

insert into detalle_factura values('00000003' , 2 , 1299.00 , 1);
insert into detalle_factura values('00000003' , 6 , 3314.00 , 1);

insert into detalle_factura values('00000004' , 1 , 899.00 , 1);
insert into detalle_factura values('00000004' , 5 , 1999.00 , 2);
insert into detalle_factura values('00000004' , 19 , 24.50 , 1);

insert into detalle_factura values('00000005' , 7 , 1399.00 , 1);
insert into detalle_factura values('00000005' , 11 , 239.00 , 1);

insert into detalle_factura values('00000006' , 13 , 231.20 , 1);
insert into detalle_factura values('00000006' , 15 , 45.50 , 1);

select * from usuario;
select * from detalle_factura;