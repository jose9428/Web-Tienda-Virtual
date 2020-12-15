
use tiendaVirtual;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_AGREGAR_ARTICULO @@
CREATE PROCEDURE SP_AGREGAR_ARTICULO (_CODE_CATEGORIA INT,_NOME VARCHAR(100), 
_PRECIO NUMERIC(8,2), _STOCK INTEGER, _DESCRIPCION VARCHAR(1500), _IMAGEN VARCHAR(100)) 
 BEGIN
   IF NOT EXISTS (SELECT * FROM ARTICULO WHERE NOMEARTICULO = _NOME)THEN
      INSERT INTO ARTICULO VALUES(NULL ,_CODE_CATEGORIA , _NOME , _PRECIO  , _STOCK ,_DESCRIPCION, _IMAGEN,true );
   END IF;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_AGREGAR_CATEGORIA @@
CREATE PROCEDURE SP_AGREGAR_CATEGORIA (`_NOME` VARCHAR(60), `_IMAGEN` VARCHAR(100))  BEGIN
   IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE DESCRIPCION = _NOME)THEN
      INSERT INTO CATEGORIA VALUES(NULL , _NOME , _IMAGEN,true);
   END IF;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_DETALLE_ARTICULO @@
CREATE PROCEDURE SP_DETALLE_ARTICULO(`_CODE` INTEGER)  
BEGIN
   SELECT * FROM ARTICULO
   WHERE IDARTICULO = _CODE;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_ELIMINAR_ARTICULO @@
CREATE PROCEDURE SP_ELIMINAR_ARTICULO (`_CODE` INTEGER) 
 BEGIN
   DELETE FROM ARTICULO WHERE IDARTICULO  = _CODE;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_ARTICULO @@
CREATE PROCEDURE SP_LISTA_ARTICULO ()  BEGIN
   SELECT * FROM ARTICULO WHERE ESTADO_ART = true;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_ARTICULO_DISPONIBLES @@
CREATE PROCEDURE SP_LISTA_ARTICULO_DISPONIBLES (`_CODE` INTEGER)  
BEGIN
   SELECT * FROM ARTICULO
   WHERE IDCATEGORIA = _CODE and ESTADO_ART = true;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_ARTICULO_DISPONIBLE @@
CREATE PROCEDURE SP_LISTA_ARTICULO_DISPONIBLE (`_CODE` INTEGER)  
BEGIN
   SELECT * FROM ARTICULO
   WHERE IDCATEGORIA = _CODE;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_CATEGORIA @@
CREATE PROCEDURE SP_LISTA_CATEGORIA ()  
BEGIN
   SELECT * FROM CATEGORIA WHERE ESTADO_CAT = true;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_AGREGAR_CLIENTE @@
CREATE PROCEDURE SP_AGREGAR_CLIENTE 
( 
OUT _CADENA  VARCHAR(120), 
`_USUARIO` VARCHAR(30),
 `_PASS` VARCHAR(30), 
`_DNI` CHAR(8), 
`_NOMBRES` VARCHAR(40),
 `_APEP` VARCHAR(40),
 `_APEM` VARCHAR(40), 
`_DIRECCION` VARCHAR(60),
 `_TELEFONO` CHAR(9), 
`_FECHA_NAC` DATE, 
`_EMAIL` VARCHAR(40)
) 
 BEGIN
   DECLARE CODE_USER INT;   
IF  EXISTS(SELECT * FROM USUARIO WHERE USUARIO = _USUARIO )THEN   
     SET _CADENA = CONCAT('El usuario ' , _USUARIO , ' ya se encuentra registrado en el sistema.Pruebe con otro usuario.');
ELSE   IF  EXISTS(SELECT * FROM USUARIO WHERE DNI = _DNI )THEN   
       SET _CADENA = CONCAT('El nro° DNI ' , _DNI , ' ya se encuentra registrado en el sistema.');
     ELSE

      INSERT INTO USUARIO VALUES(NULL ,2 , _DNI ,_NOMBRES , _APEP, _APEM , 
         _DIRECCION, _TELEFONO,_FECHA_NAC,_EMAIL , _USUARIO , _PASS);
     SET _CADENA = 'OK';
    END IF;
  END IF;
END @@
DELIMITER ;



DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LIST_PEDIDOS @@
CREATE PROCEDURE SP_LIST_PEDIDOS(_CODE INTEGER)  
BEGIN
   declare _idCliente integer;
   select ID_USUARIO into _idCliente from usuario where ID_USUARIO = _CODE;
   SELECT * FROM FACTURA 
   WHERE ID_USUARIO = _idCliente
    ORDER BY FECHA ASC;
