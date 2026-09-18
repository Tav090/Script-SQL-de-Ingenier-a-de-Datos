-- ============================================================
-- VENTAS_TECH_DB
-- M4 - Consultas de Negocio (Adaptado para SQL Server)
-- Archivo: m4_consultas_negocio.sql
-- ============================================================

-- Consulta 1 — Resumen ejecutivo mensual
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2 — Ranking de productos (Top 5)
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3 — Clientes recurrentes
SELECT 
    id_cliente,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1
ORDER BY total_gastado DESC;

-- Consulta 4 — Meses por encima/por debajo del promedio
SELECT 
    resumen.mes,
    resumen.total_facturado,
    CASE 
        WHEN resumen.total_facturado > promedio_general.promedio_mensual THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento_vs_promedio
FROM (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS resumen
CROSS JOIN (
    SELECT AVG(total_mes) AS promedio_mensual
    FROM (
        SELECT SUM(cantidad * precio_unitario) AS total_mes
        FROM ventas
        GROUP BY MONTH(fecha_venta)
    ) AS sub
) AS promedio_general
ORDER BY resumen.mes;

-- ============================================================
-- Bloque de cierre: Hallazgos de negocio
-- ============================================================
-- 1. El id_producto 1 concentra la mayor fuerza comercial acumulando $3,600.00, lo que representa más del 56% de la facturación global de la empresa ($6,424.00).
-- 2. El mes 1 (Enero) registró el mayor pico de ventas de todo el periodo analizado con $2,540.00 facturados, ubicándose cómodamente 'Por encima' del promedio mensual general ($1,284.80).
-- 3. Todos los clientes registrados de manera activa (los 5 clientes existentes en la base) demostraron recurrencia absoluta al haber concretado exactamente 2 pedidos por persona.
