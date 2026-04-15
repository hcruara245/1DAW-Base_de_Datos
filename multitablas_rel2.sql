/* 1. Obtener un listado de clientes, indicando el número de cliente y su nombre, y el
número y nombre de sus vendedores.*/

SELECT c.cliente_no, c.nombre,c.vendedor_no,emp.apellido
FROM clientes c LEFT JOIN empleados emp
ON c.vendedor_no = emp.emp_no;

/* 2. Listar todos los pedidos realizados con la descripción del producto y el nombre del
cliente en lugar de sus números. */

SELECT p.pedido_no,p.producto_no,c.nombre,p.unidades,p.fecha_pedido
FROM pedidos p LEFT JOIN clientes c
ON p.cliente_no = c.cliente_no;

/*3. Obtener una lista de los pedidos con la descripción del producto y el nombre del
cliente de los clientes de MADRID.*/

SELECT pr.descripcion, c.nombre
FROM pedidos p
JOIN clientes c ON p.cliente_no = c.cliente_no
JOIN productos pr ON p.producto_no = pr.producto_no
WHERE c.localidad = 'MADRID';

/*4. Visualizar el nombre del departamento, la fecha de alta, el apellido, el oficio y el
nombre de localidad de aquellos trabajadores que están en un departamento ubicado
en una localidad que no contenga ninguna C en su nombre.*/

SELECT d.dnombre,e.fecha_alta,e.apellido,e.oficio,d.localidad
FROM empleados e
JOIN departamentos d ON e.dep_no = d.dep_no
WHERE d.localidad NOT LIKE '%C%';

/*5. Obtener una lista de los nombres de los clientes con el importe acumulado de sus
pedidos.*/



/*6. Obtener el número de pedidos por producto, visualizando el número de producto, su
descripción y el número de pedidos correspondiente .*/


/*7. Obtener los clientes que no pertenezcan a las localidades de sus vendedores. En el
listado visualizar el nombre del cliente y su localidad y el nombre del vendedor y su
localidad con los alias correspondientes para indicarlo.*/



/*8. Obtener los empleados que tienen un jefe que es está en el departamento 30,
mostrando el nombre del empleado y de su jefe*/



/*9. Visualizar los datos de los departamentos con el nombre del departamento, el salario
total (salario + comision) anual (14 pagas) y la comisión anual total de sus
trabajadores, incluyendo todos los departamentos. Si la comisión total anual es nula
se mostrará un cero.*/



/*10. Visualizar los nombres de los clientes y la cantidad de pedidos realizados,
incluyendo los que no hayan realizado ningún pedido.*/



/*11. Realizar un listado de todos los productos con su descripción y el importe total
(unidades totales por el precio unidad) de cada uno de ellos. Deben mostrarse todos
los productos incluidos los que no tiene pedidos y en este caso en importe total se
mostrará un 0.*/



/*12. Visualizar los apellidos de los empleados y el número de clientes que tienen,
visualizando todos los empleados de la empresa tengan o no clientes asignados*/

