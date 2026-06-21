-- =========================================================
-- ARCHIVO: 02_consultas_validacion.sql
-- PROYECTO: Sistema de informacion para el control de medicamentos vencidos
-- MOTOR: MySQL / SQL Fiddle
-- DESCRIPCION: 15 consultas SQL de validacion del modelo relacional
-- =========================================================

-- Consulta 1: Medicamentos vencidos
SELECT 
    ID_Medicamento, 
    Nombre, 
    Lote, 
    Fecha_Vencimiento, 
    Tipo_Farmaco, 
    Cantidad
FROM MEDICAMENTO
WHERE Fecha_Vencimiento < CURDATE();


-- Consulta 2: Medicamentos proximos a vencer en los proximos 30 dias
SELECT 
    ID_Medicamento, 
    Nombre, 
    Lote, 
    Fecha_Vencimiento, 
    Tipo_Farmaco, 
    Cantidad
FROM MEDICAMENTO
WHERE Fecha_Vencimiento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);


-- Consulta 3: Medicamentos entregados por hogar o institucion
SELECT 
    h.Nombre_Responsable, 
    h.Municipio, 
    m.Nombre AS Medicamento, 
    m.Fecha_Vencimiento, 
    m.Cantidad
FROM HOGAR_INSTITUCION h
JOIN RECOLECCION r ON h.ID_Hogar = r.ID_Hogar
JOIN MEDICAMENTO m ON r.ID_Recoleccion = m.ID_Recoleccion;


-- Consulta 4: Medicamentos recolectados por punto seguro
SELECT 
    p.Nombre_Punto, 
    p.Municipio, 
    r.ID_Recoleccion, 
    m.Nombre AS Medicamento, 
    m.Cantidad
FROM PUNTO_SEGURO p
JOIN RECOLECCION r ON p.ID_Punto = r.ID_Punto
JOIN MEDICAMENTO m ON r.ID_Recoleccion = m.ID_Recoleccion;


-- Consulta 5: Cantidad total de medicamentos recolectados por municipio
SELECT 
    h.Municipio, 
    SUM(m.Cantidad) AS Total_Medicamentos
FROM HOGAR_INSTITUCION h
JOIN RECOLECCION r ON h.ID_Hogar = r.ID_Hogar
JOIN MEDICAMENTO m ON r.ID_Recoleccion = m.ID_Recoleccion
GROUP BY h.Municipio;


-- Consulta 6: Volumen total recolectado por campana
SELECT 
    c.Nombre_Campana, 
    SUM(r.Cantidad_Total) AS Total_Recolectado
FROM CAMPANA c
JOIN RECOLECCION r ON c.ID_Campana = r.ID_Campana
GROUP BY c.Nombre_Campana
ORDER BY Total_Recolectado DESC;


-- Consulta 7: Medicamentos con disposicion final certificada
SELECT 
    m.Nombre AS Medicamento, 
    d.Metodo_Destruccion, 
    d.Empresa_Certificada, 
    d.Numero_Certificado_Ambiental
FROM MEDICAMENTO m
JOIN DISPOSICION_FINAL d ON m.ID_Disposicion = d.ID_Disposicion;


-- Consulta 8: Recolecciones no asociadas a campana
SELECT 
    ID_Recoleccion, 
    Fecha_Evento, 
    Cantidad_Total, 
    Responsable_Ruta
FROM RECOLECCION
WHERE ID_Campana IS NULL;


-- Consulta 9: Puntos seguros con mayor volumen recibido
SELECT 
    p.Nombre_Punto, 
    SUM(r.Cantidad_Total) AS Total_Recibido
FROM PUNTO_SEGURO p
JOIN RECOLECCION r ON p.ID_Punto = r.ID_Punto
GROUP BY p.Nombre_Punto
ORDER BY Total_Recibido DESC;


-- Consulta 10: Trazabilidad completa de medicamentos
SELECT
    m.Nombre AS Medicamento,
    h.Nombre_Responsable AS Origen,
    h.Municipio,
    p.Nombre_Punto,
    c.Nombre_Campana,
    r.Fecha_Evento,
    d.Metodo_Destruccion,
    d.Empresa_Certificada,
    d.Numero_Certificado_Ambiental
FROM MEDICAMENTO m
JOIN RECOLECCION r ON m.ID_Recoleccion = r.ID_Recoleccion
JOIN HOGAR_INSTITUCION h ON r.ID_Hogar = h.ID_Hogar
JOIN PUNTO_SEGURO p ON r.ID_Punto = p.ID_Punto
LEFT JOIN CAMPANA c ON r.ID_Campana = c.ID_Campana
LEFT JOIN DISPOSICION_FINAL d ON m.ID_Disposicion = d.ID_Disposicion;


-- Consulta 11: Total de medicamentos por tipo de farmaco
SELECT 
    Tipo_Farmaco,
    SUM(Cantidad) AS Total_Por_Tipo
FROM MEDICAMENTO
GROUP BY Tipo_Farmaco
ORDER BY Total_Por_Tipo DESC;


-- Consulta 12: Medicamentos pendientes de disposicion final
SELECT 
    ID_Medicamento,
    Nombre,
    Lote,
    Fecha_Vencimiento,
    Cantidad
FROM MEDICAMENTO
WHERE ID_Disposicion IS NULL;


-- Consulta 13: Total de medicamentos recolectados por laboratorio
SELECT 
    Laboratorio,
    SUM(Cantidad) AS Total_Por_Laboratorio
FROM MEDICAMENTO
GROUP BY Laboratorio
ORDER BY Total_Por_Laboratorio DESC;


-- Consulta 14: Campanas con su periodo de ejecucion y numero de recolecciones
SELECT 
    c.Nombre_Campana,
    c.Fecha_Inicio,
    c.Fecha_Fin,
    COUNT(r.ID_Recoleccion) AS Numero_Recolecciones
FROM CAMPANA c
LEFT JOIN RECOLECCION r ON c.ID_Campana = r.ID_Campana
GROUP BY c.Nombre_Campana, c.Fecha_Inicio, c.Fecha_Fin
ORDER BY Numero_Recolecciones DESC;


-- Consulta 15: Capacidad maxima del punto seguro frente al volumen recibido
SELECT 
    p.Nombre_Punto,
    p.Municipio,
    p.Capacidad_Maxima,
    IFNULL(SUM(r.Cantidad_Total), 0) AS Total_Recibido,
    (p.Capacidad_Maxima - IFNULL(SUM(r.Cantidad_Total), 0)) AS Capacidad_Disponible
FROM PUNTO_SEGURO p
LEFT JOIN RECOLECCION r ON p.ID_Punto = r.ID_Punto
GROUP BY p.Nombre_Punto, p.Municipio, p.Capacidad_Maxima
ORDER BY Capacidad_Disponible ASC;
