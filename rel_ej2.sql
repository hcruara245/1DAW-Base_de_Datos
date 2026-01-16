CREATE DATABASE tienda;

USE tienda;
-- Creo y uso la base de datos tienda

-- Creo la tabla compradores
CREATE TABLE compradores (
	CIF_comprador VARCHAR(11),
	nombre_social VARCHAR(30),
	domicilio_social VARCHAR(30),
	localidad VARCHAR(30),
	codigo_postal VARCHAR(5),
	telefono VARCHAR(9) NOT NULL,
		-- Creo las restricciones
		CONSTRAINT PK_COMPRADORES_CIF PRIMARY KEY (CIF_comprador),
		CONSTRAINT UQ_COMPRADORES_NOMBRE_SOCIAL UNIQUE (nombre_social)
);

-- Creo la tabla articulos
CREATE TABLE articulos (
	referencia_articulo VARCHAR(12),
	descripcion_articulo VARCHAR(30),
	precio_unidad FLOAT(6,2),
	IVA INT(2),
	existencias_actuales INT(5) DEFAULT 0,
		-- Creo las restricciones
		CONSTRAINT PK_articulos PRIMARY KEY (referencia_articulo),
		CHECK (IVA BETWEEN 5 AND 25)
);

-- Creo la tabla facturas
CREATE TABLE facturas (
	factura_no INT(6),
	fecha_factura DATE DEFAULT '2005-01-01' NOT NULL,
	CIF_cliente VARCHAR(11) NOT NULL,
	cod_oficina INT(4) NOT NULL,
		-- Creo las restricciones
		CONSTRAINT PK_facturas PRIMARY KEY (factura_no),
		CONSTRAINT FK_facturas_compradores FOREIGN KEY (CIF_cliente)
		REFERENCES compradores (CIF_comprador),
		CHECK (cod_oficina BETWEEN 1 AND 1000)
);

-- Creo la tabla lineas_factura
CREATE TABLE lineas_factura (
	factura_no INT(6),
	referencia_articulo VARCHAR(12),
	unidades INT(3) NOT NULL,
		-- Creo las restricciones
		CONSTRAINT PK_lineas_factura PRIMARY KEY (factura_no, referencia_articulo),
		CONSTRAINT FK_lineas_factura FOREIGN KEY (factura_no)
		REFERENCES facturas (factura_no) ON DELETE CASCADE,
		CONSTRAINT FK_lineas_articulo FOREIGN KEY (referencia_articulo)
		REFERENCES articulos (referencia_articulo)
);