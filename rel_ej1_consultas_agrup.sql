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

SELECT DEP_NO, COUNT(*) AS "Nº empleados"
	FROM empleados
	GROUP BY DEP_NO;
	
-- 5. Calcular el número de oficios distintos que hay en el departamento 30 de la tabla de
-- empleados

SELECT COUNT(DISTINCT OFICIO) AS "CANTIDAD OFICIOS DEP 30"
	FROM empleados;
	
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