/*
2) Dadas las siguientes tablas:
CLIENTES (código_cliente, nombre, domicilio, provincia) 
PRODUCTOS (código_producto, nombre_producto) 
ITEM_VENTAS (número_factura, código_producto, cantidad, precio) 
VENTAS (número_factura, código_cliente, fecha) 
*/

CREATE TABLE CLIENTES(
    codigo_cliente INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    domicilio VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    CONSTRAINT pk_cod_cliente_CLIENTES PRIMARY KEY(codigo_cliente)
);
CREATE TABLE PRODUCTOS(
    codigo_producto VARCHAR(3) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    CONSTRAINT pk_cod_prod_PRODUCTOS PRIMARY KEY(codigo_producto)
);
CREATE TABLE VENTAS(
    numero_factura INT NOT NULL, 
    codigo_cliente INT NOT NULL, 
    fecha DATE NOT NULL,
    CONSTRAINT pk_nro_factura_VENTAS PRIMARY KEY(numero_factura)
);

CREATE TABLE ITEM_VENTAS(
    numero_factura INT NOT NULL, 
    codigo_producto VARCHAR(3) NOT NULL, 
    cantidad INT NOT NULL, 
    precio FLOAT NOT NULL,
    CONSTRAINT fk_nro_factura_ITEM_VENTAS FOREIGN KEY(numero_factura) REFERENCES VENTAS(numero_factura),
    CONSTRAINT fk_codigo_prod_ITEM_VENTAS FOREIGN KEY(codigo_producto) REFERENCES PRODUCTOS(codigo_producto)
);

INSERT INTO CLIENTES (codigo_cliente, nombre, domicilio, provincia) VALUES
(1, 'Juan Perez', 'Av. Siempre Viva 123', 'Buenos Aires'),
(2, 'Maria Gomez', 'Calle Falsa 123', 'Cordoba'),
(3, 'Pedro Martinez', 'Av. Corrientes 456', 'Santa Fe');

INSERT INTO PRODUCTOS (codigo_producto, nombre) VALUES
('A', 'Televisor'),
('B', 'Heladera'),
('C', 'Lavarropas'),
('D', 'Microondas'),
('E', 'Cafetera');

INSERT INTO VENTAS (numero_factura, codigo_cliente, fecha) VALUES
(100, 1, '2022-01-01'),
(200, 2, '2022-01-02'),
(300, 3, '2022-01-03');

INSERT INTO ITEM_VENTAS (numero_factura, codigo_producto, cantidad, precio) VALUES
(100, 'A', 1, 15000),
(100, 'B', 1, 30000),
(200, 'A', 2, 30000),
(200, 'C', 1, 8000),
(300, 'D', 3, 2000),
(300, 'E', 1, 35000),
(300, 'C', 2, 30000);

--1. Obtener la cantidad de unidades máxima.

SELECT MAX(cantidad) AS 'Cantidad de unidades maxima'
FROM ITEM_VENTAS; 

--2. Obtener la cantidad total de unidades vendidas del producto c.

SELECT PROD.nombre AS 'Nombre producto C', SUM(ITEM.cantidad) AS 'Cantidad vendida del producto C'
FROM ITEM_VENTAS AS ITEM
INNER JOIN PRODUCTOS AS PROD ON PROD.codigo_producto = ITEM.codigo_producto
WHERE ITEM.codigo_producto = 'C'
GROUP BY(PROD.NOMBRE);

--3. Cantidad de unidades vendidas por producto, indicando la descripción del producto, ordenado de mayor a menor por las cantidades vendidas.

SELECT SUM(ITEM.cantidad) AS 'Cantidad', PROD.nombre
FROM ITEM_VENTAS AS ITEM
INNER JOIN PRODUCTOS AS PROD ON PROD.codigo_producto = ITEM.codigo_producto
GROUP BY(PROD.nombre)
ORDER BY SUM(ITEM.cantidad) DESC;

--4. Cantidad de unidades vendidas por producto, indicando la descripción del producto, ordenado alfabéticamente por nombre de producto para los productos que vendieron más de 30 unidades.

SELECT SUM(ITEM.cantidad) AS 'Cantidad', PROD.nombre
FROM ITEM_VENTAS AS ITEM
INNER JOIN PRODUCTOS AS PROD ON PROD.codigo_producto = ITEM.codigo_producto
GROUP BY PROD.nombre
HAVING SUM(ITEM.cantidad) > 30
ORDER BY PROD.nombre ASC

--5. Obtener cuantas compras (1 factura = 1 compra) realizó cada cliente indicando el código y nombre del cliente ordenado de mayor a menor.

SELECT COUNT(V.numero_factura) AS 'compras', C.codigo_cliente, C.nombre
FROM VENTAS AS V
INNER JOIN CLIENTES AS C ON C.codigo_cliente = CAST(V.codigo_cliente AS VARCHAR)
INNER JOIN ITEM_VENTAS AS IT ON IT.numero_factura = V.numero_factura
GROUP BY C.codigo_cliente, C.nombre
ORDER BY compras DESC;

--6. Promedio de unidades vendidas por producto, indicando el código del producto para el cliente 1.

SELECT ROUND(AVG(ITEM.cantidad), 2) AS 'Promedio de unidades vendidas por producto', ITEM.codigo_producto
FROM ITEM_VENTAS AS ITEM
INNER JOIN PRODUCTOS AS PR ON PR.codigo_producto = ITEM.codigo_producto
INNER JOIN VENTAS AS V ON V.numero_factura = ITEM.numero_factura
INNER JOIN CLIENTES AS C ON C.codigo_cliente = V.codigo_cliente
WHERE C.codigo_cliente = 1
GROUP BY ITEM.codigo_producto