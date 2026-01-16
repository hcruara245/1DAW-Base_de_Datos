CREATE DATABASE tienda2;

USE tienda2;
-- Creo la base de datos y la uso, le he puesto el nombre "tienda2"

-- Tablas UNO: "_1"

-- Creo la tabla compradores
CREATE TABLE compradores_1 (
	CIF_comprador VARCHAR(11),
	nombre_social VARCHAR(30),
	domicilio_socialo VARCHAR(30),
	localidad VARCHAR(30),
	C_postal VARCHAR(5),
	telefono INT(9)
);

-- Creo la tabla articulos
CREATE TABLE articulos_1 (
	referencia_articulo VARCHAR(12),
	descripcion_articulo VARCHAR(30),
	precio_unidad FLOAT(6,2),
	IVA INT(2),
	existencias_actuales INT(5),
		CONSTRAINT UQ_articulos_descripcion_1 UNIQUE (descripcion_articulo)
);

-- Creo la tabla facturas
CREATE TABLE facturas_1 (
	factura_no INT(6),
	fecha_factura DATE,
	CIF_cliente VARCHAR(11),
		CONSTRAINT PK_factura_no_1 PRIMARY KEY (factura_no)
);

-- Creo la tabla lineas_factura
CREATE TABLE lineas_factura_1 (
	factura_no INT(6),
	referencia_articulo VARCHAR(12),
	unidades INT(3),
		CONSTRAINT FK_lineas_factura_1 FOREIGN KEY (factura_no)
		REFERENCES facturas_1(factura_no)
);

-- Tablas DOS: "_2"

-- Creo la tabla compradores
CREATE TABLE compradores_2(
	CIF_comprador VARCHAR(11),
	nombre_social VARCHAR(30),
	domicilio_socialo VARCHAR(30),
	localidad VARCHAR(30),
	C_postal VARCHAR(5),
	telefono VARCHAR(9) NOT NULL,
		CONSTRAINT PK_compradores_2 PRIMARY KEY (CIF_comprador)
);

-- Creo la tabla articulos
CREATE TABLE articulos_2 (
	referencia_articulo VARCHAR(12),
	descripcion_articulo VARCHAR(30),
	precio_unidad FLOAT(6,2),
	IVA INT(2),
	existencias_actuales INT(5) DEFAULT 0,
		CONSTRAINT PK_articulos_2 PRIMARY KEY (referencia_articulo),
		CHECK (IVA BETWEEN 5 AND 25)
);

-- Creo la tabla facturas
CREATE TABLE facturas_2 (
	factura_no INT(6),
	fecha_factura DATE,
	CIF_cliente VARCHAR(11),
		CONSTRAINT PK_facturas_2 PRIMARY KEY (factura_no),
		CONSTRAINT FK_facturas_2_compradores_2  FOREIGN KEY (CIF_cliente)
		REFERENCES  compradores_2(CIF_comprador)
);

-- Tablas TRES: "_3"

-- Creo la tabla compradores
CREATE TABLE compradores_3(
	CIF_comprador VARCHAR(11),
	nombre_social VARCHAR(30),
	domicilio_socialo VARCHAR(30),
	localidad VARCHAR(30),
	C_postal VARCHAR(5),
	telefono VARCHAR(9) NOT NULL,
		CONSTRAINT PK_compradores_3 PRIMARY KEY (CIF_comprador),
		CONSTRAINT UQ_compradores_nombre_social UNIQUE (nombre_social)
);

-- Creo la tabla facturas
CREATE TABLE facturas_3 (
	factura_no INT(6),
	fecha_factura DATE,
	CIF_cliente VARCHAR(11),
		CONSTRAINT PK_facturas_3 PRIMARY KEY (factura_no),
		CONSTRAINT FK_facturas_3_compradores_3  FOREIGN KEY (CIF_cliente)
		REFERENCES  compradores_3(CIF_comprador)
);