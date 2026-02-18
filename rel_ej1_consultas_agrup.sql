-- 1. Visualizar todos los oficios y el número de empleados de la empresa que los
-- desempeñan

SELECT OFICIO AS "Oficio", COUNT(*) AS "Nº empleados"
	FROM empleados
	GROUP BY OFICIO;
	
-- 2. Visualizar todos los oficios y el número de empleados de la empresa que lo
-- desempeñan, siempre que sean más de uno

SELECT OFICIO AS "Oficio", COUNT(*) AS "Nº empleados"
	FROM empleados
	GROUP BY OFICIO
	HAVING COUNT(*) > 1;
	
-- 3. Hallar la masa salarial (salario + comision) anual de la empresa, suponiendo 14
-- pagas

SELECT APELLIDO,14 * (SALARIO + IFNULL(COMISION,0)) AS "Masa salarial"
	FROM empleados;
	
-- 4. Obtener el número de empleados de la empresa que realizan cada oficio en cada
-- departamento

SELECT DEP_NO, OFICIO, COUNT(*) AS "Nº empleados"
	FROM empleados
	GROUP BY DEP_NO, OFICIO;
	
-- 5. Calcular el número de oficios distintos que hay en el departamento 30 de la tabla de
-- empleados

SELECT COUNT(DISTINCT OFICIO) AS "CANTIDAD OFICIOS DEP 30"
	FROM empleados
	WHERE DEP_NO = 30;
	
-- 6. Obtener las fechas de pedido del pedido más antiguo y el más reciente de cada
-- producto, mostrando también el número de producto correspondiente

SELECT PRODUCTO_NO, MIN(FECHA_PEDIDO) AS "Más antiguo",MAX(FECHA_PEDIDO) AS "Más nuevo"
	FROM pedidos
	GROUP BY PRODUCTO_NO;
	
-- 7. Obtener el total de euros que hay invertidos entre todos los productos disponibles

SELECT (PRECIO_ACTUAL * STOCK_DISPONIBLE) AS "EUROS INVERTIDOS"
	FROM productos;
	
-- 8. Obtener los salarios medios por departamentos de los vendedores y cuántos hay en
-- cada departamento, siempre que ese salario medio sea > 1.200

SELECT DEP_NO AS "Departamento",COUNT(*) AS "CANTIDAD VENDEDORES", AVG(SALARIO) AS "Salario medio"
	FROM empleados
	WHERE oficio = 'vendedor'
	GROUP BY DEP_NO
	HAVING AVG(SALARIO) > 1200;
	
-- 9. Obtener el número de departamento con mayor salario medio de sus empleados,
-- visualizando también el valor del salario medio correspondiente.

SELECT DEP_NO AS "Departamento con mayor salario medio", AVG(SALARIO) AS "Mayor salario medio"
	FROM empleados
	GROUP BY DEP_NO
	ORDER BY 2 DESC
	LIMIT 1;
	
-- 10. Visualizar las unidades totales vendidas de cada producto a cada cliente, mostrando
-- el número de producto, el número de cliente y la suma de las unidades

SELECT PRODUCTO_NO AS "Número de producto", CLIENTE_NO AS "Cliente", SUM(UNIDADES) AS "Unidades"
	FROM pedidos
	GROUP BY PRODUCTO_NO, CLIENTE_NO;
	
-- 11. Obtener aquellos productos de los que el número de pedidos que se han realizado,
-- con la fecha del pedido anterior a 1 de enero del 2000, sea mayor de uno

SELECT PRODUCTO_NO AS "Productos anteriores al 1-enero-2000"
	FROM pedidos
	WHERE FECHA_PEDIDO < '2000-1-1'
	GROUP BY PRODUCTO_NO
	HAVING COUNT(*) > 1;
	
-- 12. Obtener los números de cliente de los dos clientes con mayor número de pedidos,
-- indicando también cuantos pedidos han hecho

SELECT CLIENTE_NO AS "NUM CLIENTE", COUNT(*) AS "PEDIDOS"
	FROM pedidos
	GROUP BY CLIENTE_NO
	ORDER BY 2 DESC
	LIMIT 2;
	