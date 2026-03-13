/* Realiza las siguientes consultas
1. Alumnos matriculados en el curso más caro

2. Cursos en los que esté matriculada Ana López García.

3. Alumnos que tengan al menos una matrícula PAGADA.

4. Cursos cuyo precio sea superior al precio medio de todos los cursos.

5. Alumnos matriculados en más de un curso.

6. Cursos que no tengan ninguna matrícula CANCELADA.

7. Mostrar el nombre de cada alumno y cuántos cursos tiene, utilizando una
subconsulta correlacionada en el SELECT.

8. Cursos de la categoría Programación en los que haya matrículas PAGADA y
cuyo precio sea mayor que el precio medio de los cursos de Programación.

9. Alumnos cuyo email contenga el mismo dominio que el email del alumno con id
1 (usando subconsulta para obtener el dominio).

10. Mostrar las matrículas cuya fecha sea anterior a la fecha mínima de matrícula
del curso "SQL Avanzado".

*/

-- 1
SELECT id_alumno
FROM matricula
WHERE id_curso = (SELECT id_curso
			FROM curso
			GROUP BY id_curso
			HAVING MAX(precio)
			LIMIT 1);
-- 2						
SELECT id_curso
FROM matricula
WHERE id_alumno = 1;

-- 3
SELECT *
FROM alumno
WHERE id_alumno IN (SELECT id_alumno
			FROM matricula
			WHERE estado = 'PAGADA'
			GROUP BY id_alumno);
			
-- 4
SELECT * 
FROM curso
WHERE precio > (SELECT AVG(precio)
		FROM curso);
		
-- 5
SELECT * 
FROM alumno
WHERE id_alumno IN (SELECT id_alumno
			FROM matricula
			GROUP BY id_alumno
			HAVING COUNT(*) > 1);
			
-- 6
SELECT *
FROM curso
WHERE id_curso != (SELECT id_curso
			FROM matricula
			WHERE estado = 'CANCELADA'
			GROUP BY id_curso
			LIMIT 1);

-- 8
SELECT * 
FROM curso
WHERE id_curso IN (SELECT id_curso
			FROM matricula
			WHERE precio > (SELECT AVG(precio)
					FROM curso)
			AND estado = 'PAGADA');
			
