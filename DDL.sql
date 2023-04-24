/*Crear las siguientes tablas en una nueva base de datos

Tabla 1: Proveedores.
NUMERO  NOMBRE      DOMICILIO       LOCALIDAD
101     Gómez       Nazca 920       Capital Federal
102     Pérez       Argerich 1030   Capital Federal
103     Vázquez     Sarmiento 450   Ramos Mejía
104     López       Alsina 720      Avellaneda

Tabla 2: Productos.
PNRO    PNOMBRE     PRECIO  TAMAÑO      LOCALIDAD
001     Talco       5       Chico       Capital Federal
002     Talco       7       Mediano     Capital Federal
003     Crema       8       Grande      Ramos Mejía
004     Cepillo     2       Grande      Avellaneda
005     Esmalte     1.2     Normal      Chacarita

Tabla 3: Prov-Prod.
NUMERO  PNRO    CANTIDAD
101     001     300
101     002     200
101     003     400
101     004     200
101     005     100
102     001     300
102     002     400
103     002     200
104     002     200
104     004     300
*/

CREATE DATABASE Ejercitacion_BBDD;

CREATE TABLE Proveedores
(
    NUMERO INT NOT NULL CONSTRAINT pk_proveedores PRIMARY KEY,
    NOMBRE VARCHAR(20) NOT NULL,
    DOMICILIO VARCHAR(40) NOT NULL,
    LOCALIDAD VARCHAR(40) NOT NULL, 
);

CREATE TABLE Productos
(
    PNRO INT NOT NULL CONSTRAINT pk_productos PRIMARY KEY,
    PNOMBRE VARCHAR(40) NOT NULL,
    PRECIO FLOAT NOT NULL,
    TAMAÑO VARCHAR(20) NOT NULL,
    LOCALIDAD VARCHAR(40) NOT NULL, 
);

CREATE TABLE Prov_Prod
(
    NUMERO INT NOT NULL CONSTRAINT fk_proveedores FOREIGN KEY REFERENCES Proveedores(NUMERO), 
    PNRO INT NOT NULL CONSTRAINT fk_productos FOREIGN KEY REFERENCES Productos(PNRO),
    CANTIDAD INT NOT NULL,
);

SELECT COLUMN_NAME, DATA_TYPE  
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Proveedores';

INSERT INTO Proveedores
VALUES 
    (101,'Gómez','Nazca 920','Capital Federal'),
    (102,'Pérez','Argerich 1030','Capital Federal'),
    (103,'Vázquez','Sarmiento 450','Ramos Mejía'),
    (104,'López','Alsina 720','Avellaneda');

INSERT INTO Productos
VALUES
	(001,'Talco',5,'Chico','Capital Federal'),
	(002,'Talco',7,'Mediano','Capital Federal'),
	(003,'Crema',8,'Grande','Ramos Mejía'),
	(004,'Cepillo',2,'Grande','Avellaneda'),
	(005,'Esmalte',1.2,'Normal','Chacarita');

INSERT INTO Prov_Prod
VALUES
    (101,001,300),
    (101,002,200),
    (101,003,400),
    (101,004,200),
    (101,005,100),
    (102,001,300),
    (102,002,400),
    (103,002,200),
    (104,002,200),
    (104,004,300); 


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*1) Crear una vista formada por los números de proveedores y números de 
productos situados en diferentes localidades.*/ 

CREATE VIEW V_ALGUNOS_PROVEEDORES AS 
SELECT Prov.NUMERO, Prod.PNRO
FROM Proveedores AS Prov, Productos AS Prod
WHERE Prov.LOCALIDAD != Prod.LOCALIDAD;

/*2)  Agregar la columna IMPORTADOR a la tabla PRODUCTOS.*/
ALTER TABLE PRODUCTOS ADD IMPORTADOR VARCHAR(40); 

-- 3) Crear una vista formada por los registros de los proveedores que viven en Wilde
CREATE VIEW V_PROVEEDORES_DE_WILDE AS
SELECT * FROM Proveedores 
WHERE Proveedores.LOCALIDAD LIKE '%Wilde%'; 

--4) Crear las tablas DEPARTAMENTOS y EMPLEADOS con sus relaciones, y las tablas PACIENTES y MEDICAMENTOS con sus relaciones.
CREATE TABLE DEPARTAMENTOS (
    NUMERO INT NOT NULL,
    DESCRIPCION VARCHAR(40) NOT NULL,
    CONSTRAINT pk_departamentos PRIMARY KEY(NUMERO)
);

CREATE TABLE EMPLEADOS(
    ID INT NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    EDAD INT NOT NULL,
    NRO_DEPARTAMENTO INT NOT NULL,
    CONSTRAINT pk_empleados PRIMARY KEY(ID),
    CONSTRAINT fk_empleados_por_depto FOREIGN KEY(NRO_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(NUMERO)
);

INSERT INTO DEPARTAMENTOS 
VALUES  (1, 'Ventas'),
        (2, 'Finanzas'),
        (3, 'Recursos Humanos');

INSERT INTO EMPLEADOS (ID, NOMBRE, EDAD, NRO_DEPARTAMENTO) 
VALUES  (1, 'Juan Perez', 30, 1),
        (2, 'Maria Gomez', 25, 1),
        (3, 'Pedro Martinez', 40, 2),
        (4, 'Laura Rodriguez', 35, 2),
        (5, 'Ana Fernandez', 28, 3);

CREATE TABLE MEDICAMENTOS(
    ID INT NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    DESCRIPCION VARCHAR(255) NOT NULL DEFAULT 'Ver prospecto',
    PRECIO FLOAT NOT NULL,
    STOCK INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_id_medicamento PRIMARY KEY(ID)
);

CREATE TABLE PACIENTES(
    NRO_SOCIO INT NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    CONDICION VARCHAR(255) NOT NULL,
    ID_MEDICAMENTO INT NOT NULL, 
	CONSTRAINT pk_nro_socio PRIMARY KEY(NRO_SOCIO),
    CONSTRAINT fk_id_medicamento FOREIGN KEY(ID_MEDICAMENTO) REFERENCES MEDICAMENTOS(ID)
);

-- Inserción de medicamentos
INSERT INTO MEDICAMENTOS(ID, NOMBRE, PRECIO, STOCK) VALUES (1, 'Paracetamol', 5.99, 100);
INSERT INTO MEDICAMENTOS(ID, NOMBRE, PRECIO, STOCK) VALUES (2, 'Ibuprofeno', 7.99, 50);
INSERT INTO MEDICAMENTOS(ID, NOMBRE, PRECIO, STOCK) VALUES (3, 'Amoxicilina', 12.50, 30);
INSERT INTO MEDICAMENTOS(ID, NOMBRE, PRECIO, STOCK) VALUES (4, 'Aspirina', 3.50, 200);

-- Inserción de pacientes
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (1, 'Juan Pérez', 'Dolor de cabeza', 1);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (2, 'María Gómez', 'Fiebre', 1);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (3, 'Pedro Rodríguez', 'Dolor muscular', 2);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (4, 'Laura Fernández', 'Inflamación', 2);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (5, 'Sofía Ruiz', 'Infección', 3);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (6, 'Carlos González', 'Dolor de muelas', 4);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (7, 'Ana Sánchez', 'Resfriado', 1);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (8, 'Diego García', 'Dolor de garganta', 3);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (9, 'Lucía Torres', 'Dolor de espalda', 2);
INSERT INTO PACIENTES(NRO_SOCIO, NOMBRE, CONDICION, ID_MEDICAMENTO) VALUES (10, 'Javier López', 'Dolor de oído', 4);

