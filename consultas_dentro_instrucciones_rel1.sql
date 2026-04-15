USE curso;

/* 
1. Añadir 100 euros de comisión a los empleados tengan una comisión menor de 500
euros o nula
*/

UPDATE empleados
SET comision = IFNULL(comision,0) + 100
WHERE emp_no IN (SELECT emp_no
			WHERE IFNULL(comision,0) < 500);

/*
2. Crear una tablas clientes_producto_20 con las columnas cliente_no y
nombre_cliente, equivalentes a las de la tabla clientes, y unidades_20 equivalente
a la de la tabla pedidos, que contenga las filas de la tabla pedidos correspondientes
al producto con número 20.
*/

CREATE TABLE clientes_producto_20 AS
SELECT c.cliente_no, c.nombre, p.unidades AS unidades_20
FROM clientes c
JOIN pedidos p ON c.cliente_no = p.cliente_no
WHERE p.producto_no = 20;

/*
3. Se quiere borrar el dpartamento INVESTIGACIÓN.
Para poder hacerlo sin errores, previamente se quiere modificadar a aquellos
empleados del DEPARTAMENTO investigación pasándolos al departamento
PRODUCCIÓN. Indicar la sentecia para hacer esta cambio de los empleados si no se
conocen los valores de la columna dep_no ni del departamento INVESTIGACION ni
del departamento PRODUCCION.
*/

UPDATE empleados
SET dep_no = (SELECT dep_no 
		FROM departamentos 
		WHERE dnombre = 'PRODUCCION')
WHERE dep_no = (SELECT dep_no 
		FROM departamentos 
		WHERE dnombre = 'INVESTIGACION');
		
DELETE FROM departamentos 
WHERE dnombre = 'INVESTIGACION';

/*
4. Actualizar la columna debe de la tabla clientes incluyendo en ella el importe total de
los pedidos realizados por cada cliente
*/

UPDATE clientes c 
SET debe = (
    SELECT SUM(p.unidades * pr.precio_actual)
    FROM pedidos p, productos pr
    WHERE p.producto_no = pr.producto_no 
      AND p.cliente_no = c.cliente_no
);

/*
5. Crear la vista EMPLEADOS_GARRIDO que incluirá los datos empleado_no, apellido
salario_anual de los empleados cuyo jefe es GARRIDO
*/

CREATE VIEW EMPLEADOS_GARRIDO AS
SELECT emp_no AS empleado_no, apellido, (salario + IFNULL(comision, 0)) * 12 AS salario_anual
FROM empleados
WHERE director = (SELECT emp_no 
             FROM empleados 
             WHERE apellido = 'GARRIDO');


/*
6. Crear una vista RESUMEN_DEP de los departamentos, incluyendo todos los
departamento hasta los que no tengan ningún empleado, que permita mostrar la
información que se detalla:
• Nombre del departamento
• Número de empleados
• Suma de sus salario
• Suma de sus comisiones
*/

CREATE VIEW RESUMEN_DEP AS
SELECT 
    d.dnombre AS "Nombre del departamento",
    COUNT(e.emp_no) AS "Número de empleados",
    SUM(IFNULL(e.salario, 0)) AS "Suma de sus salarios",
    SUM(IFNULL(e.comision, 0)) AS "Suma de sus comisiones"
FROM 
    departamentos d
LEFT JOIN 
    empleados e ON d.dep_no = e.dep_no
GROUP BY 
    d.dnombre;
