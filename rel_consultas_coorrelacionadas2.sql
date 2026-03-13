-- 1. Obtener un listado con el número y nombre de los clientes atendidos por el vendedor
-- con nombre 'CALVO'.

SELECT CLIENTE_NO, NOMBRE
FROM clientes
WHERE VENDEDOR_NO = (SELECT EMP_NO
			FROM empleados
			WHERE APELLIDO = 'CALVO');

-- 2. Obtener un listado con los números de pedido, números de producto y fecha de los
-- pedidos realizados por el cliente con nombre 'EDICIONES SANZ'.

SELECT pedido_no,producto_no,fecha_pedido
FROM pedidos
WHERE cliente_no = (SELECT cliente_no
			FROM clientes
			WHERE NOMBRE = 'EDICIONES SANZ');

-- 3. Obtener el número, nombre y límite crédito de los clientes con crédito inferior a la
-- media de los créditos.

SELECT cliente_no,nombre,limite_credito
FROM clientes
WHERE limite_credito < (SELECT AVG(limite_credito)
			FROM clientes);

-- 4. Visualizar los datos del producto más caro.

SELECT * 
FROM productos
WHERE precio_actual = (SELECT MAX(precio_actual)
			FROM productos);

-- 5. Listar los clientes que han hecho algún pedido de 'DESTRUCTORA DE PAPEL A3'.

SELECT nombre,cliente_no
FROM clientes
WHERE cliente_no IN (SELECT cliente_no
			FROM pedidos
			WHERE producto_no = (SELECT producto_no
						FROM productos
						WHERE descripcion = 'DESTRUCTORA DE PAPEL A3'));


-- 6. Obtener los vendedores con más de dos clientes.

SELECT *
FROM empleados
WHERE emp_no IN (SELECT vendedor_no
			FROM clientes
			GROUP BY vendedor_no
			HAVING COUNT(*) > 2);

-- 7. Conseguir los apellidos y oficios de los empleados del departamento 10 cuyo oficio
-- sea idéntico al de cualquiera de los empleados del departamento de VENTAS.

SELECT apellido,oficio
FROM empleados
WHERE dep_no = 10
AND oficio IN (SELECT oficio
		FROM empleados
		WHERE dep_no = (SELECT dep_no
					FROM departamentos
					WHERE dnombre = 'VENTAS'));


-- 8. Visualizar los vendedores con clientes que no tengan ningún pedido.

SELECT *
FROM empleados
WHERE emp_no IN (SELECT vendedor_no
			FROM clientes
			WHERE cliente_no IN (SELECT cliente_no
						FROM clientes
						WHERE cliente_no NOT IN (SELECT DISTINCT cliente_no
										FROM pedidos)));

-- 9. Seleccionar el departamento en el que trabaja el empleado con mayor salario,
-- visualizando el nombre del departamento.

SELECT * 
FROM departamentos
WHERE dep_no = (SELECT dep_no
			FROM empleados
			WHERE emp_no = (SELECT emp_no
					FROM empleados
					WHERE salario = (SELECT MAX(salario)
								FROM empleados)));

-- 10. Seleccionar aquellos empleados cuyo salario sea menor a la media de los salarios de
-- su departamento.

SELECT AVG(salario)
FROM empleados
GROUP BY dep_no;

-- 11. Obtener los nombres y las localidades de los clientes que tengan pedidos.
-- 12. Seleccionar el departamento con menos suma salarial total (salario+comision) de la
-- empresa, visualizando el nombre del departamento.