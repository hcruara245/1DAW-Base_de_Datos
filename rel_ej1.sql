-- Creo la tabla departamentos
CREATE TABLE departamentos (
	dep_no INT(2),
	dNombre VARCHAR(20),
	localidad VARCHAR(14),
		-- Creo la restricción para la clave primaria
		CONSTRAINT PK_departamentos PRIMARY KEY(dep_no)
);

-- Creo la tabla empleados
CREATE TABLE empleados (
	emp_no INT(4),
	apellido VARCHAR(15),
	oficio VARCHAR (14),
	director INT(4),
	fecha_alta DATE,
	salario FLOAT(6,2),
	comision FLOAT(6,2),
	dep_no INT(2),
	-- Creo dos restricciones para las claves ajenas
	-- Creo otra restricción para la clave primaria
		CONSTRAINT PK_empleados PRIMARY KEY(emp_no),
		CONSTRAINT FK_empleados_departamentos FOREIGN KEY(dep_no) 
		REFERENCES departamentos(dep_no),
		CONSTRAINT FK_empleados_empleados FOREIGN KEY(director) 
		REFERENCES empleados(emp_no)
);

-- Creo la tabla clientes
CREATE TABLE clientes (
	cliente_no INT(3),
	nombre VARCHAR(30),
	localidad VARCHAR(20),
	vendedor_no INT(4),
	debe FLOAT(8,2),
	haber FLOAT(8,2),
	limite_credito FLOAT(10,2),
		-- Creo dos restricciones, una para la clave ajena y la otra para la primaria
		CONSTRAINT PK_clientes PRIMARY KEY(cliente_no),
		CONSTRAINT FK_clientes_empleados FOREIGN KEY(vendedor_no) 
		REFERENCES empleados(emp_no)
);

-- Creo la tabla productos
CREATE TABLE productos (
	producto_no INT(2),
	descripcion VARCHAR(60),
	precio_actual FLOAT(6,2),
	stock_disponible INT(3),
		-- Creo la restriccion para la clave primaria
		CONSTRAINT PK_productos PRIMARY KEY(producto_no)
);

-- Creo la tabla pedidos
CREATE TABLE pedidos (
	pedido_no INT(4),
	producto_no INT(2),
	cliente_no INT(3),
	unidades INT(1),
	fecha_pedido DATE,
		-- Creo las restricciones para las claves primarias y las claves ajenas
		CONSTRAINT PK_pedidos PRIMARY KEY(pedido_no),
		CONSTRAINT FK_pedidos_productos FOREIGN KEY(producto_no) 
		REFERENCES productos(producto_no),
		CONSTRAINT FK_pedidos_clientes FOREIGN KEY(cliente_no) 
		REFERENCES clientes(cliente_no)
);