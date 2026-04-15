USE curso;

-- NOTA = 10 :)))))

/*
1. Obtener todos los empleados, indicando su número de empleado, su apellido, el
nombre de su departamento y su localidad (Producto Cartesiano) — 0,50 pts.

BIEN = 0.5
*/

SELECT e.emp_no,e.apellido,d.dnombre,d.localidad
FROM empleados e, departamentos d;

/*
2. Enlazar la tabla empleados con la tabla departamentos de forma que para cada
empleado solo se muestre la fila correspondiente a su departamento (Join simple) —
0,50 pts 

BIEN = 0.5
*/

SELECT e.apellido,d.dnombre
FROM empleados e
JOIN departamentos d
WHERE e.dep_no = d.dep_no;

/*
 1. Obtener los distintos departamentos existentes en la tabla de empleados — 0,75 pts 
 
 BIEN = 0.75
 */

SELECT d.dnombre
FROM empleados e, departamentos d
WHERE e.dep_no = d.dep_no;

/*
2. Mostrar los datos relativos a empleados: número, apellido, nombre de departamento
y localidad — 0,75 pts.

BIEN = 0.75
*/

SELECT e.emp_no,e.apellido,d.dnombre,d.localidad
FROM empleados e, departamentos d
WHERE e.dep_no = d.dep_no;

/*
1. Listar los empleados de los departamentos diferentes al de VENTAS — 0,75 pts.

BIEN = 0.75
*/

SELECT e.apellido, e.emp_no
FROM empleados e, departamentos d
WHERE e.dep_no = d.dep_no AND d.dnombre != 'VENTAS';

/*
2. Listar los empleados de departamentos con códigos mayores que el código del
departamento de contabilidad — 0,75 pts.

BIEN = 0.75
*/

/* ****HACER CON JOIN SI ESTAS ABURRIDO**** */
SELECT e.apellido,e.emp_no
FROM empleados e, departamentos d
WHERE e.dep_no = d.dep_no AND e.dep_no > (SELECT dep_no
						FROM departamentos
						WHERE dnombre = 'CONTABILIDAD');

/*
3. Listar los empleados de departamentos con códigos menores que el código del
departamento de Barcelona — 0,75 pts.

BIEN = 0.75
*/

-- NO HAY DEPARTAMENTO MENOR QUE EL DE BARCELONA

SELECT e.apellido,e.emp_no
FROM empleados e, departamentos d
WHERE e.dep_no = d.dep_no AND e.dep_no < (SELECT dep_no
						FROM departamentos
						WHERE localidad = 'BARCELONA');
					
						
/*
1. Obtener la lista de los empleados con los nombres de sus directores — 0,75 pts.

BIEN = 0.75
*/

SELECT e1.apellido,e2.apellido AS "DIRECTOR"
FROM empleados e1, empleados e2
WHERE e1.director = e2.emp_no;

/*
2. Obtener los jefes de los empleados cuyo oficio sea el de VENDEDOR — 0,75 pts.

BIEN = 0.75
*/

SELECT e1.apellido,e2.apellido AS "DIRECTOR"
FROM empleados e1, empleados e2
WHERE e1.director = e2.emp_no AND e1.oficio = 'VENDEDOR';

/*
1. Visualizar los datos de los departamentos y de sus empleados, incluyendo también
aquellos departamentos que no tengan empleados — 0,75 pts.

BIEN = 0.75
*/						

SELECT d.dep_no,d.dnombre,d.localidad,e.apellido,e.emp_no
FROM departamentos d
LEFT JOIN empleados e
ON d.dep_no = e.dep_no;

/*
2. Obtener los departamentos con su nombre, localidad y el número de empleados
trabajando en ellos, incluyendo los que no tienen empleados — 0,75 pts.

BIEN = 0.75
*/

SELECT d.dnombre,d.localidad,COUNT(emp_no) AS "NUM EMPLEADOS"
FROM departamentos d
LEFT JOIN empleados e
ON d.dep_no = e.dep_no
GROUP BY d.dep_no;

/*
3. Obtener la lista de empleados con los nombres de sus directores, incluyendo al
PRESIDENTE — 0,75 pts.

BIEN = 0.75
*/

SELECT e1.emp_no,e1.apellido,e2.apellido AS "DIRECTOR"
FROM empleados e1
LEFT JOIN empleados e2
ON e1.director = e2.emp_no;

/*
1. Obtener apellido y oficio de los empleados que tienen el mismo oficio y mismo
número de departamento que el de INVESTIGACIÓN (mediante subconsulta) — 0,75
pts.

BIEN = 0.75
*/

SELECT apellido, oficio
FROM empleados
WHERE oficio IN (SELECT oficio
			FROM empleados
			WHERE dep_no IN (SELECT dep_no
						FROM departamentos
						WHERE dnombre = 'INVESTIGACION'));

/*
2. Obtener apellido, oficio y la localidad del departamento de los empleados que tienen
el mismo oficio y mismo número de departamento que el de INVESTIGACIÓN
(mediante composición) — 0,75 pts.

BIEN = 0.75
*/

SELECT e.apellido,e.oficio,d.localidad
FROM empleados e
JOIN departamentos d
WHERE e.dep_no = d.dep_no 
AND d.dnombre = 'INVESTIGACION';