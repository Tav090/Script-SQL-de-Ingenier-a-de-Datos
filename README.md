*README DATA ANALYTICS GUSTAVO DIAS*
# RetailPro — Sistema de Análisis Ejecutivo y Diagnóstico Comercial

Este repositorio contiene el desarrollo de extremo a extremo del sistema de análisis de datos para **RetailPro**, una empresa distribuidora de tecnología. El proyecto abarca desde el diseño y la normalización del modelo relacional en SQL Server, pasando por el proceso de carga de datos, hasta la optimización del modelo y cálculo de indicadores avanzados (DAX) en Power BI.

## 🎯 Pregunta Estratégica del Proyecto (Brief M1)
A diferencia de un reporte descriptivo convencional, este proyecto se estructuró bajo un enfoque analítico diagnóstico para responder a la siguiente problemática de negocio:
> **"¿Por qué el margen de ganancia de RetailPro cayó un 12% a nivel nacional durante el último semestre, y qué combinación de categorías de productos y territorios está impulsando esta pérdida?"**

---

## 🛠️ Tecnologías y Herramientas Utilizadas
*   **Motor de Base de Datos:** Microsoft SQL Server (SSMS) para la centralización, normalización (3NF) y almacenamiento de las transacciones.
*   **Herramienta BI:** Power BI Desktop para el modelado en estrella, analítica temporal y desarrollo del dashboard ejecutivo.
*   **Lenguajes:** T-SQL (Consultas y DDL) y DAX (Data Analysis Expressions para métricas de negocio).

---

## 📐 Arquitectura del Modelo de Datos (Esquema en Estrella)
El modelo de datos se diseñó bajo una arquitectura de tipo estrella para garantizar la velocidad en las consultas y el correcto filtrado unidireccional en Power BI:

*   **Fact_Ventas (Tabla de Hechos):** Almacena las métricas transaccionales (`cantidad`, `total_venta`, `canal`, `fecha_venta`).
*   **Dim_Clientes (Dimensión):** Información de los compradores (`segmento`, `ciudad`).
*   **Dim_Productos (Dimensión):** Catálogo con `precio`, `costo`, `categoria` y `subcategoria`.
*   **Dim_Categorias (Dimensión):** Jerarquía de productos.
*   **Dim_Fechas (Dimensión / Calendario):** Tabla temporal explícita marcada en Power BI para habilitar inteligencia de tiempo.

---

## 🚀 Instrucciones para la Implementación de la Base de Datos

### ⚠️Mucho muuuy Importante: Orden de Ejecución Obligatorio
Debido a las restricciones de integridad referencial y claves foráneas (`FOREIGN KEY`), los scripts de SQL Server deben ejecutarse en el siguiente orden estricto para evitar errores de compilación:

1.  **Creación de la base de datos e inicialización.**
2.  **Tabla `territorios`:** Debe existir primero ya que `Dim_Clientes` requiere su ID.
3.  **Tabla `Dim_Clientes`.**
4.  **Tabla `Dim_Productos`** (e inserción de categorías asociadas).
5.  **Tabla `Fact_Ventas`:** Se ejecuta al final de la arquitectura ya que depende de las dimensiones de clientes y productos.

*Nota: Los scripts optimizados con alias semánticos cortos y estructuras limpias se encuentran adjuntos en la carpeta correspondiente a la base de datos.*

---

## 📊 Librería de Medidas (DAX)
El modelo analítico cuenta con un contenedor dedicado exclusivamente a métricas lógicas bajo la tabla `_Medidas`, las cuales eliminan la redundancia y optimizan el rendimiento del motor *VertiPaq*:

1.  **`Total Ventas`:** `SUM(Fact_Ventas[total_venta])` - Base de recaudación monetaria.
2.  **`Ventas Online`:** Segmentación específica mediante `CALCULATE` para aislar el rendimiento del canal web.
3.  **`Ventas YTD`:** Cálculo de acumulado anual utilizando la función `TOTALYTD` mapeada contra nuestra dimensión de fechas activa.
4.  **`Ventas LY`:** Desplazamiento temporal con `SAMEPERIODLASTYEAR` para auditar el rendimiento del período equivalente del año anterior.
5.  **`% Crecimiento Anual`:** Medida avanzada optimizada con variables (`VAR`) y la función segura `DIVIDE` para prevenir errores de división por cero y acelerar los tiempos de procesamiento visual.

---

## 👥 Autor 
*   **Gustavo Dias** 
