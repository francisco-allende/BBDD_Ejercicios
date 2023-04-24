/*
3) Se tiene la siguiente base de datos relacional:
Documentos (cod_documento, descripcion)
Oficinas (cod_oficina, codigo_director, descripcion)
Empleados (cod_empleado, apellido, nombre, fecha_nacimiento, num_doc, cod_jefe, 
cod_oficina, cod_documento)
Datos_contratos (cod_empleado, fecha_contrato, cuota, ventas)
Fabricantes (cod_fabricante, razon_social)
Listas (cod_lista, descripcion, ganancia)
Productos (cod_producto, descripcion, precio, cantidad_stock, punto_reposicion, 
cod_fabricante)
Precios (cod_producto, cod_lista, precio)
Clientes (cod_cliente, cod_lista, razon_social)
Pedidos (cod_pedido, fecha_pedido, cod_empleado, cod_cliente)
Detalle_pedidos (cod_pedido, numero_linea, cod_producto, cantidad)
Resolver las siguientes consultas utilizando sentencias SQL: */

CREATE TABLE DOCUMENTOS (
    cod_documento INTEGER NOT NULL IDENTITY(1,1),
    descripcion VARCHAR(25) NULL DEFAULT 'Sin Descripcion',
    PRIMARY KEY (cod_documento)
); 

INSERT INTO DOCUMENTOS (descripcion)
VALUES
    ('Contrato'), 
    ('Alquiler'), 
    ('Documentacion personal'), 
    ('Ventas del dia'), 
    ('Compras');


CREATE TABLE OFICINAS (
    cod_oficina INTEGER NOT NULL IDENTITY(1,1),
    codigo_director INTEGER NOT NULL,
    descripcion VARCHAR(25) NULL DEFAULT 'Sin descripcion',
    PRIMARY KEY (cod_oficina)
);

INSERT INTO OFICINAS(codigo_director, descripcion)
VALUES
    (1, 'RRHH'), 
    (2, 'Ventas'), 
    (3, 'Marketing'), 
    (4, 'Sistemas'), 
    (5, 'Contable');

CREATE TABLE EMPLEADOS (
    cod_empleado INTEGER NOT NULL IDENTITY(1,1),
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    fecha_nacimiento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    num_doc VARCHAR(8) NOT NULL,
    cod_jefe INTEGER NOT NULL,
    cod_oficina INTEGER NOT NULL,
    cod_documento INTEGER NOT NULL,
    PRIMARY KEY (cod_empleado),
    FOREIGN KEY (cod_oficina) REFERENCES OFICINAS(cod_oficina), 
    FOREIGN KEY (cod_documento) REFERENCES DOCUMENTOS(cod_documento), 
);

INSERT INTO EMPLEADOS(nombre, apellido, fecha_nacimiento, num_doc, cod_jefe, cod_oficina, cod_documento)
VALUES
    ('Ivan', 'Noble', '1980-06-25', '18110150', 2, 4, 4),
    ('Martin', 'Palermo', '1990-02-25', '22110150', 4, 3, 5),
    ('Sebastian', 'Villa', '1995-02-25', '36999150', 1, 2, 4),
    ('Chiqui', 'Romero', '1990-01-01', '35110151', 4, 3, 3);

CREATE TABLE DATOS_CONTRATOS (
    cod_empleado INTEGER NOT NULL,
    fecha_contrato DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cuota FLOAT NOT NULL,
    ventas INTEGER NOT NULL,
    FOREIGN KEY (cod_empleado) REFERENCES EMPLEADOS(cod_empleado) 
);

INSERT INTO DATOS_CONTRATOS(cod_empleado, cuota, ventas)
VALUES
    (2, 25000, 5), 
    (1, 50000, 9), 
    (4, 37500, 7), 
    (2, 75000, 14);

CREATE TABLE FABRICANTES (
    cod_fabricante INTEGER NOT NULL IDENTITY(1,1),
    razon_social VARCHAR(25) NOT NULL,
    PRIMARY KEY (cod_fabricante)
);

