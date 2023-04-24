-- CATALOGOS
-- Se usara como referencia las tablas creadas para el ejercicio de DDL (Productos, Proveedores, Prov-Prod, Empleados, Departamentos, Medicamentos, Pacientes):

--1) Cuáles tablas contienen la columna LOCALIDAD?

SELECT TAB.TABLE_NAME AS Nombre_Tabla
FROM INFORMATION_SCHEMA.COLUMNS AS TAB
WHERE TAB.COLUMN_NAME = 'Localidad';

-- Resultado: Proveedores, Productos

--2) Cuántas columnas tiene la tabla PRODUCTOS?

SELECT COUNT(*) AS 'Cantidad de Columnas de la tabla Productos' 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'PRODUCTOS';

-- Resultado: 6

--3) Obtener una lista de todos los usuarios dueños de por lo menos una tabla, junto con el número de tablas que le pertenecen a cada uno.

SELECT suser_sname(uid) AS OwnerName, name AS 'Nombre tabla'
FROM sysobjects 
WHERE OBJECTPROPERTY(id, N'IsUserTable') = 1
AND OBJECT_NAME(id) IN ('Productos', 'Proveedores', 'Prov_Prod', 'EMPLEADOS', 'DEPARTAMENTOS', 'MEDICAMENTOS', 'PACIENTES');

-- Resultado: dbo en todos los casos

--4) Obtener una lista de los nombres de todas las tablas que tienen por lo menos un índice.

SELECT T.name, I.index_id
FROM sys.tables AS T
INNER JOIN sys.indexes AS I ON T.object_id = I.object_id;




