-- ============================================================
-- VENTAS_TECH_DB
-- M5 - Consultas con JOINs y UNIONs (Sintaxis SQL Server / T-SQL)
-- Archivo: m5_consultas_joins.sql
-- ============================================================

/*
INSERT INTO clientes VALUES (6, 'Roberto Gómez', 'roberto.gomez@email.com', 'Mendoza', '2024-06-01');
INSERT INTO clientes VALUES (7, 'Lucía Fernández', 'lucia.f@email.com', 'Buenos Aires', '2024-06-05');

INSERT INTO productos VALUES (7, 'Cámara Web HD', 2, 75.00, 15, 1);
INSERT INTO productos VALUES (8, 'Disco Duro Externo 2TB', 4, 110.00, 10, 1);
*/

-- ============================================================
-- 1. VISTA BASE DEL PROYECTO (INNER JOIN)
-- ============================================================
SELECT 
    v.fecha_venta AS fecha,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS region_cliente,
    p.nombre_producto AS descripcion_producto,
    cat.nombre_categoria AS categoria_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;


-- ============================================================
-- 2. CLIENTES SIN VENTAS (LEFT JOIN)
-- ============================================================
-- Identifica usuarios registrados en la plataforma CRM que nunca compraron.
SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ============================================================
-- 3. PRODUCTOS SIN VENTAS (LEFT JOIN)
-- ============================================================
-- Detecta artículos del catálogo que no tienen movimiento financiero (Stock inmovilizado).
SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- ============================================================
-- 4. CONSOLIDADO POR CANAL (UNION ALL)
-- ============================================================
-- Clasifica las ventas creando un canal literal basado en el volumen de unidades pedidas.
-- Estructura unificada mediante una tabla derivada para agrupar de forma correcta en SQL Server.
SELECT 
    vistas_unidas.canal,
    SUM(vistas_unidas.total) AS total_facturado,
    COUNT(*) AS cantidad_pedidos
FROM (
    -- Subconsulta 1: Canal Online (Pedidos minoristas de hasta 2 unidades)
    SELECT 
        fecha_venta AS fecha,
        (cantidad * precio_unitario) AS total,
        'Online' AS canal
    FROM ventas
    WHERE cantidad <= 2

    UNION ALL

    -- Subconsulta 2: Canal Presencial (Pedidos de volumen/corporativos mayores a 2 unidades)
    SELECT 
        fecha_venta AS fecha,
        (cantidad * precio_unitario) AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE cantidad > 2
) AS vistas_unidas
GROUP BY vistas_unidas.canal;
