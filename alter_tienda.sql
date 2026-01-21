USE tienda;

ALTER TABLE facturas
ADD CONSTRAINT CK_cod_oficina
	CHECK (cod_oficina BETWEEN 1 AND 1000);