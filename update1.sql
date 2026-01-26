USE tienda;


UPDATE articulos 
	SET IVA = IVA - 1; 
	
UPDATE articulos
	SET descripcion_articulo = 'LANA 90%NATURAL 10%ACRILICO'
	WHERE referencia_articulo = '01-LANA';

ALTER TABLE lineas_factura
	DROP FOREIGN KEY FK_lineas_factura_articulos;

ALTER TABLE lineas_factura
	ADD CONSTRAINT FK_lineas_factura_articulos
	FOREIGN KEY (referencia_articulo)
	REFERENCES articulos(referencia_articulo)
	ON UPDATE CASCADE;


UPDATE articulos
	SET referencia_articulo = '01-LANA90/10'
	WHERE referencia_articulo = '01-LANA';
	
-- Esto no se puede hacer directamente, para ello se debería de quitar las restricciones de la tabla para que deje de ser clave ajena, modificar el valor --
-- Y después volver a poner la clave ajena --

DELETE FROM facturas
	WHERE factura_no = 2;