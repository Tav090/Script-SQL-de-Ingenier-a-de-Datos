-- 1. Creamos la tabla temporal de prueba
CREATE TABLE ventas_semana (
    sucursal VARCHAR(50),
    venta DECIMAL(10,2)
);

-- 2. Insertamos para Norte y Sur
INSERT INTO ventas_semana (sucursal, venta) VALUES
('Norte', 500), ('Norte', 510), ('Norte', 490), ('Norte', 505), ('Norte', 495),
('Sur', 100), ('Sur', 900), ('Sur', 50), ('Sur', 1200), ('Sur', 250);

-- 3. Consulta de Media y Rango
SELECT
  sucursal,
  AVG(venta)              AS media,
  MAX(venta) - MIN(venta) AS rango
FROM ventas_semana
GROUP BY sucursal;
SELECT
  sucursal,
  STDEV(venta) AS desvio_muestral
FROM ventas_semana
GROUP BY sucursal;
SELECT DISTINCT
  AVG(total_venta) OVER() AS media,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_venta) OVER() AS mediana
FROM dbo.ventas;

-- 4. Outliers con el método IQR (Parte 2b)

WITH q AS (
  SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_venta) OVER() AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_venta) OVER() AS q3
  FROM dbo.ventas
)
SELECT v.*
FROM dbo.ventas v
CROSS JOIN q
WHERE v.total_venta > (q.q3 + 1.5 * (q.q3 - q.q1));