END @@
DELIMITER ;
   

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_GENERAR_FACTURA @@
CREATE PROCEDURE SP_GENERAR_FACTURA(
OUT NRO CHAR(8) , 
_idUsuario int , 
_total decimal(8,2) 
)  
BEGIN
   declare cuenta integer ;
   declare _idCliente integer;
  
   select ID_USUARIO into _idCliente from usuario where ID_USUARIO = _idUsuario;
  
   select ifnull(max(NRO_FACTURA) , 0) + 1 into cuenta
   from FACTURA;
   set NRO = lpad(cuenta , 8 , '0' );
   insert into factura values(NRO , _idCliente , now() , _total , false);
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_GENERAR_DETALLE_FACTURA @@
CREATE PROCEDURE SP_GENERAR_DETALLE_FACTURA(
_NRO_FACT CHAR(8) , 
_IDARTICULO int , 
_PRECIO_UNIDAD decimal(8,2)  ,
_CANTIDAD int
)  
BEGIN
   insert into DETALLE_FACTURA values(_NRO_FACT , _IDARTICULO , _PRECIO_UNIDAD , _CANTIDAD);
   update ARTICULO set STOCK = STOCK - _CANTIDAD where IDARTICULO = _IDARTICULO;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_DETALLE_FACTURA @@
CREATE PROCEDURE SP_LISTA_DETALLE_FACTURA
(
_NRO_FACT CHAR(8) 
)  
BEGIN
   select NOMEARTICULO,IMAGEN , precio_unidad , cantidad
   from DETALLE_FACTURA d inner join ARTICULO a
   on a.IDARTICULO = d.IDARTICULO
   where nro_factura = _NRO_FACT;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_NOMBRE_CATEGORIA @@
CREATE PROCEDURE SP_NOMBRE_CATEGORIA
(
_CODE int 
)  
BEGIN
   select c.DESCRIPCION
   from CATEGORIA c inner join articulo a
   on a.`IDCATEGORIA` = c.`IDCATEGORIA`
   where a.`IDARTICULO` = _CODE;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_CANCELAR_PEDIDO @@
CREATE PROCEDURE SP_CANCELAR_PEDIDO(_NRO CHAR(8))
BEGIN
  DECLARE done INT DEFAULT FALSE;

  DECLARE cant INT;
  DECLARE code INT;

  DECLARE cur1 CURSOR FOR 
   SELECT IDARTICULO , CANTIDAD
   FROM DETALLE_FACTURA
   WHERE NRO_FACTURA = _NRO;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

    read_loop: LOOP
    FETCH cur1 INTO code, cant;
    IF done THEN
      LEAVE read_loop;
    END IF;
    update ARTICULO set STOCK = STOCK + cant
    where IDARTICULO = code;
  END LOOP;
  CLOSE cur1;
  DELETE FROM DETALLE_FACTURA WHERE NRO_FACTURA = _NRO;
  DELETE FROM FACTURA WHERE NRO_FACTURA = _NRO;

END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_IMAGEN_CATEGORIA @@
CREATE PROCEDURE SP_IMAGEN_CATEGORIA
(
_CODE int 
)  
BEGIN
   select c.`IMAGEN`
   from CATEGORIA c inner join articulo a
   on a.`IDCATEGORIA` = c.`IDCATEGORIA`
   where a.`IDARTICULO` = _CODE;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LOGEAR_USUARIO @@
CREATE PROCEDURE SP_LOGEAR_USUARIO(_USUARIO VARCHAR(59) , _PASS VARCHAR(50) )
BEGIN

   select t.NOMBRE  , u.ID_USUARIO , NOMBRES , APE_PATERNO , APE_MATERNO , DIRECCION
   from TIPO_USUARIO t inner join USUARIO u
   on t.ID_TIPO = u.ID_TIPO
   where USUARIO =_USUARIO and CONTRASEÑA = _PASS;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_ELIMINAR_CATEGORIA @@
CREATE PROCEDURE SP_ELIMINAR_CATEGORIA (_CODE int)  
BEGIN
   DELETE FROM ARTICULO WHERE IDCATEGORIA = _CODE;
   DELETE FROM CATEGORIA WHERE IDCATEGORIA = _CODE;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_CANTIDAD_CLIENTES @@
CREATE PROCEDURE SP_CANTIDAD_CLIENTES ()  
BEGIN
   select count(*) from usuario where ID_TIPO = 2;
END @@
DELIMITER ;

delimiter @@
drop function if exists sp_nombre_mes @@
create function sp_nombre_mes(mes int)
returns varchar(56)
begin
 declare nome varchar(100);
 select  (CASE mes    
 WHEN 1 THEN 'Enero' WHEN 2 THEN 'Febrero'
 WHEN 3 THEN 'Marzo' WHEN 4 THEN 'Abril'
 WHEN 5 THEN 'Mayo'  WHEN 6 THEN 'Junio'
 WHEN 7 THEN 'Julio' WHEN 8 THEN 'Agosto'
 WHEN 9 THEN 'Septiembre' WHEN 10 THEN 'Octubre'
 WHEN 11 THEN 'Noviembre' WHEN 12 THEN 'Diciembre' end ) into nome ;
   return nome;
