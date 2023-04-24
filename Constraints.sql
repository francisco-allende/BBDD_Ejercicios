/*
1) Una base de datos hospitalaria contiene las siguientes relaciones:
PACIENTES (CODIGO-PAC, APELLIDO-PAC, EDAD)
MEDICAMENTOS (CODIGO-MED, PRECIO-UNITARIO)
GASTOS (CODIGO-PAC, CODIGO-MED)
Indicar las claves primarias y claves ajenas de cada relación.*/

CREATE TABLE PACIENTES(
    CODIGO_PAC INT NOT NULL,
    APELLIDO_PAC VARCHAR(30) NOT NULL,
    EDAD INT NOT NULL,
    CONSTRAINT pk_codigo_pac PRIMARY KEY(CODIGO_PAC)
);

CREATE TABLE MEDICAMENTOS(
    CODIGO_MED INT NOT NULL,
    PRECIO_UNITARIO FLOAT NOT NULL,
   CONSTRAINT pk_codigo_med PRIMARY KEY(CODIGO_MED)
);

CREATE TABLE GASTOS(
    CODIGO_PAC INT NOT NULL,
    CODIGO_MED INT NOT NULL,
    CONSTRAINT fk_codigo_pac FOREIGN KEY(CODIGO_PAC) REFERENCES PACIENTES(CODIGO_PAC),
    CONSTRAINT fk_codigo_med FOREIGN KEY(CODIGO_MED) REFERENCES MEDICAMENTOS(CODIGO_MED)
);

/*
2) Dadas las siguientes relaciones:
CURSOS (NUMCURSO, TITULO)
OFRECIMIENTOS (NUMCURSO, NUMOFR, FECHA, AULA)
PROFESORES (NUMCURSO, NUMOFR, NUMEMP)
ESTUDIANTES (NUMCURSO, NUMOFR, NUMEMP, CALIFICACION)
EMPLEADOS (NUMEMP, EMPLE-NOMBRE, PUESTO)
Indicar las claves primarias y claves ajenas de cada relación.
*/

/*
2) Dadas las siguientes relaciones:
CURSOS (NUMCURSO, TITULO)
OFRECIMIENTOS (NUMCURSO, NUMOFR, FECHA, AULA)
PROFESORES (NUMCURSO, NUMOFR, NUMEMP)
ESTUDIANTES (NUMCURSO, NUMOFR, NUMEMP, CALIFICACION)
EMPLEADOS (NUMEMP, EMPLE-NOMBRE, PUESTO)
Indicar las claves primarias y claves ajenas de cada relación.
*/

CREATE TABLE CURSOS(
    NUMCURSO INT NOT NULL,
    TITULO VARCHAR(50) NOT NULL,
    CONSTRAINT pk_numcurso_cursos PRIMARY KEY(NUMCURSO)
);

CREATE TABLE OFRECIMIENTOS(
    NUMCURSO INT NOT NULL, 
    NUMOFR INT NOT NULL,
    FECHA DATE NOT NULL,
    AULA INT NOT NULL,
    CONSTRAINT pk_numofr_ofrecimientos PRIMARY KEY(NUMOFR),
    CONSTRAINT fk_numcurso_ofrecimientos FOREIGN KEY(NUMCURSO) REFERENCES CURSOS(NUMCURSO)
);

CREATE TABLE EMPLEADOS(
    NUMEMP INT NOT NULL,  
    EMPLE_NOMBRE VARCHAR(30) NOT NULL, 
    PUESTO VARCHAR(30) NOT NULL,
    CONSTRAINT pk_numemp_empleados PRIMARY KEY(NUMEMP),
);

CREATE TABLE PROFESORES(
    NUMCURSO INT NOT NULL,
    NUMOFR INT NOT NULL, 
    NUMEMP INT NOT NULL,
    CONSTRAINT fk_numcurso_profesores FOREIGN KEY (NUMCURSO) REFERENCES CURSOS(NUMCURSO),
    CONSTRAINT fk_numofr_profesores FOREIGN KEY (NUMOFR) REFERENCES OFRECIMIENTOS(NUMOFR),
    CONSTRAINT fk_numemp_profesores FOREIGN KEY (NUMEMP) REFERENCES EMPLEADOS(NUMEMP) 
);

CREATE TABLE ESTUDIANTES(
    NUMCURSO INT NOT NULL,
    NUMOFR INT NOT NULL, 
    NUMEMP INT NOT NULL,
    CALIFICACION FLOAT NOT NULL,
    CONSTRAINT fk_numcurso_estudiantes FOREIGN KEY (NUMCURSO) REFERENCES CURSOS(NUMCURSO),
    CONSTRAINT fk_numofr_estudiantes FOREIGN KEY (NUMOFR) REFERENCES OFRECIMIENTOS(NUMOFR),
    CONSTRAINT fk_numemp_estudiantes FOREIGN KEY (NUMEMP) REFERENCES EMPLEADOS(NUMEMP) 
);


/*
3) Dadas las siguientes tablas:
Empleados (cod_emp, nombre, apellido, tipo_doc, num_doc, categoria, cod_ofic)
Oficinas (cod_ofic, descripción)
*/

CREATE TABLE Empleados (
    cod_emp INT NOT NULL, 
    nombre VARCHAR(30) NOT NULL, 
    apellido VARCHAR(30) NOT NULL, 
    tipo_doc INT NOT NULL, 
    num_doc INT NOT NULL,  
    categoria VARCHAR(30) NOT NULL, 
    cod_ofic INT NOT NULL
);

CREATE TABLE Oficinas (
    cod_ofic INT NOT NULL, 
    descripción VARCHAR(30) NOT NULL,
    CONSTRAINT pk_cod_ofi_oficinas PRIMARY KEY(cod_ofic)
);

--Crear las siguientes reglas de integridad:

--- La columna cod_emp debe ser clave primaria.

ALTER TABLE Empleados
ADD CONSTRAINT pk_cod_emp_empleados PRIMARY KEY(cod_emp);

--- La columna cod_emp debe tener valores entre 100 y 1000.

ALTER TABLE Empleados
ADD CONSTRAINT ck_cod_emp_empleados CHECK(cod_emp > 99 AND cod_emp < 1001);

--- Las columnas tipo_doc y num_doc deben contener valores no repetidos (únicos).

ALTER TABLE Empleados
ADD CONSTRAINT uk_numForTipoCod_And_NumCod_empleados UNIQUE(tipo_doc, num_doc);

--- La columna Categoria debe contener algunos de los siguientes valores: Senior, Semi Senior, Junior.

ALTER TABLE Empleados
ADD CONSTRAINT ck_categoria_empleados CHECK(categoria  IN('Senior', 'Semi Senior', 'Junior'));

--- La columna cod_ofic debe tener valores que existan en la tabla Oficinas.

ALTER TABLE Empleados
ADD CONSTRAINT fk_cod_ofi_empleados FOREIGN KEY(cod_ofic) REFERENCES Oficinas(cod_ofic); 