INSERT INTO FABRICANTES(razon_social)
VALUES
    ('Nike'), 
    ('Adidas'), 
    ('Armani'), 
    ('Puma');

CREATE TABLE LISTAS (
    cod_lista INTEGER NOT NULL IDENTITY(1,1),
    descripcion VARCHAR(25) NULL DEFAULT 'Sin descripcion',
    ganancia FLOAT NOT NULL,
    PRIMARY KEY (cod_lista)
);

INSERT INTO LISTAS(descripcion, ganancia)
VALUES
    ('Lista-A', 30), ('Lista-B', 25), ('Lista-C', 15);

CREATE TABLE PRODUCTOS (
    cod_producto INTEGER NOT NULL IDENTITY(1,1),
    descripcion VARCHAR(25) NULL DEFAULT 'Sin descripcion',
    precio FLOAT NOT NULL,
    cantidad_stock INTEGER NOT NULL,
    punto_reposicion INTEGER NOT NULL,
    cod_fabricante INTEGER NOT NULL,
    PRIMARY KEY (cod_producto),
    FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante) 
) 

INSERT INTO PRODUCTOS
(descripcion, precio, cantidad_stock, punto_reposicion, cod_fabricante)
VALUES
    ('Camisa',12000 ,200,10, 1),
    ('Joggin',20000 ,95,11, 2),
    ('Jean',27000 ,70,10, 1),
    ('Zapatillas',25000 ,75,12, 3),
    ('Remera lisa',15000 ,100,12, 4),
    ('Campera',10000 ,50,11, 2),
    ('Impermeable',5000 ,500,10, 1);

CREATE TABLE PRECIOS (
    cod_producto INTEGER NOT NULL,
    cod_lista INTEGER NOT NULL,
    precio FLOAT NOT NULL,
    PRIMARY KEY (cod_producto, cod_lista),
    FOREIGN KEY (cod_producto) REFERENCES PRODUCTOS(cod_producto), 
    FOREIGN KEY (cod_lista) REFERENCES LISTAS(cod_lista) 
);

INSERT INTO PRECIOS(cod_producto, cod_lista, precio)
VALUES
    (6, 1, 12500), 
    (7, 2, 22000),
    (8, 3, 25850),
	(9, 1, 12500), 
    (10, 2, 22000),
    (11, 3, 25850),
	(12, 1, 12500); 

CREATE TABLE CLIENTES (
    cod_cliente INTEGER NOT NULL IDENTITY(1,1),
    cod_lista INTEGER NOT NULL,
    razon_social VARCHAR(25) NOT NULL,
    PRIMARY KEY (cod_cliente),
    UNIQUE (cod_cliente, cod_lista),
    FOREIGN KEY (cod_lista) REFERENCES LISTAS(cod_lista)
);

INSERT INTO CLIENTES(cod_lista, razon_social)
VALUES
    (1, 'Style Muse'),
    (2, 'La ultima moda'),
    (3, 'Hecho a mano'),
    (3, 'Azufre');

CREATE TABLE PEDIDOS (
    cod_pedido INTEGER NOT NULL IDENTITY(1,1),
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    cod_empleado INTEGER NOT NULL,
    cod_cliente INTEGER NOT NULL,
    PRIMARY KEY (cod_pedido),
    FOREIGN KEY (cod_empleado) REFERENCES EMPLEADOS(cod_empleado), 
    FOREIGN KEY (cod_cliente) REFERENCES CLIENTES(cod_cliente)
);

INSERT INTO PEDIDOS(cod_empleado, cod_cliente)
VALUES
    (1, 1), 
    (1, 2), 
    (2, 3), 
    (2, 2), 
    (2, 3),
    (3, 3), 
    (3, 4), 
    (3, 3), 
    (4, 4), 
    (2, 4);

