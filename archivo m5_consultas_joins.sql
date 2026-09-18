-- ============================================================
-- VENTAS_TECH_DB
-- ============================================================

-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Esta consulta consolida la información necesaria para el posterior modelado en Power BI.
SELECT 
    v.fecha_venta AS fecha,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS region_cliente, -- Dimensión geográfica incluida en tu esquema de M3
    p.nombre_producto AS descripcion_producto,
    cat.nombre_categoria AS categoria_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;


-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Identifica clientes registrados en el sistema que aún no poseen transacciones.
SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Identifica artículos del catálogo que no registran movimientos de salida.
SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Clasifica de forma lógica el origen de las ventas según su volumen físico.
-- Nota: La columna 'canal' se genera dinámicamente como valor literal.
SELECT 
    sub.canal,
    SUM(sub.total_venta) AS total_facturado,
    SUM(sub.cantidad) AS total_unidades_vendidas
FROM (
    -- Simulación de Canal Mayorista: Ventas con volumen superior a 2 unidades
    SELECT 
        cantidad,
        (cantidad * precio_unitario) AS total_venta,
        'Mayorista' AS canal
    FROM ventas
    WHERE cantidad > 2

    UNION ALL

    -- Simulación de Canal Minorista: Ventas minoristas convencionales de hasta 2 unidades
    SELECT 
        cantidad,
        (cantidad * precio_unitario) AS total_venta,
        'Minorista' AS canal
    FROM ventas
    WHERE cantidad <= 2
) AS sub
GROUP BY sub.canal;
