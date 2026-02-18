USE curso;

-- 1. Obtener, para cada departamento, cuantos DIRECTORES hay en es departamento y
-- cual es su salario medio.

SELECT DEP_NO AS "DEPARTAMENTO", COUNT(*) AS "NUMERO DIRECTORES", AVG(SALARIO) AS "SALARIO MEDIO"
	FROM empleados
	WHERE OFICIO = 'DIRECTOR'
	GROUP BY DEP_NO;

-- 2. Obtener los salarios medios por departamento, ordenados descendentemente por
-- dicho importe, cuando dichos salarios medios sean inferiores a 3000 euros

SELECT DEP_NO AS "DEPARTAMENTO", AVG(SALARIO) AS "SALARIO MEDIO"
	FROM empleados
	GROUP BY DEP_NO
	HAVING AVG(SALARIO) < 3000
	ORDER BY 1 DESC;

-- 3. Obtener el total de unidades por producto que hay entre todos los pedidos,
-- visualizando el número de producto, y la suma de las unidades.

SELECT PRODUCTO_NO AS "NUMERO DE PRODUCTO", SUM(UNIDADES) AS "UNIDADES TOTALES"
	FROM pedidos
	GROUP BY PRODUCTO_NO;

-- 4. Listar los números de cliente que tengan más de dos pedidos, ordenado por
-- cantidad de pedidos

SELECT CLIENTE_NO AS "NUMERO CLIENTE", COUNT(*) AS "PEDIDOS"
	FROM pedidos
	GROUP BY CLIENTE_NO
	HAVING COUNT(*) > 2
	ORDER BY 2 DESC;

-- 5. Obtener las localidades en las que haya más de un cliente, visualizando
-- cuantos clientes hay.

-- 6. Obtener Los datos de los 4 productos de los que más unidades se han vendido,
-- visualizando el número de producto y las unidades vendidas