CREATE TABLE DETALLE_PEDIDOS (
    cod_pedido INTEGER NOT NULL IDENTITY(1,1),
    numero_linea VARCHAR(25) NOT NULL,
    cod_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    PRIMARY KEY (cod_pedido),
    FOREIGN KEY (cod_producto) REFERENCES PRODUCTOS(cod_producto) 
);

INSERT INTO DETALLE_PEDIDOS(numero_linea, cod_producto, cantidad)
VALUES
    ('2022', 1, 100),
    ('2022', 2, 100),
    ('2022', 2, 75),
    ('2022', 3, 100), 
    ('2022', 4, 100),
    ('2022', 5, 100),
    ('2022', 3, 30),
    ('2022', 7, 100),
    ('2022', 4, 45),
    ('2022', 6, 100),
    ('2022', 6, 20),
    ('2022', 7, 10);


--Consultas simples (una sola tabla)

--1. Obtener una lista con los nombres de las distintas oficinas de la empresa.

SELECT DISTINCT descripcion 
FROM OFICINAS

--2. Obtener una lista de todos los productos indicando descripción del producto, su precio de costo y su precio de costo IVA incluído (tomar el IVA como 21%).

SELECT DISTINCT descripcion, precio, precio+precio*0.21 AS 'Precio mas IVA' 
FROM PRODUCTOS 

--3. Obtener una lista indicando para cada empleado apellido, nombre, fecha de cumpleaños y edad.

SELECT DISTINCT apellido, nombre, fecha_nacimiento, 
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS 'edad'
FROM EMPLEADOS

--4. Listar todos los empleados que tiene un jefe asignado.

SELECT DISTINCT *
FROM EMPLEADOS
WHERE EMPLEADOS.cod_jefe IS NOT NULL;

--5. Listar los empleados de nombre “María” ordenado por apellido.

SELECT * FROM EMPLEADOS
WHERE EMPLEADOS.nombre = 'Maria'
ORDER BY (EMPLEADOS.apellido);

--6. Listar los clientes cuya razón social comience con “L” ordenado por código de cliente.

SELECT DISTINCT * FROM CLIENTES
WHERE CLIENTES.razon_social LIKE 'L%'
ORDER BY(CLIENTES.cod_cliente);

--7. Listar toda la información de los pedidos de Marzo ordenado por fecha de pedido.

SELECT *
FROM PEDIDOS
WHERE FORMAT(PEDIDOS.fecha_pedido, 'MMMM') = 'March'
ORDER BY PEDIDOS.fecha_pedido ASC;

--8. Listar las oficinas que no tienen asignado director.

SELECT DISTINCT * 
FROM OFICINAS
WHERE OFICINAS.codigo_director IS NOT NULL;

--9. Listar los 4 productos de menor precio de costo.

SELECT DISTINCT TOP(4) * 
FROM PRODUCTOS
ORDER BY(PRODUCTOS.precio) ASC;

--10. Listar los códigos de empleados de los tres que tengan la mayor cuota.

SELECT DISTINCT TOP(3) *
FROM DATOS_CONTRATOS
ORDER BY(DATOS_CONTRATOS.cuota) DESC;

--Consultas multitablas

--1. De cada producto listar descripción, razón social del fabricante y stock ordenado por razón social y descripción.

SELECT DISTINCT descripcion, razon_social, cantidad_stock 
FROM PRODUCTOS AS P 
INNER JOIN FABRICANTES AS F ON F.cod_fabricante = P.cod_fabricante;

--2. De cada pedido listar código de pedido, fecha de pedido, apellido del empleado y razón social del cliente.

SELECT DISTINCT cod_pedido AS 'Codigo pedido', fecha_pedido AS 'Fecha pedido', apellido, razon_social AS 'Razon social'
FROM PEDIDOS AS P
INNER JOIN EMPLEADOS AS E ON E.cod_empleado = P.cod_empleado
INNER JOIN CLIENTES AS C ON C.cod_cliente = P.cod_cliente;  

--3. Listar por cada empleado apellido, cuota asignada, oficina a la que pertenece ordenado en forma descendente por cuota.

