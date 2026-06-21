SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS MEDICAMENTO;
DROP TABLE IF EXISTS RECOLECCION;
DROP TABLE IF EXISTS DISPOSICION_FINAL;
DROP TABLE IF EXISTS CAMPANA;
DROP TABLE IF EXISTS PUNTO_SEGURO;
DROP TABLE IF EXISTS HOGAR_INSTITUCION;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE HOGAR_INSTITUCION (
    ID_Hogar INT PRIMARY KEY,
    Nombre_Responsable VARCHAR(80) NOT NULL,
    Direccion VARCHAR(150) NOT NULL,
    Telefono VARCHAR(10),
    Correo VARCHAR(100),
    Municipio VARCHAR(100) NOT NULL,
    Numero_Integrantes INT NOT NULL,
    Fecha_Registro DATE NOT NULL
);

CREATE TABLE PUNTO_SEGURO (
    ID_Punto INT PRIMARY KEY,
    Nombre_Punto VARCHAR(100) NOT NULL,
    Direccion_Fisica VARCHAR(150) NOT NULL,
    Municipio VARCHAR(100) NOT NULL,
    Horario_Atencion VARCHAR(50) NOT NULL,
    Responsable VARCHAR(80) NOT NULL,
    Capacidad_Maxima INT NOT NULL
);

CREATE TABLE CAMPANA (
    ID_Campana INT PRIMARY KEY,
    Nombre_Campana VARCHAR(100) NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Objetivo VARCHAR(255) NOT NULL
);

CREATE TABLE DISPOSICION_FINAL (
    ID_Disposicion INT PRIMARY KEY,
    Metodo_Destruccion VARCHAR(80) NOT NULL,
    Empresa_Certificada VARCHAR(100) NOT NULL,
    Fecha_Proceso DATE NOT NULL,
    Numero_Certificado_Ambiental VARCHAR(100) NOT NULL
);

CREATE TABLE RECOLECCION (
    ID_Recoleccion INT AUTO_INCREMENT PRIMARY KEY,
    ID_Hogar INT NOT NULL,
    ID_Punto INT NOT NULL,
    ID_Campana INT NULL,
    Fecha_Evento DATE NOT NULL,
    Cantidad_Total INT NOT NULL,
    Responsable_Ruta VARCHAR(80) NOT NULL,
    FOREIGN KEY (ID_Hogar) REFERENCES HOGAR_INSTITUCION(ID_Hogar),
    FOREIGN KEY (ID_Punto) REFERENCES PUNTO_SEGURO(ID_Punto),
    FOREIGN KEY (ID_Campana) REFERENCES CAMPANA(ID_Campana)
);

CREATE TABLE MEDICAMENTO (
   ID_Medicamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Recoleccion INT NOT NULL,
    ID_Disposicion INT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Lote VARCHAR(50) NOT NULL,
    Fecha_Vencimiento DATE NOT NULL,
    Tipo_Farmaco VARCHAR(50) NOT NULL,
    Concentracion VARCHAR(50),
    Laboratorio VARCHAR(100) NOT NULL,
    Presentacion VARCHAR(50) NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (ID_Recoleccion) REFERENCES RECOLECCION(ID_Recoleccion),
    FOREIGN KEY (ID_Disposicion) REFERENCES DISPOSICION_FINAL(ID_Disposicion)
);

INSERT INTO HOGAR_INSTITUCION VALUES
(1, 'Carlos Ramírez', 'Cra 10 # 25-30', '3001234567', 'carlos@mail.com', 'Zarzal', 4, '2026-06-01'),
(2, 'María Gómez', 'Calle 8 # 12-45', '3019876543', 'maria@mail.com', 'Zarzal', 3, '2026-06-02'),
(3, 'Fundación Vida Sana', 'Av. Central # 5-80', '3024567890', 'fundacion@mail.com', 'Zarzal', 15, '2026-06-03');

INSERT INTO PUNTO_SEGURO VALUES
(1, 'Droguería Central', 'Cra 12 # 10-15', 'Zarzal', '08:00-18:00', 'Laura Pérez', 500),
(2, 'Centro de Salud Norte', 'Calle 20 # 7-40', 'Zarzal', '07:00-16:00', 'Andrés Molina', 800);

INSERT INTO CAMPANA VALUES
(1, 'Campaña Hogares Seguros', '2026-06-01', '2026-06-30', 'Recolectar medicamentos vencidos en hogares'),
(2, 'Jornada Ambiental Comunitaria', '2026-07-01', '2026-07-15', 'Promover disposición segura de medicamentos');

INSERT INTO DISPOSICION_FINAL VALUES
(1, 'Incineración controlada', 'EcoGestión Ambiental SAS', '2026-06-20', 'CERT-AMB-001'),
(2, 'Devolución al fabricante', 'Gestor Farma Seguro Ltda.', '2026-07-18', 'CERT-AMB-002');

INSERT INTO RECOLECCION VALUES
(1, 1, 1, 1, '2026-06-05', 8, 'Operador Luis Torres'),
(2, 2, 1, 1, '2026-06-08', 5, 'Operador Luis Torres'),
(3, 3, 2, 2, '2026-07-05', 12, 'Operadora Diana Ruiz'),
(4, 1, 2, NULL, '2026-07-10', 3, 'Operador Juan Castro');

INSERT INTO MEDICAMENTO VALUES
(1, 1, 1, 'Acetaminofén', 'L001', '2025-12-15', 'Pastillas', '500 mg', 'Genfar', 'Tabletas', 3),
(2, 1, 1, 'Ibuprofeno', 'L002', '2026-05-10', 'Cápsulas', '400 mg', 'MK', 'Cápsulas', 5),
(3, 2, 1, 'Amoxicilina', 'L003', '2026-06-01', 'Jarabe', '250 mg/5ml', 'La Santé', 'Jarabe', 2),
(4, 3, 2, 'Loratadina', 'L004', '2026-07-25', 'Pastillas', '10 mg', 'Tecnoquímicas', 'Tabletas', 6),
(5, 3, 2, 'Diclofenaco', 'L005', '2026-04-30', 'Inyectable', '75 mg', 'Bayer', 'Ampolla', 4),
(6, 4, NULL, 'Omeprazol', 'L006', '2026-08-10', 'Cápsulas', '20 mg', 'Genfar', 'Cápsulas', 3);
