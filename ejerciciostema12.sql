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

/* 2 - Control de Salario*/