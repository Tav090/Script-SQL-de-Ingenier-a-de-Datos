-- ============================================================
-- VENTAS_TECH_DB
-- M3 - Script SQL de Ingeniería de Datos
-- ============================================================

-- ============================================================
-- 1. DROP TABLES
-- ============================================================

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- ============================================================
-- 2. CREATE TABLES
-- ============================================================

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo TINYINT DEFAULT 1,
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL,
    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);

-- ============================================================
-- 3. INSERT DATA
-- ============================================================

-- Categorías
INSERT INTO categorias VALUES (1, 'Computación', 'Equipos informáticos');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Accesorios para computación');
INSERT INTO categorias VALUES (3, 'Audio', 'Productos de audio');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Dispositivos de almacenamiento');

-- Clientes
INSERT INTO clientes VALUES (1, 'María López', 'maria.lopez@email.com', 'Córdoba', '2024-01-15');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz', 'carlos.ruiz@email.com', 'Buenos Aires', '2024-02-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez', 'ana.gomez@email.com', 'Rosario', '2024-03-05');
INSERT INTO clientes VALUES (4, 'Pedro Sanz', 'pedro.sanz@email.com', 'Mendoza', '2024-04-12');
INSERT INTO clientes VALUES (5, 'Laura Torres', 'laura.torres@email.com', 'Córdoba', '2024-05-20');

-- Productos
INSERT INTO productos VALUES (1, 'Laptop Pro', 1, 1200.00, 20, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico', 2, 28.00, 50, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K', 1, 450.00, 15, 1);
INSERT INTO productos VALUES (4, 'Auriculares Bluetooth', 3, 120.00, 30, 1);
INSERT INTO productos VALUES (5, 'SSD Externo', 4, 130.00, 25, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico', 2, 90.00, 20, 1);

-- Ventas
INSERT INTO ventas VALUES (1, 1, 1, 2, 1200.00, '2024-01-10');
INSERT INTO ventas VALUES (2, 2, 2, 5, 28.00, '2024-01-15');
INSERT INTO ventas VALUES (3, 3, 3, 1, 450.00, '2024-02-05');
INSERT INTO ventas VALUES (4, 1, 4, 2, 120.00, '2024-02-18');
INSERT INTO ventas VALUES (5, 4, 5, 3, 130.00, '2024-03-02');
INSERT INTO ventas VALUES (6, 2, 6, 4, 90.00, '2024-03-15');
INSERT INTO ventas VALUES (7, 5, 1, 1, 1200.00, '2024-04-07');
INSERT INTO ventas VALUES (8, 3, 2, 8, 28.00, '2024-04-22');
INSERT INTO ventas VALUES (9, 4, 4, 1, 120.00, '2024-05-10');
INSERT INTO ventas VALUES (10, 5, 3, 2, 450.00, '2024-05-25');

-- Verificación
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
