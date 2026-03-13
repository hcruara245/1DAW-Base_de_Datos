USE curso;

-- 1. Listar los nombres y códigos de los departamentos en los que haya empleados.

SELECT DNOMBRE, DEP_NO
FROM departamentos
WHERE DEP_NO IN (SELECT DEP_NO
		FROM empleados
		GROUP BY DEP_NO
		HAVING COUNT(*)>=1
		);

-- 2. Obtener los datos del pedido más reciente.

SELECT *
FROM pedidos
WHERE FECHA_PEDIDO = (SELECT MAX(FECHA_PEDIDO)
			FROM pedidos
			);

-- 3. Para el departamento de VENTAS, visualizar para cada oficio, la suma de los salarios
-- de los empleados

SELECT OFICIO, SUM(SALARIO) AS "SUMA SALARIO"
FROM empleados
WHERE DEP_NO = (SELECT DEP_NO
		FROM departamentos
		WHERE DNOMBRE = 'VENTAS'
		)
GROUP BY OFICIO;

-- 4. Obtener los datos del producto del que más unidades en los pedidos de los clientes,
-- es decir, el producto del que se han pedido más unidades.

SELECT *
FROM productos
WHERE PRODUCTO_NO = (SELECT PRODUCTO_NO
			FROM pedidos
			GROUP BY PRODUCTO_NO
			HAVING MAX(PRODUCTO_NO)
			LIMIT 1);
			
-- 5. Para cada uno de los diferentes productos, seleccionar el pedido con mayor número
-- de unidades de ese producto y mostrar todos los datos del pedido correspondiente.
-- Se deben mostrar por cada producto el pedido en el que haya más unidades
-- vendidas.

SELECT *
FROM pedidos
WHERE PRODUCTO_NO = (SELECT PRODUCTO_NO
			FROM pedidos
			GROUP BY PRODUCTO_NO
			HAVING MAX(UNIDADES)
			LIMIT 1
			);

-- 6. Seleccionar los empleados de la empresa que tengan igual comisión que la media de
-- su oficio

SELECT * 
FROM empleados
WHERE IFNULL(COMISION,0) = (SELECT IFNULL(COMISION,0)
				FROM empleados
				GROUP BY COMISION
				HAVING AVG(SALARIO)
				LIMIT 1);