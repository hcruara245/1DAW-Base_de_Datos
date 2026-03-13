/* 
1. Obtener una lista de los pedidos con la descripción del producto y el nombre del
cliente clasificados por el número del cliente. 
*/

SELECT descripcion, cliente_no
FROM pedidos, productos
WHERE pedidos.producto_no = productos.producto_no
ORDER BY 2 ASC;

/* 
2. Obtener los nombres de los empleados y los nombres de sus departamentos, para
aquellos empleados que no son del departamento VENTAS y que entraron en la
empresa después del 1 de enero de 82. 
*/

SELECT apellido,dnombre
FROM empleados,departamentos
WHERE empleados.dep_no = departamentos.dep_no 
	AND departamentos.dnombre != 'VENTAS'
	AND empleados.fecha_alta > '1982-1-1';

/* 
3. Obtener una lista de los apellidos de los vendedores con el importe acumulado de
sus pedidos. 
*/

SELECT e.apellido, SUM(prod.precio_actual * ped.unidades) AS "importe total"
FROM empleados e
JOIN clientes c ON c.vendedor_no = e.emp_no
JOIN pedidos ped ON ped.cliente_no = c.cliente_no
JOIN productos prod ON prod.producto_no = ped.producto_no
GROUP BY e.apellido;

/*
4. Obtener los nombre de los empleados del departamento 30 que son jefes directos de
algún empleado de la empresa, indicando de cuantos empleados son jefes. 
*/

SELECT apellido, COUNT(*) AS "Nº empleados"
FROM empleados e1, empleados e2 
WHERE dep_no = 30
AND e1.emp_no = e.director 
GROUP BY e.apellido;

/* 5. Realizar un listado de los empleados cuyo oficio es EMPLEADO, que incluirá los
números de empleado, los apellido y los salarios anuales, sabiendo que el salario
anual es el salario multiplicado por 14, e incluyendo en este listado el nombre del
director del empleado. */

/* 6. Visualizar los productos con el número total de pedidos, las unidades totales
vendidas, y el precio unidad de cada uno de ellos incluyendo los que no tiene n
pedidos (en este caso se mostrará un 0 en el total unidades vendidas) */
