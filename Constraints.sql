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

CREATE TABLE CURSOS(
    NUMCURSO INT NOT NULL,
    TITULO VARCHAR(50) NOT NULL
);

CREATE TABLE OFRECIMIENTOS(
    NUMCURSO INT NOT NULL,
    NUMOFR INT NOT NULLM
    FECHA DATE NOT NULL,
    AULA INT NOT NULL
);

CREATE TABLE PROFESORES(
    NUMCURSO INT NOT NULL,
    NUMOFR NOT NULL, 
    NUMEMP NOT NULL,
);

CREATE TABLE ESTUDIANTES(
    NUMCURSO INT NOT NULL,
    NUMOFR NOT NULL, 
    NUMEMP NOT NULL,
    CALIFICACION FLOAT NOT NULL 
);

CREATE TABLE EMPLEADOS(
    NUMEMP INT NOT NULL, 
    EMPLE-NOMBRE VARCHAR(30) NOT NULL, 
    PUESTO VARCHAR(30) NOT NULL
);


/*
3) Dadas las siguientes tablas:
Empleados (cod_emp, nombre, apellido, tipo_doc, num_doc, categoria, cod_ofic)
Oficinas (cod_ofic, descripción)

Crear las siguientes reglas de integridad:
- La columna cod_emp debe ser clave primaria.
- La columna cod_emp debe tener valores entre 100 y 1000.
- Las columnas tipo_doc y num_doc deben contener valores no repetidos (únicos).
- La columna Categoria debe contener algunos de los siguientes valores: Senior, Semi Senior,
Junior.
- La columna cod_ofic debe tener valores que existan en la tabla Oficinas.

*/