CREATE DATABASE SistemaHorariosDocentes;
GO

USE SistemaHorariosDocentes;
GO

CREATE TABLE Departamentos (
    Departamento_ID INT NOT NULL,
    Nombre_Departamento VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Docentes (
    Docente_ID INT NOT NULL,
    Documento VARCHAR(20) NOT NULL,
    Nombre_Docente VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Tipo_Contrato VARCHAR(30) NOT NULL DEFAULT 'Planta',
    Departamento_ID INT NOT NULL,
    Fecha_Ingreso DATE NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE Aulas (
    Aula_ID INT NOT NULL,
    Codigo_Aula VARCHAR(20) NOT NULL,
    Edificio VARCHAR(50) NOT NULL,
    Capacidad INT NOT NULL DEFAULT 30,
    Tipo_Aula VARCHAR(30) NOT NULL DEFAULT 'Teorica'
);
GO

CREATE TABLE Asignaturas (
    Asignatura_ID INT NOT NULL,
    Codigo_Asignatura VARCHAR(20) NOT NULL,
    Nombre_Asignatura VARCHAR(100) NOT NULL,
    Creditos INT NOT NULL DEFAULT 3,
    Departamento_ID INT NOT NULL
);
GO

CREATE TABLE Franjas_Horarias (
    Franja_ID INT NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL,
    Turno VARCHAR(20) NOT NULL DEFAULT 'Manana'
);
GO

CREATE TABLE Asignacion_Horarios (
    Horario_ID INT NOT NULL,
    Docente_ID INT NOT NULL,
    Asignatura_ID INT NOT NULL,
    Aula_ID INT NOT NULL,
    Franja_ID INT NOT NULL,
    Dia_Semana VARCHAR(15) NOT NULL,
    Periodo_Academico VARCHAR(20) NOT NULL DEFAULT '2026-1'
);
GO

ALTER TABLE Departamentos
ADD CONSTRAINT PK_Departamentos PRIMARY KEY (Departamento_ID);

ALTER TABLE Departamentos
ADD CONSTRAINT UQ_Departamentos_Nombre UNIQUE (Nombre_Departamento);

ALTER TABLE Docentes
ADD CONSTRAINT PK_Docentes PRIMARY KEY (Docente_ID);

ALTER TABLE Docentes
ADD CONSTRAINT UQ_Docentes_Documento UNIQUE (Documento);

ALTER TABLE Docentes
ADD CONSTRAINT UQ_Docentes_Email UNIQUE (Email);

ALTER TABLE Aulas
ADD CONSTRAINT PK_Aulas PRIMARY KEY (Aula_ID);

ALTER TABLE Aulas
ADD CONSTRAINT UQ_Aulas_Codigo UNIQUE (Codigo_Aula);

ALTER TABLE Asignaturas
ADD CONSTRAINT PK_Asignaturas PRIMARY KEY (Asignatura_ID);

ALTER TABLE Asignaturas
ADD CONSTRAINT UQ_Asignaturas_Codigo UNIQUE (Codigo_Asignatura);

ALTER TABLE Franjas_Horarias
ADD CONSTRAINT PK_Franjas_Horarias PRIMARY KEY (Franja_ID);

ALTER TABLE Asignacion_Horarios
ADD CONSTRAINT PK_Asignacion_Horarios PRIMARY KEY (Horario_ID);
GO

ALTER TABLE Docentes
ADD CONSTRAINT FK_Docentes_Departamentos
FOREIGN KEY (Departamento_ID) REFERENCES Departamentos(Departamento_ID);

ALTER TABLE Asignaturas
ADD CONSTRAINT FK_Asignaturas_Departamentos
FOREIGN KEY (Departamento_ID) REFERENCES Departamentos(Departamento_ID);

ALTER TABLE Asignacion_Horarios
ADD CONSTRAINT FK_Horarios_Docentes
FOREIGN KEY (Docente_ID) REFERENCES Docentes(Docente_ID);

ALTER TABLE Asignacion_Horarios
ADD CONSTRAINT FK_Horarios_Asignaturas
FOREIGN KEY (Asignatura_ID) REFERENCES Asignaturas(Asignatura_ID);

ALTER TABLE Asignacion_Horarios
ADD CONSTRAINT FK_Horarios_Aulas
FOREIGN KEY (Aula_ID) REFERENCES Aulas(Aula_ID);

ALTER TABLE Asignacion_Horarios
ADD CONSTRAINT FK_Horarios_Franjas
FOREIGN KEY (Franja_ID) REFERENCES Franjas_Horarias(Franja_ID);
GO

ALTER TABLE Aulas
ADD CONSTRAINT CK_Aulas_Capacidad CHECK (Capacidad > 0);

ALTER TABLE Asignaturas
ADD CONSTRAINT CK_Asignaturas_Creditos CHECK (Creditos > 0);

ALTER TABLE Docentes
ADD CONSTRAINT CK_Docentes_Contrato CHECK (Tipo_Contrato IN ('Planta', 'Tiempo Completo', 'Medio Tiempo', 'Catedra'));

ALTER TABLE Asignacion_Horarios
ADD CONSTRAINT CK_Horarios_Dia CHECK (Dia_Semana IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'));
GO


INSERT INTO Departamentos (Departamento_ID, Nombre_Departamento) VALUES
(1, 'Ingenieria de Sistemas'),
(2, 'Ciencias Basicas'),
(3, 'Administracion de Empresas'),
(4, 'Matematicas'),
(5, 'Humanidades');
GO

INSERT INTO Docentes (Docente_ID, Documento, Nombre_Docente, Email, Telefono, Tipo_Contrato, Departamento_ID, Fecha_Ingreso) VALUES
(1, '101012301', 'Carlos Perez', 'carlos.perez@institucion.edu.co', '3104567890', 'Planta', 1, '2019-01-15'),
(2, '101012302', 'Maria Gomez', 'maria.gomez@institucion.edu.co', '3115678901', 'Catedra', 1, '2022-03-10'),
(3, '101012303', 'Carlos Lopez', 'carlos.lopez@institucion.edu.co', '3126789012', 'Planta', 2, '2018-07-20'),
(4, '101012304', 'Ana Rodriguez', 'ana.rodriguez@institucion.edu.co', '3137890123', 'Medio Tiempo', 3, '2021-02-01'),
(5, '101012305', 'Luis Martinez', 'luis.martinez@institucion.edu.co', '3148901234', 'Tiempo Completo', 4, '2019-09-12'),
(6, '101012306', 'Laura Sanchez', 'laura.sanchez@institucion.edu.co', '3159012345', 'Catedra', 1, '2023-01-15'),
(7, '101012307', 'Pedro Ramirez', 'pedro.ramirez@institucion.edu.co', '3160123456', 'Tiempo Completo', 2, '2017-05-18'),
(8, '101012308', 'Sofia Torres', 'sofia.torres@institucion.edu.co', '3171234567', 'Planta', 3, '2015-11-25'),
(9, '101012309', 'Andres Garcia', 'andres.garcia@institucion.edu.co', '3182345678', 'Medio Tiempo', 4, '2021-08-14'),
(10, '101012310', 'Valentina Diaz', 'valentina.diaz@institucion.edu.co', '3193456789', 'Tiempo Completo', 1, '2020-06-30'),
(11, '101012311', 'David Hernandez', 'david.hernandez@institucion.edu.co', '3204567891', 'Catedra', 2, '2023-02-10'),
(12, '101012312', 'Camila Castro', 'camila.castro@institucion.edu.co', '3215678902', 'Tiempo Completo', 3, '2019-03-15'),
(13, '101012313', 'Jorge Morales', 'jorge.morales@institucion.edu.co', '3226789013', 'Planta', 4, '2016-10-05'),
(14, '101012314', 'Isabella Ruiz', 'isabella.ruiz@institucion.edu.co', '3237890124', 'Medio Tiempo', 1, '2021-07-11'),
(15, '101012315', 'Daniel Vargas', 'daniel.vargas@institucion.edu.co', '3248901235', 'Catedra', 2, '2022-09-01'),
(16, '101012316', 'Paula Jimenez', 'paula.jimenez@institucion.edu.co', '3259012346', 'Tiempo Completo', 3, '2018-04-22'),
(17, '101012317', 'Miguel Alvarez', 'miguel.alvarez@institucion.edu.co', '3260123457', 'Catedra', 4, '2023-01-20'),
(18, '101012318', 'Sara Rojas', 'sara.rojas@institucion.edu.co', '3271234568', 'Planta', 1, '2014-12-01'),
(19, '101012319', 'Felipe Ortiz', 'felipe.ortiz@institucion.edu.co', '3282345679', 'Tiempo Completo', 2, '2020-02-15'),
(20, '101012320', 'Natalia Marin', 'natalia.marin@institucion.edu.co', '3293456790', 'Medio Tiempo', 3, '2022-05-10');
GO

INSERT INTO Aulas (Aula_ID, Codigo_Aula, Edificio, Capacidad, Tipo_Aula) VALUES
(1, 'LAB-101', 'Bloque 1', 35, 'Laboratorio'),
(2, 'LAB-102', 'Bloque 1', 35, 'Laboratorio'),
(3, 'AU-201', 'Bloque 2', 45, 'Teorica'),
(4, 'AU-202', 'Bloque 2', 50, 'Teorica'),
(5, 'AU-301', 'Bloque 2', 30, 'Teorica'),
(6, 'AUD-01', 'Central', 120, 'Auditorio'),
(7, 'LAB-201', 'Bloque 1', 40, 'Laboratorio'),
(8, 'AU-401', 'Bloque 3', 60, 'Teorica'),
(9, 'AU-402', 'Bloque 3', 25, 'Teorica'),
(10, 'AUD-02', 'Central', 150, 'Auditorio');
GO

INSERT INTO Asignaturas (Asignatura_ID, Codigo_Asignatura, Nombre_Asignatura, Creditos, Departamento_ID) VALUES
(1, 'IS-101', 'Programacion Orientada a Objetos', 4, 1),
(2, 'IS-102', 'Bases de Datos', 3, 1),
(3, 'IS-103', 'Estructuras de Datos', 4, 1),
(4, 'CB-201', 'Calculo Diferencial', 3, 2),
(5, 'CB-202', 'Fisica Mecanica', 3, 2),
(6, 'CB-203', 'Algebra Lineal', 3, 2),
(7, 'AD-301', 'Fundamentos de Administracion', 3, 3),
(8, 'AD-302', 'Gestion de Proyectos', 3, 3),
(9, 'AD-303', 'Contabilidad', 3, 3),
(10, 'MA-401', 'Estadistica Inferencial', 3, 4),
(11, 'MA-402', 'Matematicas Discretas', 3, 4),
(12, 'IS-104', 'Ingenieria de Software', 4, 1),
(13, 'IS-105', 'Desarrollo Web', 3, 1),
(14, 'CB-204', 'Matematicas Operativas', 3, 2),
(15, 'AD-304', 'Marketing', 3, 3);
GO

INSERT INTO Franjas_Horarias (Franja_ID, Hora_Inicio, Hora_Fin, Turno) VALUES
(1, '06:00:00', '08:00:00', 'Manana'),
(2, '08:00:00', '10:00:00', 'Manana'),
(3, '10:00:00', '12:00:00', 'Manana'),
(4, '14:00:00', '16:00:00', 'Tarde'),
(5, '16:00:00', '18:00:00', 'Tarde'),
(6, '18:00:00', '20:00:00', 'Noche'),
(7, '20:00:00', '22:00:00', 'Noche');
GO

INSERT INTO Asignacion_Horarios (Horario_ID, Docente_ID, Asignatura_ID, Aula_ID, Franja_ID, Dia_Semana, Periodo_Academico) VALUES
(1, 1, 1, 1, 1, 'Lunes', '2026-1'),
(2, 1, 13, 2, 2, 'Miercoles', '2026-1'),
(3, 2, 2, 1, 3, 'Martes', '2026-1'),
(4, 3, 4, 3, 2, 'Lunes', '2026-1'),
(5, 4, 7, 4, 4, 'Jueves', '2026-1'),
(6, 5, 10, 5, 1, 'Viernes', '2026-1'),
(7, 6, 3, 2, 4, 'Miercoles', '2026-1'),
(8, 7, 5, 3, 5, 'Martes', '2026-1'),
(9, 8, 8, 4, 6, 'Lunes', '2026-1'),
(10, 9, 11, 5, 2, 'Jueves', '2026-1'),
(11, 10, 12, 1, 3, 'Viernes', '2026-1'),
(12, 11, 6, 3, 5, 'Lunes', '2026-1'),
(13, 12, 9, 4, 1, 'Martes', '2026-1'),
(14, 13, 14, 5, 6, 'Miercoles', '2026-1'),
(15, 14, 15, 6, 5, 'Jueves', '2026-1'),
(16, 15, 1, 1, 2, 'Viernes', '2026-1'),
(17, 16, 2, 2, 4, 'Lunes', '2026-1'),
(18, 17, 4, 3, 6, 'Martes', '2026-1'),
(19, 18, 7, 4, 1, 'Miercoles', '2026-1'),
(20, 19, 10, 5, 3, 'Jueves', '2026-1');
GO

UPDATE Docentes
SET Tipo_Contrato = 'Planta'
WHERE Docente_ID = 4;
GO

UPDATE Asignacion_Horarios
SET Aula_ID = 2
WHERE Horario_ID = 1;
GO


SELECT * 
FROM Departamentos;

SELECT * 
FROM Docentes;

SELECT * 
FROM Aulas;

SELECT * 
FROM Asignaturas;

SELECT * 
FROM Franjas_Horarias;

SELECT * 
FROM Asignacion_Horarios;
GO

-- CONSULTAS

-- Consulta 1: ¿Cuantos docentes hay por departamento, mostrando solo los departamentos con mas de 3 docentes?
SELECT D.Nombre_Departamento, COUNT(*) AS CantidadDocentes
FROM Docentes Doc
INNER JOIN Departamentos D ON Doc.Departamento_ID = D.Departamento_ID
GROUP BY D.Nombre_Departamento
HAVING COUNT(*) > 3;

-- Consulta 2: ¿Que docente dicta cada asignatura, en que aula y en que horario?
SELECT Doc.Nombre_Docente, A.Nombre_Asignatura, Au.Codigo_Aula, H.Dia_Semana, F.Hora_Inicio, F.Hora_Fin
FROM Asignacion_Horarios H
INNER JOIN Docentes Doc ON H.Docente_ID = Doc.Docente_ID
INNER JOIN Asignaturas A ON H.Asignatura_ID = A.Asignatura_ID
INNER JOIN Aulas Au ON H.Aula_ID = Au.Aula_ID
INNER JOIN Franjas_Horarias F ON H.Franja_ID = F.Franja_ID;

-- Consulta 3: ¿Cuantas asignaturas tiene asociadas cada departamento, incluyendo los que no tienen ninguna?
SELECT D.Nombre_Departamento, COUNT(A.Asignatura_ID) AS TotalAsignaturas
FROM Departamentos D
LEFT JOIN Asignaturas A ON D.Departamento_ID = A.Departamento_ID
GROUP BY D.Nombre_Departamento;

-- Consulta 4: ¿Cuantos creditos en total dictan los docentes por tipo de contrato, mostrando solo si suman mas de 5 creditos?
SELECT Doc.Tipo_Contrato, SUM(A.Creditos) AS TotalCreditos
FROM Docentes Doc
INNER JOIN Asignacion_Horarios H ON Doc.Docente_ID = H.Docente_ID
INNER JOIN Asignaturas A ON H.Asignatura_ID = A.Asignatura_ID
GROUP BY Doc.Tipo_Contrato
HAVING SUM(A.Creditos) > 5;

-- Consulta 5: ¿Cuantos dias o anos han pasado desde que ingresaron los docentes con contrato de Planta?
SELECT Nombre_Docente, Tipo_Contrato, Fecha_Ingreso, DATEDIFF(YEAR, Fecha_Ingreso, GETDATE()) AS AnosEnLaInstitucion
FROM Docentes
WHERE Tipo_Contrato = 'Planta';

-- Consulta 6: ¿Cuantas clases hay programadas en cada turno, mostrando solo los turnos con mas de 4 clases?
SELECT F.Turno, COUNT(H.Horario_ID) AS TotalClases
FROM Asignacion_Horarios H
INNER JOIN Franjas_Horarias F ON H.Franja_ID = F.Franja_ID
GROUP BY F.Turno
HAVING COUNT(H.Horario_ID) > 4;

-- Consulta 7: ¿Cuantas clases se imparten en cada aula, ordenadas de mayor a menor uso?
SELECT Au.Codigo_Aula, COUNT(H.Horario_ID) AS CantidadClases
FROM Aulas Au
LEFT JOIN Asignacion_Horarios H ON Au.Aula_ID = H.Aula_ID
GROUP BY Au.Codigo_Aula
ORDER BY CantidadClases DESC;
GO