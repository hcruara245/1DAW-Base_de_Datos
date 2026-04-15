USE curso;

/*
1. Crear una tabla CLIENTES_2 con las columnas cliente_no, nombre_cliente y
localidad_cliente equivalentes a las de la tabla clientes.
*/

CREATE TABLE clientes_2
SELECT cliente_no, nombre AS "nombre_cliente", localidad AS "localidad_cliente"
FROM clientes;

/*
2. Hacer un listado de las filas de la tabla clientes_2 de empleados de SEVILLA.
*/

SELECT * 
FROM clientes_2 
WHERE localidad_cliente = 'SEVILLA';

/*
3. Crear una tabla empleados_sin_comision con la columnas emp_no y apellido
de la tabla empleados y dnombre de la tabla departamentos, con los empleados
que no tengan comisión. Posteriormente hacer un listado de todas sus filas.
*/

INSERT INTO empleados
VALUES(7922,'LOCURA','ANALISTA',7698,'1983-04-21',1500.50,NULL,10);

CREATE TABLE empleados_sin_comision
SELECT e.emp_no, e.apellido, d.dnombre
FROM empleados e, departamentos d
WHERE e.dep_no = d.dep_no AND ISNULL(e.comision);

/*
4. Insertar en la tabla anterior todos los empleados que tengan comisión igual a cero
*/

INSERT INTO empleados_sin_comision
SELECT e.emp_no, e.apellido, d.dnombre
FROM empleados e, departamentos d
WHERE e.comision = 0 AND e.dep_no = d.dep_no;

/*
5. Rebajar un 10 % el precio de todos los productos de los que no se ha vendido nada.
*/

UPDATE productos
SET precio_actual = precio_actual - precio_actual * 0.1
WHERE producto_no NOT IN (SELECT producto_no
			FROM pedidos);
			
/*
6. Añadir 50 euros al salario de los empleados de la empresa que pertenezcan a
departamentos de MADRID y BARCELONA
*/

UPDATE empleados
SET salario = salario + 50
WHERE dep_no IN (SELECT dep_no
		FROM departamentos
		WHERE localidad = 'MADRID' OR localidad = 'BARCELONA');
		
/*
7. Borrar los clientes de la tabla CLIENTES_2 que tengan pedidos de MESA MODELO
UNION.
*/


DELETE FROM clientes_2
WHERE cliente_no IN (SELECT cliente_no
			FROM pedidos
			WHERE producto_no = (SELECT producto_no
						FROM productos
						WHERE descripcion = 'MESA MODELO UNION'));