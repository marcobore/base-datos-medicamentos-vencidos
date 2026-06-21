-- =========================================================
-- CRUD SOBRE LA TABLA RECOLECCION
-- =========================================================

-- CREATE: Crear una nueva recoleccion mediante procedimiento almacenado
CALL SP_REGISTRAR_RECOLECCION(
    1,
    1,
    1,
    '2026-07-25',
    2,
    'Operador CRUD',
    @nuevo_id_recoleccion
);

SELECT @nuevo_id_recoleccion AS Nueva_Recoleccion;


-- READ: Consultar la recoleccion creada
SELECT 
    ID_Recoleccion,
    ID_Hogar,
    ID_Punto,
    ID_Campana,
    Fecha_Evento,
    Cantidad_Total,
    Responsable_Ruta
FROM RECOLECCION
WHERE ID_Recoleccion = @nuevo_id_recoleccion;


-- UPDATE: Actualizar responsable y cantidad de la recoleccion
UPDATE RECOLECCION
SET Responsable_Ruta = 'Operador CRUD Actualizado',
    Cantidad_Total = 3
WHERE ID_Recoleccion = @nuevo_id_recoleccion;


-- READ posterior al UPDATE
SELECT 
    ID_Recoleccion,
    Fecha_Evento,
    Cantidad_Total,
    Responsable_Ruta
FROM RECOLECCION
WHERE ID_Recoleccion = @nuevo_id_recoleccion;


-- DELETE: Eliminar la recoleccion creada
DELETE FROM RECOLECCION
WHERE ID_Recoleccion = @nuevo_id_recoleccion;


-- READ posterior al DELETE
SELECT *
FROM RECOLECCION
WHERE ID_Recoleccion = @nuevo_id_recoleccion;
