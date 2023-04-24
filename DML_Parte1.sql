/*
1) Realizar las siguientes proposiciones SQL con la siguiente estructura:
PROVEEDORES (NUMERO, NOMBRE, DOMICILIO, LOCALIDAD)
PRODUCTOS (PNRO, PNOMBRE, PRECIO, TAMAÑO, LOCALIDAD)
PROV-PROD (NUMERO, PNRO, CANTIDAD)
*/

CREATE TABLE PROVEEDORES(
    NUMERO INT NOT NULL,
    NOMBRE VARCHAR(30) NOT NULL,
    DOMICILIO VARCHAR(60) NOT NULL,
    LOCALIDAD VARCHAR(30) NOT NULL,
    CONSTRAINT pk_nro_proveedor PRIMARY KEY(NUMERO)
);

CREATE TABLE PRODUCTOS(
    PNRO INT NOT NULL,
    PNOMBRE VARCHAR(30) NOT NULL,
    PRECIO FLOAT NOT NULL,
    TAMAÑO VARCHAR(30) NOT NULL,
    LOCALIDAD VARCHAR(30) NOT NULL,
    CONSTRAINT pk_pnro_productos PRIMARY KEY(PNRO)
);

CREATE TABLE PROV_PROD(
    NUMERO INT NOT NULL,
    PNRO INT NOT NULL,
    CANTIDAD INT NOT NULL,
    CONSTRAINT fk_numero_prov_prod FOREIGN KEY(NUMERO) REFERENCES PROVEEDORES(NUMERO),
    CONSTRAINT fk_pnro_prov_prod FOREIGN KEY(PNRO) REFERENCES PRODUCTOS(PNRO)
);

-- 1) Obtener los detalles completos de todos los productos.
SELECT * FROM PRODUCTOS;

--2) Obtener los detalles completos de todos los proveedores de Capital.
SELECT * FROM PROVEEDORES
WHERE PROVEEDORES.LOCALIDAD = 'CABA';

--3) Obtener todos los envíos en los cuales la cantidad está entre 200 y 300 inclusive.
SELECT * 
FROM PROV_PROD AS P
WHERE P.CANTIDAD >= 200
AND P.CANTIDAD <= 300;

--4) Obtener los números de los productos suministrados por algún proveedor de Avellaneda.

SELECT DISTINCT PROD.PNRO
FROM PRODUCTOS AS PROD
INNER JOIN PROV_PROD AS PP 
    ON PP.PNRO = PROD.PNRO
INNER JOIN PROVEEDORES AS PR 
    ON PP.NUMERO = PR.NUMERO
WHERE PR.LOCALIDAD = 'Avellaneda';

--5) Obtener la cantidad total del producto 001 enviado por el proveedor 103.

SELECT SUM(PP.CANTIDAD) AS 'CANTIDAD DE PNRO 1 CON PROV 3'
FROM PROV_PROD AS PP
INNER JOIN PROVEEDORES AS PROV 
    ON PP.NUMERO = PROV.NUMERO
INNER JOIN PRODUCTOS AS PROD
    ON PP.PNRO = PROD.PNRO
WHERE PP.PNRO = 1 AND PP.NUMERO = 3;

--6) Obtener los números de los productos y localidades en los cuales la segunda letra del nombre de la localidad sea A.

SELECT PROD.PNRO, PROD.LOCALIDAD
FROM PRODUCTOS AS PROD
WHERE PROD.LOCALIDAD LIKE '_A%';

--7) Obtener los precios de los productos enviados por el proveedor 102.

SELECT PROD.PRECIO
FROM PRODUCTOS AS PROD
INNER JOIN PROV_PROD AS PP ON PROD.PNRO = PP.PNRO
WHERE PP.NUMERO = 2;

--8) Construir una lista de todas las localidades en las cuales esté situado por lo menos un proveedor o un producto.

SELECT LOCALIDAD
FROM PROVEEDORES
UNION
SELECT LOCALIDAD
FROM PRODUCTOS

--9) Cambiar a “Chico” el tamaño de todos los productos medianos.

UPDATE PRODUCTOS 
SET PRODUCTOS.TAMAÑO = 'Chico'
WHERE PRODUCTOS.TAMAÑO = 'Mediano';

--10) Eliminar todos los productos para los cuales no haya envíos.

DELETE FROM PRODUCTOS
WHERE PNRO NOT IN (
    SELECT PNRO
    FROM PROV_PROD 
);

--11) Insertar un nuevo proveedor (107) en la tabla PROVEEDORES. El nombre y la localidad son Rosales y Wilde respectivamente; el domicilio no se conoce todavía.

INSERT INTO PROVEEDORES VALUES(107, 'Rosales', '','Wilde');



