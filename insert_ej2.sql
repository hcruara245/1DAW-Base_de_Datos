USE tienda;

INSERT INTO compradores(CIF_comprador,nombre_social,domicilio_social,localidad,codigo_postal,telefono)
	VALUES ('111111-L','TELARES ASUNCION','C. LA RUA 5','ALBACETE','02002','97223141');
	
INSERT INTO compradores(CIF_comprador,nombre_social,domicilio_social,localidad,codigo_postal,telefono)
	VALUES ('222222-J','TEXTIL LAGO','PLAZA MAYOR 2','ALMERIA','04131','95434567');
	
INSERT INTO articulos(referencia_articulo,descripcion_articulo,precio_unidad,IVA,existencias_actuales)
	VALUES ('01-LANA','LANA 100% NATURAL',31.09,10,100);
	
INSERT INTO articulos(referencia_articulo,descripcion_articulo,precio_unidad,IVA,existencias_actuales)
	VALUES ('02-ALGODON','ALGODÓN DE 2 CABOS',18.00,10,155);
	
INSERT INTO articulos(referencia_articulo,descripcion_articulo,precio_unidad,IVA,existencias_actuales)
	VALUES ('03-SEDA','SEDA CHINA',55.50,15,190);
	
INSERT INTO articulos(referencia_articulo,descripcion_articulo,precio_unidad,IVA,existencias_actuales)
	VALUES ('04-LINO','LINO EUROPEO',44.00,12,250);
	
INSERT INTO facturas(factura_no,fecha_factura,CIF_cliente,cod_oficina)
	VALUES (1,'2004-05-12','111111-L',1212);	
	
INSERT INTO facturas(factura_no,fecha_factura,CIF_cliente,cod_oficina)
	VALUES (2,'2004-07-18','111111-L',1231);
	
INSERT INTO facturas(factura_no,fecha_factura,CIF_cliente,cod_oficina)
	VALUES (3,'2004-07-31','222222-J',1406);
	
INSERT INTO facturas(factura_no,fecha_factura,CIF_cliente,cod_oficina)
	VALUES (4,'2004-08-10','222222-J',1231);
	
INSERT INTO lineas_factura(factura_no,referencia_articulo,unidades)
	VALUES (1,'01-LANA',120);

INSERT INTO lineas_factura(factura_no,referencia_articulo,unidades)
	VALUES (1,'04-LINO',75);
	
INSERT INTO lineas_factura(factura_no,referencia_articulo,unidades)
	VALUES (2,'01-LANA',20);

INSERT INTO lineas_factura(factura_no,referencia_articulo,unidades)
	VALUES (2,'02-ALGODÓN',50);
	
INSERT INTO articulos(referencia_articulo,precio_unidad,IVA)
	VALUES ('06-CUERO',10.99,10);
	
INSERT INTO articulos(referencia_articulo,descripcion_articulo,precio_unidad,IVA,existencias_actuales)
	VALUES ('05-YUTE','YUTE FINO',25.99,12,15);
	
DELETE 
	FROM articulos
	WHERE referencia_articulo LIKE '%5%';
	
UPDATE articulos
	SET IVA = 8
	WHERE IVA = 10;
	
UPDATE articulos
	SET precio_unidad = (precio_unidad * 5) / 100;
	
INSERT INTO facturas
	VALUES (5,'2026-01-23','11111-L',1231);
	
INSERT INTO lineas_factura
	VALUES (5,'01-LANA',60);
	
INSERT INTO lineas_factura
	VALUES (5,'04-LINO',25);
	
DELETE ON CASCADE
	FROM factura
	WHERE factura_no = 2;

UPDATE facturas
	SET factura_no = 2
	WHERE factura_no = 5;