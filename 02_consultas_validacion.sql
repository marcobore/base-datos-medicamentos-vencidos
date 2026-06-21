-- Consulta 1: Medicamentos vencidos
SELECT ID_Medicamento, Nombre, Lote, Fecha_Vencimiento, Tipo_Farmaco, Cantidad
FROM MEDICAMENTO
WHERE Fecha_Vencimiento < CURDATE();

-- Consulta 2: Medicamentos próximos a vencer
SELECT ID_Medicamento, Nombre, Lote, Fecha_Vencimiento, Tipo_Farmaco, Cantidad
FROM MEDICAMENTO
WHERE Fecha_Vencimiento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- Consulta 3: Medicamentos entregados por hogar
SELECT h.Nombre_Responsable, h.Municipio, m.Nombre AS Medicamento, m.Fecha_Vencimiento, m.Cantidad
FROM HOGAR_INSTITUCION h
JOIN RECOLECCION r ON h.ID_Hogar = r.ID_Hogar
JOIN MEDICAMENTO m ON r.ID_Recoleccion = m.ID_Recoleccion;

-- Consulta 4: Medicamentos recolectados por punto seguro
SELECT p.Nombre_Punto, p.Municipio, r.ID_Recoleccion, m.Nombre AS Medicamento, m.Cantidad
FROM PUNTO_SEGURO p
JOIN RECOLECCION r ON p.ID_Punto = r.ID_Punto
JOIN MEDICAMENTO m ON r.ID_Recoleccion = m.ID_Recoleccion;

-- Consulta 5: Cantidad total por municipio
SELECT h.Municipio, SUM(m.Cantidad) AS Total_Medicamentos
FROM HOGAR_INSTITUCION h
JOIN RECOLECCION r ON h.ID_Hogar = r.ID_Hogar
JOIN MEDICAMENTO m ON r.ID_Recoleccion = m.ID_Recoleccion
GROUP BY h.Municipio;

-- Consulta 6: Volumen por campaña
SELECT c.Nombre_Campana, SUM(r.Cantidad_Total) AS Total_Recolectado
FROM CAMPANA c
JOIN RECOLECCION r ON c.ID_Campana = r.ID_Campana
GROUP BY c.Nombre_Campana
ORDER BY Total_Recolectado DESC;

-- Consulta 7: Disposición final certificada
SELECT m.Nombre AS Medicamento, d.Metodo_Destruccion, d.Empresa_Certificada, d.Numero_Certificado_Ambiental
FROM MEDICAMENTO m
JOIN DISPOSICION_FINAL d ON m.ID_Disposicion = d.ID_Disposicion;

-- Consulta 8: Recolecciones sin campaña
SELECT ID_Recoleccion, Fecha_Evento, Cantidad_Total, Responsable_Ruta
FROM RECOLECCION
WHERE ID_Campana IS NULL;

-- Consulta 9: Puntos seguros con mayor volumen
SELECT p.Nombre_Punto, SUM(r.Cantidad_Total) AS Total_Recibido
FROM PUNTO_SEGURO p
JOIN RECOLECCION r ON p.ID_Punto = r.ID_Punto
GROUP BY p.Nombre_Punto
ORDER BY Total_Recibido DESC;

-- Consulta 10: Trazabilidad completa
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