end @@
delimiter ;


delimiter @@
drop procedure if exists sp_listado_ventas_resumen @@
create procedure sp_listado_ventas_resumen()
begin
  select month(fecha) , year(fecha) , sp_nombre_mes(month(fecha)), SUM(monto_total) 
  from factura
  where year(fecha)  = year(current_date()) 
  group by month(fecha) , year(fecha) , sp_nombre_mes(month(fecha))
  order by 1 asc;
end @@
delimiter ;


delimiter @@
drop procedure if exists SP_CANTIDAD_PEDIDOS_PENDIENTES @@
create procedure SP_CANTIDAD_PEDIDOS_PENDIENTES()
begin
 select count(*)
 from factura
 where estado = 0;
end @@
delimiter ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_CATEGORIA_TODOS @@
CREATE PROCEDURE SP_LISTA_CATEGORIA_TODOS ()  
BEGIN
   SELECT * FROM CATEGORIA ;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_ACTUALIZAR_ESTADO_CATEGORIA @@
CREATE PROCEDURE SP_ACTUALIZAR_ESTADO_CATEGORIA (_codigo int ,_estado boolean)  
BEGIN
  update CATEGORIA set ESTADO_CAT = _estado
  where IDCATEGORIA = _codigo;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_ACTUALIZAR_ESTADO_ARTICULO @@
CREATE PROCEDURE SP_ACTUALIZAR_ESTADO_ARTICULO (_codigo int ,_estado boolean)  
BEGIN
  update ARTICULO set ESTADO_ART = _estado
  where IDARTICULO = _codigo;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_ACTUALIZAR_ARTICULO @@
CREATE PROCEDURE SP_ACTUALIZAR_ARTICULO (_CODE_CATEGORIA INT,_NOME VARCHAR(100), 
_PRECIO NUMERIC(8,2), _STOCK INTEGER, _DESCRIPCION VARCHAR(1500), _IMAGEN VARCHAR(100) , _ID_ARTICULO int) 
 BEGIN
   IF NOT EXISTS (SELECT * FROM ARTICULO WHERE NOMEARTICULO = _NOME AND IDARTICULO !=_ID_ARTICULO)THEN
     IF _IMAGEN = '' THEN
        update articulo set IDCATEGORIA = _CODE_CATEGORIA , NOMEARTICULO = _NOME ,PRECIOUNIDAD = _PRECIO ,
        STOCK = _STOCK , DESCRIPCION = _DESCRIPCION 
        where IDARTICULO = _ID_ARTICULO;
	else
       update articulo set IDCATEGORIA = _CODE_CATEGORIA , NOMEARTICULO = _NOME ,PRECIOUNIDAD = _PRECIO ,
        STOCK = _STOCK , DESCRIPCION = _DESCRIPCION , IMAGEN = _IMAGEN
        where IDARTICULO = _ID_ARTICULO;
     END IF;
   END IF;
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_ACTUALIZAR_CATEGORIA @@
CREATE PROCEDURE SP_ACTUALIZAR_CATEGORIA (`_NOME` VARCHAR(60), `_IMAGEN` VARCHAR(100),_CODE INT)  BEGIN
   IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE DESCRIPCION = _NOME AND IDCATEGORIA != _CODE)THEN
      IF (LENGTH(_IMAGEN) = 0)THEN
         UPDATE CATEGORIA SET DESCRIPCION = _NOME
         WHERE IDCATEGORIA = _CODE;
	  ELSE
	    UPDATE CATEGORIA SET DESCRIPCION = _NOME , IMAGEN = _IMAGEN
        WHERE IDCATEGORIA = _CODE;
      END IF;
   END IF;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_PEDIDOS_CLIENTES @@
CREATE PROCEDURE SP_LISTA_PEDIDOS_CLIENTES ()  
BEGIN
  select nro_factura , date_format(fecha , '%d-%m-%Y'), nombres , 
  ape_paterno ,ape_materno , monto_total , estado
  from factura f inner join usuario u using(id_usuario);
END @@
DELIMITER ;


DELIMITER @@
DROP PROCEDURE IF EXISTS SP_NOMBRE_CATE @@
CREATE PROCEDURE SP_NOMBRE_CATE
(
_CODE int 
)  
BEGIN
   select DESCRIPCION
   from CATEGORIA 
   where IDCATEGORIA = _CODE;
END @@
DELIMITER ;

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_LISTA_CLIENTES @@
CREATE PROCEDURE SP_LISTA_CLIENTES () 
 BEGIN
  select * from usuario
  where id_tipo = 2;
END @@
DELIMITER ;