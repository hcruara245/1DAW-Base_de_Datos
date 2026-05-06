USE curso;

-- 1. Ejercicios de Procedimientos Almacenados

/* 1 - listar departamentos */
DELIMITER $$ 
CREATE PROCEDURE listar_departamentos()
BEGIN
	SELECT * FROM departamentos;
END $$
DELIMITER ;

CALL listar_departamentos();

/* 2 - buscar empleado */
DELIMITER $$
CREATE PROCEDURE buscar_emp(IN emp_no_aux INT)
BEGIN
	SELECT apellido,oficio
	FROM empleados
	WHERE emp_no = emp_no_aux;
END $$
DELIMITER ; 

CALL buscar_emp(7521);

/* 3 - nuevo producto */
DELIMITER $$
CREATE PROCEDURE insertar_producto(
    IN p_prod_no INT,
    IN p_descripcion VARCHAR(50),
    IN p_precio FLOAT,
    IN p_stock INT)
BEGIN
    INSERT INTO productos (producto_no, descripcion, precio_actual, stock_disponible)
    VALUES (p_prod_no, p_descripcion, p_precio, p_stock);
END $$
DELIMITER ;

CALL insertar_producto(6767,"Muñeco diabolico",99.50,67);

/* 4 - actualizar salario */
DELIMITER $$
CREATE PROCEDURE actualizar_salario(
	IN p_emp_no INT,
	IN p_nuevo_sal FLOAT)
BEGIN 
	UPDATE empleados 
	SET salario = p_nuevo_sal 
	WHERE emp_no = p_emp_no;
END $$
DELIMITER ;

CALL actualizar_salario(7521, 2500.50);

/* 5 - contar_pedidos_cliente */
DELIMITER $$

CREATE PROCEDURE contar_pedidos_visual(IN p_cliente_no INT)
BEGIN
    SELECT COUNT(*) AS total_pedidos
    FROM pedidos
    WHERE cliente_no = p_cliente_no;
END $$

DELIMITER ;

CALL contar_pedidos_visual(103);

-- 2.  Ejercicios de Funciones Almacenadas

/* 1 - Precio con IVA */
DELIMITER $$

CREATE FUNCTION precio_con_iva(p_precio FLOAT) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN p_precio * 1.21;
END $$

DELIMITER ;

SELECT precio_con_iva(100) AS "PrecioFinal";

/* 2 - Nombre de departamento */
DELIMITER $$

