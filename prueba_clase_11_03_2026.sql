-- NOTA TOTAL: 6,76

USE curso;

-- 1 BIEN: 0.28
 
SELECT *
FROM empleados
WHERE salario > (SELECT AVG(salario)
			FROM empleados);
			
-- 2 BIEN: 0.36

SELECT dnombre
FROM departamentos
WHERE dep_no = (SELECT dep_no
			FROM empleados
			WHERE apellido = 'GARRIDO');
			
-- 3 BIEN: 0.36

SELECT *
FROM empleados
WHERE (oficio,dep_no) IN (SELECT oficio,dep_no
				FROM empleados
				WHERE apellido = 'ALONSO');
				
-- 4 BIEN: 0.36

SELECT *
FROM empleados
WHERE oficio IN (SELECT oficio
			FROM empleados
			WHERE apellido = 'GARRIDO');
			
-- 5 MAL 0

SELECT *
FROM empleados
WHERE salario IN (SELECT salario
			FROM empleados
			WHERE dep_no = 30);

-- 6 MAL 0

SELECT COUNT(*) AS "Num vendedores"
FROM empleados
WHERE dep_no = (SELECT dep_no
			FROM departamentos
			WHERE dnombre = 'VENTAS');
			
-- 7 BIEN 0.36

SELECT oficio,SUM(salario) AS "SUMA SALARIO"
FROM empleados
WHERE emp_no IN (SELECT emp_no
			FROM empleados
			WHERE dep_no = (SELECT dep_no
						FROM departamentos
						WHERE dnombre = 'VENTAS'))
GROUP BY oficio;

-- 8 MAL 0 lo he hecho al contrario comiendome el NOT

SELECT emp_no, apellido
FROM empleados
WHERE dep_no NOT IN (SELECT dep_no
		FROM departamentos
		WHERE localidad != 'MADRID' AND localidad != 'BARCELONA')
ORDER BY 2 ASC;

-- 9 BIEN: 0.36

SELECT dnombre
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			WHERE emp_no IN (SELECT emp_no
						FROM empleados
						WHERE emp_no IN (SELECT emp_no
									FROM empleados
									WHERE fecha_alta < '1982-1-1')));

-- 10 BIEN: 0.36

SELECT dep_no,dnombre
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			GROUP BY dep_no
			HAVING COUNT(*) > 2);
			
-- 11 BIEN: 0.36

SELECT dnombre
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			GROUP BY dep_no
			HAVING COUNT(*) > 0);
			
-- 12 BIEN: 0.36

SELECT dnombre
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			WHERE comision IS NULL);

-- 13 BIEN: 0.36

SELECT *
FROM empleados 
WHERE salario > (SELECT salario
			FROM empleados
			WHERE dep_no = 20
			LIMIT 1);
			
-- 14 BIEN: 0.36

SELECT *
FROM departamentos
WHERE dep_no NOT IN (SELECT dep_no
			FROM empleados
			GROUP BY dep_no
			HAVING COUNT(*) > 0);

-- 15 BIEN: 0.36

SELECT *
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			GROUP BY dep_no
			HAVING COUNT(*) > 1);
			
-- 16 MAL: 0

SELECT localidad
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			WHERE salario / 0.1 > IFNULL(comision,0));
			
-- 17 BIEN: 0.36
-- Solo aparece garrido porque es el unico que entró el mismo dia y mismo departamento

SELECT *
FROM empleados
WHERE (emp_no,dep_no) = (SELECT emp_no,dep_no
				FROM empleados
				WHERE fecha_alta = (SELECT fecha_alta
							FROM empleados
							WHERE apellido = 'GARRIDO'));

-- 18 MAL: 0

SELECT *
FROM empleados
WHERE (dep_no,salario) = (SELECT dep_no,MAX(salario)
				FROM empleados
				WHERE apellido = 'JIMENEZ'
				GROUP BY dep_no);
							
-- 19 BIEN: 0.36

SELECT *
FROM empleados
WHERE salario IN (SELECT MAX(salario)
			FROM empleados
			WHERE dep_no IN (SELECT dep_no
						FROM empleados
						GROUP BY dep_no)
			GROUP BY dep_no);

-- 20 MEDIO: 0.18

SELECT *
FROM empleados
WHERE (director,dep_no) = (SELECT director,dep_no
				FROM empleados
				WHERE apellido = 'ALONSO');
				
-- 21 MAL: 0

SELECT *
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			WHERE salario >= (SELECT AVG(salario)
						FROM empleados));

-- 22 BIEN: 0.36

SELECT *
FROM departamentos
WHERE dep_no IN (SELECT dep_no
			FROM empleados
			WHERE salario > (SELECT AVG(salario+IFNULL(comision,0)/2)
						FROM empleados));
						
-- 23 MAL: 0
-- He sacado el departamento con menor presupuestp

SELECT dep_no,SUM(salario)
FROM empleados
GROUP BY dep_no
ORDER BY 2 ASC
LIMIT 1;

-- 24 MAL: 0
-- No da mal el resultado pero el proceso no está bien

SELECT dep_no, dnombre
FROM departamentos
WHERE (dep_no,3) = (SELECT dep_no,COUNT(*)
			FROM empleados 
			WHERE oficio = 'VENDEDOR'
			GROUP BY dep_no);

-- 25 MEDIO: 0.18
-- Se me ha olvidado mostrar el departamento

SELECT *
FROM empleados
WHERE fecha_alta = (SELECT MIN(fecha_alta)
			FROM empleados
			WHERE oficio = (SELECT oficio
						FROM empleados
						WHERE apellido = 'GIL'));

-- 26 BIEN: 0.36

SELECT dep_no,oficio,salario
FROM empleados
WHERE salario IN (SELECT MAX(salario)
		FROM empleados
		GROUP BY dep_no);

-- 27 BIEN: 0.36

SELECT oficio,MIN(fecha_alta) AS "Más antiguo"
FROM empleados
GROUP BY oficio;

-- 28 BIEN: 0.36

SELECT emp_no,apellido
FROM empleados
WHERE salario IN (SELECT MIN(salario)
		FROM empleados
		GROUP BY dep_no);
