-- drop database examen;

-- Crear la base de datos
CREATE DATABASE examen;

-- EJERCICIO 1
CREATE TABLE pilotos(
	Codigo CHAR(4),
	Nombre VARCHAR(15),
	nacionalidad VARCHAR(15),
	FechaNacimiento DATE,
	CarreraDebut VARCHAR(20),
	NombreEscuderia VARCHAR(20),
		CONSTRAINT PK_pilotos PRIMARY KEY(Codigo),
		CHECK (FechaNacimiento < '1999-1-1'),
		CHECK (Nacionalidad = 'Española' OR Nacionalidad = 'Italiana' OR Nacionalidad = 'Australiana' OR Nacionalidad = 'Estadounidense')
);
-- EJERCICIO 2
CREATE TABLE circuitos(
	Nombre VARCHAR(15),
	Pais VARCHAR(15),
	Tipo VARCHAR(15),
	Longitud FLOAT(6,2),
	-- No le pongo la ñ a diseñador por si acaso para que no de errores
	Disenador VARCHAR(20),
		CHECK (Longitud < 7000)
);
-- EJERCICIO 3
CREATE TABLE carreras(
	NombreGP VARCHAR(15),
	-- Igual que diseñador no le pongo ñ por si acaso
	Anyo CHAR(4),
	FechaHoraInicio DATETIME,
	NumVueltas INT(2),
	NombreCircuito VARCHAR(15),
		CONSTRAINT PK_carreras PRIMARY KEY (NombreGP,Anyo),
		CHECK (Anyo > 2000),
		CONSTRAINT CHK_carreras_1 CHECK (MONTH(FechaHoraInicio) BETWEEN 3 AND 10),
		CONSTRAINT CHK_carreras_2 CHECK (NumVueltas BETWEEN 16 AND 32)
);
-- EJERCICIO 4
CREATE TABLE escuderias(
	Nombre VARCHAR(15),
	Manager VARCHAR(15),
	FabricanteMotor VARCHAR(15),
	Sede VARCHAR(15),
		CONSTRAINT PK_escuderias PRIMARY KEY (Nombre),
		CHECK (FabricanteMotor = 'Honda' OR FabricanteMotor = 'Yamaha' OR FabricanteMotor = 'Ducati'),
		CHECK (Sede = 'Bélgica' OR Sede = 'Francia' OR Sede = 'Italia')
);
-- EJERCICIO 5
CREATE TABLE resultados(
	NombreGP VARCHAR(15),
	Anyo CHAR(4),
	CodPiloto CHAR(4),
	Puesto INT(2),
	DistanciaGanador CHAR(8),
		CONSTRAINT FK_resultados_carreras FOREIGN KEY(NombreGP,Anyo)
		REFERENCES carreras(NombreGP,Anyo),
		CONSTRAINT FK_resultados_pilotos FOREIGN KEY(CodPiloto)
		REFERENCES pilotos(Codigo)
);
-- EJERCICIO 6
INSERT INTO pilotos(Codigo,Nombre,FechaNacimiento,CarreraDebut,NombreEscuderia)
	VALUES ('0093','Marc Márquez','1993-2-17','Australia 2007','RedBull');
-- EJERCICIO 7
ALTER TABLE circuitos
ADD estado VARCHAR(20);
-- EJERCICIO 8
ALTER TABLE pilotos
ADD enPodio2011 CHAR(2)
DEFAULT '0';

DELETE FROM pilotos
WHERE enPodio2011 = 0;

/* Inserts para las consultas */
INSERT INTO pilotos
	VALUES ('0099','Dani Pedrosa','Española','1989-1-12','Malasya 2001','Yamaha',10);
	
INSERT INTO circuitos
	VALUES ('AngelNieto','España','mixto',3486.35,'Ingenieros','Perfecto'),
	('Monza','Italia','Urbano',5943.73,'Italianos','Corroido');

INSERT INTO carreras
	VALUES ('GP Austria','2024','2024-03-3 15:00:00',30,'RedbullRing'),
	('GP Malasya','2021','2021-03-3 05:00:00',30,'MalasyaCircuit'),
	('GP Malasya23','2023','2023-03-3 05:00:00',30,'MalasyaCircuit');
	
INSERT INTO resultados
	VALUES ('GP Austria','2024','0099',1,'0:17.457');
/* --------- */

-- EJERCICIO 9
SELECT Codigo,Nombre,Nacionalidad,FechaNacimiento
FROM pilotos
WHERE Nacionalidad = 'Española' AND FechaNacimiento < '1990-1-1'
ORDER BY FechaNacimiento,Nombre DESC;
-- EJERCICIO 10
SELECT Nombre,Pais,Tipo,Longitud
FROM circuitos
WHERE Pais = 'España' OR Pais = 'Italia' AND Tipo = 'urbano'  OR Tipo = 'mixto' AND Longitud BETWEEN 4000 AND 6500;
-- EJERCICIO 11
SELECT CodPiloto, COUNT(*) AS "Victorias"
FROM resultados
WHERE Puesto = 1
GROUP BY CodPiloto
HAVING Victorias >= 1
ORDER BY 2 DESC;
-- EJERCICIO 12
SELECT Pais, COUNT(*) AS "NumCircuitos"
FROM circuitos
GROUP BY Pais
ORDER BY 2 DESC;
-- EJERCICIO 13
-- No hay ningun atributo que sea Pais, así que lo tomaré como que es NombreGP que es más
-- o menos lo mismo
SELECT NombreGP,AVG(NumVueltas) AS "Promedio de Vueltas"
FROM carreras
GROUP BY NombreGP
ORDER BY 2 DESC;
-- EJERCICIO 14
SELECT NombreCircuito, MAX(FechaHoraInicio) AS "Ultima Carrera"
FROM carreras
GROUP BY NombreCircuito
ORDER BY 2 DESC;