-- Transacción para registrar una nueva recolección
-- y sus medicamentos asociados

START TRANSACTION;

INSERT INTO RECOLECCION (
    ID_Recoleccion,
    ID_Hogar,
    ID_Punto,
    ID_Campana,
    Fecha_Evento,
    Cantidad_Total,
    Responsable_Ruta
)
VALUES (
    5,
    2,
    1,
    1,
    '2026-07-20',
    4,
    'Operador Felipe Rojas'
);

INSERT INTO MEDICAMENTO (
    ID_Medicamento,
    ID_Recoleccion,
    ID_Disposicion,
    Nombre,
    Lote,
    Fecha_Vencimiento,
    Tipo_Farmaco,
    Concentracion,
    Laboratorio,
    Presentacion,
    Cantidad
)
VALUES (
    7,
    5,
    NULL,
    'Naproxeno',
    'L007',
    '2026-09-10',
    'Tabletas',
    '250 mg',
    'MK',
    'Tabletas',
    4
);

COMMIT;
