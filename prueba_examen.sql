CREATE DATABASE tienda_electronica;

USE tienda_electronica;

CREATE TABLE clientes(
	id_cliente INT(9) NOT NULL,
	nombre VARCHAR(20),
	ciudad VARCHAR(20),
	edad INT(3),
		CONSTRAINT PK_clientes PRIMARY KEY(id_cliente)
);

CREATE TABLE productos(
	id_producto INT(9) NOT NULL,
	nombre VARCHAR(40),
	categoria VARCHAR(20),
	precio FLOAT(6,2),
		CONSTRAINT PK_productos PRIMARY KEY(id_producto)
);

CREATE TABLE pedidos(
	id_pedido INT(9) NOT NULL,
	id_cliente INT(9) NOT NULL,
	id_producto INT(9) NOT NULL,
	cantidad INT(3),
	fecha DATE,
		CONSTRAINT FK_pedidos_clientes FOREIGN KEY (id_cliente) 
		REFERENCES clientes(id_cliente),
		CONSTRAINT FK_pedidos_productos FOREIGN KEY (id_producto)
		REFERENCES productos(id_producto)
);

INSERT INTO clientes
	VALUES (1,'Paco Diddy','Malaga',67);

INSERT INTO clientes
	VALUES (2,'Jorge Einstein','Tocina',69);

INSERT INTO clientes
	VALUES (3,'Adolfo','Austria',39);
	
INSERT INTO clientes
	VALUES (4,'Fernando Alonso','Asturias',33);

INSERT INTO clientes
	VALUES (5,'Carlos Sainz','Madrid',29);

INSERT INTO productos
	VALUES 
	(1,'Pasta termica de gel de baño','Refrigeración',10.99),
	(2,'Consola portatil - la isla privada','Entretenimiento',89.99),
	(3,'Refrigeracion de gas','Componente',199.99),
	(4,'F1 - 2026 - Fracaso edition','Entretenimiento',99.99),
	(5,'Asus Vivobook Pro 15 OLED','Portatil',1299.99);
	
INSERT INTO pedidos
	VALUES
	(1,1,1,3,'2001-9-11'),
	(2,1,4,1,'2004-3-11'),
	(3,2,2,1,'2018-1-5'),
	(4,2,5,1,'2013-5-5'),
	(5,3,3,3,'1939-7-4'),
	(6,4,4,1,'2026-2-18'),
	(7,4,5,2,'2021-12-20'),
	(8,5,4,1,'2026-1-1');
	
#select *
#from pedidos
#where ;