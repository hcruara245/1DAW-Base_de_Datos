USE examen3eva;

/*
1. Obtener el nombre de los productos cuyo precio sea mayor a 200€.
*/

SELECT nombre
FROM articulos
WHERE precio > 200;

/*
2. Obtener todos los datos de los artículos cuyo precio esté entre los 60€ y los
120€ (ambas cantidades incluidas).
*/

SELECT *
FROM articulos
WHERE precio >= 60 AND precio <= 120;

/*
3. Obtener el nombre y el precio en euros y en pesetas (el precio en pesetas es el
precio en euros multiplicado por 166,386).
*/

SELECT nombre, precio AS "precio euros", SUM(precio * 166.386) AS "precio pesetas"
FROM articulos
GROUP BY nombre,precio;

/*
4. Seleccionar el precio medio de todos los productos
*/

SELECT AVG(precio) AS "PRECIO MEDIO"
FROM articulos;

/*
5. Obtener el precio medio de los artículos cuyo código de fabricante sea 2.
*/

SELECT AVG(precio) AS "PRECIO MEDIO"
FROM articulos
WHERE fabricante = 2;

/*
6. Obtener el número de artículos cuyo precio sea mayor o igual a 180€.
*/

SELECT COUNT(*) AS "Num articulos"
FROM articulos
WHERE precio >= 180;

/*
7. Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a
180€ ordenados descendentemente por precio y luego ascendentemente por
nombre.
*/

SELECT nombre,precio
FROM articulos
WHERE precio >= 180
ORDER BY precio DESC,nombre ASC;

/*
8. Obtener un listado completo de artículos, incluyendo por cada artículo los
datos del artículo y de su fabricante.
*/

SELECT *
FROM articulos a, fabricantes f
WHERE a.fabricante = f.codigo
ORDER BY a.codigo;

/*
9. Listar los nombres de los fabricantes que no tienen ningún artículo registrado
en la tienda.
*/

SELECT nombre
FROM fabricantes
WHERE codigo NOT IN (SELECT fabricante
			FROM articulos);

/*
10.Obtener el precio medio de los productos de cada fabricante, mostrando el
código del fabricante, el nombre y el precio medio
*/

SELECT a.fabricante,f.nombre,AVG(a.precio) AS "Precio medio"
FROM articulos a
JOIN fabricantes f
ON a.fabricante = f.codigo
GROUP BY a.fabricante
ORDER BY a.fabricante ASC;

/*
11.Obtener el nombre y el precio de los artículos cuyo nombre contenga la
palabra 'Monitor' y cuyo precio sea inferior a la media de todos los artículos.
*/

SELECT nombre, precio
FROM articulos
WHERE nombre LIKE '%Monitor%'
AND precio < (SELECT AVG(precio)
		FROM articulos);
		
/*
12. Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio
medio sea mayor o igual a 150 €.
*/

SELECT f.nombre, a.precio
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
GROUP BY a.fabricante,a.precio
HAVING AVG(a.precio) >= 150;

/*
13. Obtener el nombre, precio y nombre del fabricante del artículo más barato.
*/

SELECT a.nombre,a.precio,f.nombre
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE a.precio = (SELECT MIN(precio)
			FROM articulos);
			
/*
14. Obtener una lista con el nombre y precio de los artículos más caros de cada
proveedor (incluyendo el nombre del proveedor)
*/

SELECT a.nombre,a.precio, f.nombre
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE a.precio IN (SELECT MAX(precio)
			FROM articulos
			GROUP BY fabricante)
ORDER BY f.nombre DESC;

/*
15.Nombres de los fabricantes cuyos artículos tienen todos un precio superior a
la media de todos los productos de la tienda.
*/

SELECT f.nombre
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE a.precio > (SELECT AVG(precio)
			FROM articulos)
GROUP BY f.nombre
ORDER BY f.nombre DESC;

/*
16. Mostrar el nombre de cada fabricante y la suma total de los precios de todos
sus artículos, pero solo para aquellos fabricantes cuyo nombre tenga
exactamente 4 caracteres.
*/

SELECT f.nombre, SUM(a.precio) AS "Precio"
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE LENGTH(f.nombre) = 4
GROUP BY f.nombre;

/*
17. Listar los nombres de los fabricantes que tienen al menos dos artículos
diferentes registrados con el mismo precio.
*/

SELECT f.nombre
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE a.codigo IN (SELECT a1.codigo
			FROM articulos a1 JOIN articulos a2
			ON a1.precio = a2.precio
			AND a1.codigo != a2.codigo
			AND a1.fabricante = a2.fabricante)
GROUP BY f.nombre
HAVING COUNT(*) >= 2;

/*
18.Obtener el nombre del fabricante, el nombre de su artículo más caro y su
precio,
pero solo si ese precio es superior a la media global.
*/

SELECT f.nombre,a.nombre,a.precio
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE a.precio IN (SELECT MAX(precio)
			FROM articulos
			GROUP BY fabricante)
AND a.precio > (SELECT AVG(precio)
			FROM articulos)
GROUP BY f.nombre,a.nombre,a.precio
ORDER BY f.nombre DESC;

/*
19.Seleccionar los nombres de fabricantes que fabrican algún producto de más de
100€ y que tienen un catálogo de más de 2 artículos
*/

SELECT f.nombre
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE a.nombre IN (SELECT nombre
			FROM articulos
			WHERE precio > 100)
AND f.codigo IN (SELECT fabricante
			FROM articulos
			GROUP BY fabricante
			HAVING COUNT(*) > 2)
GROUP BY f.nombre;
			
/*
20. Para cada fabricante con más de un producto, obtener su nombre y la
diferencia de precio entre su artículo más caro y el más barato.
*/

SELECT f.nombre,MAX(a.precio) - MIN(a.precio) AS "Diferencia precio"
FROM articulos a JOIN fabricantes f
ON a.fabricante = f.codigo
WHERE f.codigo IN (SELECT fabricante
			FROM articulos
			GROUP BY fabricante
			HAVING COUNT(*) > 1)
GROUP BY f.nombre;