SELECT DISTINCT apellido, cuota, descripcion AS 'Oficina'
FROM EMPLEADOS AS E
INNER JOIN DATOS_CONTRATOS AS D ON D.cod_empleado = E.cod_empleado
INNER JOIN OFICINAS AS O ON O.cod_oficina = E.cod_oficina
ORDER BY(D.cuota) DESC;

--4. Listar sin repetir la razón social de todos aquellos clientes que hicieron pedidos en Abril.

SELECT DISTINCT razon_social AS 'Razon social clientes pedidos Abril'
FROM CLIENTES AS C 
INNER JOIN PEDIDOS AS P ON P.cod_cliente = C.cod_cliente
WHERE MONTH(P.fecha_pedido) = 4;

--5. Listar sin repetir los productos que fueron pedidos en Marzo.

SELECT DISTINCT descripcion AS 'Productos pedidos en marzo', precio, cantidad_stock
FROM PRODUCTOS AS PROD
INNER JOIN DETALLE_PEDIDOS AS DP ON PROD.cod_producto = DP.cod_producto
INNER JOIN PEDIDOS AS PE ON DP.cod_pedido = PE.cod_pedido
WHERE MONTH(PE.fecha_pedido) = 3;

--6. Listar aquellos empleados que están contratados por más de 10 años ordenado por cantidad de años en forma descendente.

SELECT DISTINCT E.cod_empleado, nombre, apellido, num_doc AS 'DNI', fecha_contrato, cuota, ventas
FROM EMPLEADOS AS E
INNER JOIN DATOS_CONTRATOS AS DC ON DC.cod_empleado = E.cod_empleado
WHERE DC.fecha_contrato < DATEADD(YEAR, -10, GETDATE())
ORDER BY(DC.fecha_contrato);

--7. Obtener una lista de los clientes mayoristas ordenada por razón social.

SELECT DISTINCT razon_social AS 'Clientes mayoristas'
FROM PEDIDOS AS P
INNER JOIN DATOS_CONTRATOS AS DC ON DC.cod_empleado = P.cod_empleado
INNER JOIN CLIENTES AS C ON C.cod_cliente = P.cod_cliente
WHERE DC.ventas > 100; --Al no especificarse que se considera un mayorista, uso el criterio de mayor a 100

--8. Obtener una lista sin repetir que indique qué productos compró cada cliente, ordenada por razón social y descripción.

SELECT DISTINCT CLI.cod_cliente, PROD.cod_producto, fecha_pedido, razon_social, descripcion  
FROM DETALLE_PEDIDOS AS DP
INNER JOIN PRODUCTOS AS PROD ON PROD.cod_producto = DP.cod_producto
INNER JOIN PEDIDOS AS PE ON PE.cod_pedido = DP.cod_pedido
INNER JOIN CLIENTES AS CLI ON CLI.cod_cliente = PE.cod_cliente
ORDER BY CLI.razon_social, PROD.descripcion;

--9. Obtener una lista con la descripción de aquellos productos cuyo stock está por debajo del punto de reposición
-- indicando cantidad a comprar y razón social del fabricante ordenada por razón social y descripción.

SELECT DISTINCT P.descripcion, cantidad_stock, punto_reposicion, punto_reposicion - cantidad_stock AS 'Cantidad a comprar', F.razon_social
FROM PRODUCTOS AS P
INNER JOIN FABRICANTES AS F ON F.cod_fabricante = P.cod_fabricante
WHERE P.cantidad_stock < P.punto_reposicion
ORDER BY F.razon_social, P.descripcion;

--10. Listar aquellos empleados cuya cuota es menor a 50.000 o mayor a 100.000.

SELECT DISTINCT E.cod_empleado, nombre, apellido, num_doc AS 'DNI', fecha_contrato, cuota, ventas
FROM EMPLEADOS AS E
INNER JOIN DATOS_CONTRATOS AS DC ON DC.cod_empleado = E.cod_empleado
WHERE DC.cuota > 100000 OR DC.cuota < 50000

