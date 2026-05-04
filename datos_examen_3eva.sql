/* 
SQLyog v4.03
Host - localhost : Database - examen3eva
**************************************************************
Server version 5.0.10a-beta-nt
*/

CREATE DATABASE IF NOT EXISTS `examen3eva`;

USE `examen3eva`;

/*
Table structure for articulos
*/

DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos` (
  `codigo` INT(11) NOT NULL,
  `nombre` VARCHAR(100) DEFAULT NULL,
  `precio` INT(11) DEFAULT NULL,
  `fabricante` INT(11) DEFAULT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*
Table data for examen1asir.articulos
*/

INSERT INTO `articulos` VALUES 
(1,'portatil',545,1),
(2,'tablet',120,5),
(3,'libro electronico',99,2),
(4,'monitor',140,3),
(5,'movil',125,4),
(6,'consola ',200,2),
(7,'disco duro',99,3),
(8,'pen driver',8,5),
(9,'raton',12,3),
(10,'teclado',23,4),
(11, 'disco duro SSD',545,1);


/*
Table structure for fabricantes
*/

DROP TABLE IF EXISTS `fabricantes`;
CREATE TABLE `fabricantes` (
  `codigo` INT(11) NOT NULL,
  `nombre` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*
Table data for examen1asir.fabricantes
*/

INSERT INTO `fabricantes` VALUES 
(1,'asus'),
(2,'toshiba'),
(3,'acer'),
(5,'samsung'),
(6,'Xiaomi');

