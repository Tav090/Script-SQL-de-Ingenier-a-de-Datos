-- ============================================================================
-- PROYECTO FINAL: RETAILPRO
-- ============================================================================

USE RetailPro;
GO

-- 1. POBLAR TABLA: territorios
INSERT INTO territorios (id_territorio, region, pais, zona) VALUES
(1, 'Norte', 'Argentina', 'NOA'),
(2, 'Sur', 'Argentina', 'Patagonia'),
(3, 'Centro', 'Argentina', 'Pampeana'),
(4, 'Este', 'Uruguay', 'Metropolitana');
GO

-- 2. POBLAR TABLA: clientes
INSERT INTO clientes (id_cliente, nombre, email, ciudad, segmento, fecha_registro, id_territorio) VALUES
(101, 'Juan Pérez', 'juan.perez@email.com', 'Salta', 'Consumidor final', '2025-01-15', 1),
(102, 'Tech Solutions SRL', 'compras@techsolutions.com', 'Rosario', 'Corporativo', '2025-02-20', 3),
(103, 'María Inés López', 'maria.lopez@email.com', 'Bariloche', 'Consumidor final', '2025-03-05', 2),
(104, 'Global Distribuidora', 'info@globaldist.com', 'Montevideo', 'Corporativo', '2025-04-12', 4),
(105, 'Carlos Mendoza', 'carlos.mendoza@email.com', 'Tucumán', 'Consumidor final', '2025-05-18', 1);
GO

-- 3. POBLAR TABLA: productos
-- Nota: El "Teclado Mecánico Pro" de la categoría Accesorios tiene un costo alto respecto a su precio, simulando el problema de margen.
INSERT INTO productos (id_producto, nombre_producto, categoria, subcategoria, precio, costo) VALUES
(501, 'Laptop ThinkPad X1', 'Computadoras', 'Laptops', 1500.00, 1100.00),
(502, 'Monitor Ejecutivo 24', 'Pantallas', 'Monitores', 300.00, 210.00),
(503, 'Teclado Mecánico Pro', 'Accesorios', 'Periféricos', 80.00, 75.00), -- Margen muy bajo (Peligro)
(504, 'Disco Sólido Kingston 1TB', 'Almacenamiento', 'Discos Rígidos', 120.00, 80.00),
(505, 'Mouse Inalámbrico Ergo', 'Accesorios', 'Periféricos', 45.00, 20.00);
GO

-- 4. POBLAR TABLA: ventas
INSERT INTO ventas (id_venta, fecha_venta, id_cliente, id_producto, cantidad, total_venta, canal) VALUES
(1001, '2026-01-10', 101, 503, 10, 800.00, 'Online'),      -- Juan compra teclados en el Norte
(1002, '2026-01-15', 102, 501, 2, 3000.00, 'Presencial'),  -- Tech Solutions compra laptops en el Centro
(1003, '2026-02-01', 103, 502, 5, 1500.00, 'Online'),      -- María compra monitores en el Sur
(1004, '2026-02-18', 104, 504, 20, 2400.00, 'Presencial'), -- Global compra discos en Este
(1005, '2026-03-02', 105, 503, 15, 1200.00, 'Online'),     -- Carlos compra teclados en el Norte (Mucho volumen, poca ganancia)
(1006, '2026-03-15', 102, 505, 8, 360.00, 'Presencial');   -- Tech Solutions compra mouses en el Centro
GO

SELECT * FROM territorios;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
