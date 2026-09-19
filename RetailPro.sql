-- ============================================================================
-- RETAILPRO
-- ============================================================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'RetailPro')
BEGIN
    -- Forzamos el cierre de conexiones abiertas para que no se bloquee el borrado
    ALTER DATABASE RetailPro SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RetailPro;
END
GO

CREATE DATABASE RetailPro;
GO

-- Activamos el uso de la base de datos recién creada
USE RetailPro;
GO


-- 2. CREACIÓN DE LA TABLA: territorios
-- Debe crearse primero porque la tabla 'clientes' depende de ella (Clave Foránea)
CREATE TABLE territorios (
    id_territorio INT NOT NULL,
    region VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    zona VARCHAR(100) NOT NULL,
    CONSTRAINT PK_territorios PRIMARY KEY (id_territorio)
);
GO


-- 3. CREACIÓN DE LA TABLA: clientes
-- Almacena maestros de compradores y se vincula con la tabla territorios
CREATE TABLE clientes (
    id_cliente INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    segmento VARCHAR(50) NOT NULL, -- Corporativo, Consumidor final, etc.
    fecha_registro DATE NOT NULL,
    id_territorio INT NOT NULL,
    CONSTRAINT PK_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT FK_clientes_territorios FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);
GO


-- 4. CREACIÓN DE LA TABLA: productos
-- Catálogo de tecnología. Se usa DECIMAL(10,2) para no perder precisión en dinero
CREATE TABLE productos (
    id_producto INT NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    subcategoria VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_productos PRIMARY KEY (id_producto)
);
GO


-- 5. CREACIÓN DE LA TABLA: ventas
-- Tabla de hechos (transacciones). Depende de clientes y productos.
CREATE TABLE ventas (
    id_venta INT NOT NULL,
    fecha_venta DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,
    canal VARCHAR(50) NOT NULL, -- Online, Presencial, etc.
    CONSTRAINT PK_ventas PRIMARY KEY (id_venta),
    CONSTRAINT FK_ventas_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT FK_ventas_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
GO