CREATE FUNCTION obtener_nombre_dep(p_dep_no INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_nombre VARCHAR(50);
    
    SELECT dnombre INTO v_nombre
    FROM departamentos
    WHERE dep_no = p_dep_no;
    
    RETURN v_nombre;
END $$

DELIMITER ;

SELECT obtener_nombre_dep(10) AS "NOMBRE";

/* 3 - Nivel de Salario */
DELIMITER $$

CREATE FUNCTION nivel_salario(p_salario FLOAT) 
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE v_resultado VARCHAR(10);
    
    IF p_salario > 3000 THEN
        SET v_resultado = 'Alto';
    ELSE
        SET v_resultado = 'Normal';
    END IF;
    
    RETURN v_resultado;
END $$

DELIMITER ;

SELECT nivel_salario(30.50) AS  "NIVEL SALARIO";
SELECT nivel_salario(30000.50) AS  "NIVEL SALARIO";

/* 4 - Stock Crítico */
DELIMITER $$

CREATE FUNCTION stock_critico(p_stock INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    IF p_stock < 5 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END $$

DELIMITER ;

SELECT stock_critico(1) AS  "Stock critico";
SELECT stock_critico(6) AS "Stock no critico";

/* 5 - Nombre completo cliente */
DELIMITER $$

CREATE FUNCTION nombre_cliente(p_cliente_no INT) 
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_nombre VARCHAR(100);
    
    SELECT nombre INTO v_nombre
    FROM clientes
    WHERE cliente_no = p_cliente_no;
    
    RETURN v_nombre;
END $$

DELIMITER ;

SELECT nombre_cliente(101) AS "Cliente 1";

-- 3. Ejercicios de Triggers (Disparadores)

/* 1 - Auditoría de Pedidos */

CREATE TABLE auditoria_pedidos (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    pedido_no INT,
    fecha_registro DATETIME
);

DELIMITER $$

CREATE TRIGGER tr_auditoria_pedidos
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_pedidos (pedido_no, fecha_registro)
    VALUES (NEW.pedido_no, NOW());
END $$

DELIMITER ;

INSERT INTO pedidos (pedido_no, cliente_no, fecha_pedido) 
VALUES (999, 101, '2023-10-25');

SELECT * FROM auditoria_pedidos;

/* 2 - Control de Salario */
DELIMITER $$
CREATE TRIGGER tr_control_salario
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    IF NEW.salario < 0 THEN
        SET NEW.salario = 0;
    END IF;
END $$
DELIMITER ;

INSERT INTO empleados (emp_no, apellido, salario, dep_no) 
VALUES (8000, 'GARCIA', -500, 10);

SELECT apellido, salario 
FROM empleados 
WHERE emp_no = 8000;
-- Resultado: Salario aparecerá como 0.


/* 3 - Seguridad en Borrado */
DELIMITER $$
CREATE TRIGGER tr_seguridad_borrado_dep
BEFORE DELETE ON departamentos
FOR EACH ROW
BEGIN
    IF OLD.dep_no = 10 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: No se permite borrar el departamento 10 (Contabilidad)';
    END IF;
END $$
DELIMITER ;

DELETE FROM departamentos WHERE dep_no = 10;
-- Resultado: Debería saltar el error "Error: No se permite borrar el departamento 10..."


/* 4 - Actualización de Stock */
-- Suponiendo que la tabla pedidos tiene las columnas 'producto_no' y 'unidades'

DELIMITER $$
CREATE TRIGGER tr_actualizar_stock
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    UPDATE productos 
    SET stock_disponible = stock_disponible - NEW.unidades
    WHERE producto_no = NEW.producto_no;
END $$
DELIMITER ;

-- Consultamos stock actual del producto 6767
SELECT stock_disponible FROM productos WHERE producto_no = 6767;

-- Insertamos un pedido de 5 unidades (ajusta los nombres de columna si varían en tu tabla)
INSERT INTO pedidos (pedido_no, producto_no, unidades, fecha_pedido) 
VALUES (1067, 6767, 5, NOW());

-- Verificamos que el stock ha bajado en 5
SELECT stock_disponible FROM productos WHERE producto_no = 6767;

/* 5 - Log de Precios */
-- Primero creamos la tabla de histórico si no existe
CREATE TABLE historico_precios (
    id_hist INT AUTO_INCREMENT PRIMARY KEY,
    producto_no INT,
    precio_anterior FLOAT,
    fecha_cambio DATETIME
);

DELIMITER $$
CREATE TRIGGER tr_log_precios
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio_actual != NEW.precio_actual THEN
        INSERT INTO historico_precios (producto_no, precio_anterior, fecha_cambio)
        VALUES (OLD.producto_no, OLD.precio_actual, NOW());
    END IF;
END $$
DELIMITER ;

UPDATE productos SET precio_actual = 120.00 WHERE producto_no = 6767;

SELECT * FROM historico_precios;
-- Resultado: Verás una fila con el precio que tenía antes del UPDATE.


/* 6 - Permisos y usuarios */

/* 1 - Crear Vendedor */
-- Borramos el usuario si ya existe para evitar errores al re-ejecutar
DROP USER IF EXISTS 'vendedor1'@'localhost';
CREATE USER 'vendedor1'@'localhost' IDENTIFIED BY 'ventas2024';

/* 2 - Permiso de Lectura */
GRANT SELECT ON curso.productos TO 'vendedor1'@'localhost';
GRANT SELECT ON curso.pedidos TO 'vendedor1'@'localhost';

/* 3 - Permiso de Escritura */
-- Otorgamos INSERT pero no DELETE sobre la tabla clientes
GRANT INSERT ON curso.clientes TO 'vendedor1'@'localhost';

/* 4 - Revocar Permisos (Acceso parcial a Empleados) */
-- En lugar de dar todo y quitar, damos SELECT solo a las columnas permitidas.
-- Esto excluye 'salario' de forma efectiva.
GRANT SELECT (emp_no, apellido, oficio, director, fecha_alta, comision, dep_no) 
ON curso.empleados 
TO 'vendedor1'@'localhost';

/* 5 - Verificar */
SHOW GRANTS FOR 'vendedor1'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;