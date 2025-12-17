CREATE SCHEMA proyecto_Valdez;
USE proyecto_Valdez;

-- creación de tablas

CREATE TABLE tipo_producto (
    id_tipo_producto INT PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL,
    descripcion VARCHAR(50)
);

CREATE TABLE tipo_cliente (
    id_tipo_cliente INT PRIMARY KEY,
    desc_cliente VARCHAR(20) NOT NULL
);

CREATE TABLE ciudad (
    id_ciudad INT PRIMARY KEY,
    nombre_ciudad VARCHAR(30),
    departamento VARCHAR(30)
);

CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    razon_social VARCHAR(40),
    documento VARCHAR(20),
    direccion VARCHAR(40),
    telefono VARCHAR(20),
    email VARCHAR(40)
);

CREATE TABLE insumos (
    id_insumo INT PRIMARY KEY,
    desc_insumo VARCHAR(30)
);

CREATE TABLE producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(40) NOT NULL,
    id_tipo_producto INT NOT NULL,
    descripcion_producto VARCHAR(60),
    precio_producto DECIMAL(10,2),
    personalizado VARCHAR(2),
    CONSTRAINT fk_producto_tipo
        FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id_tipo_producto)
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    cliente VARCHAR(40) NOT NULL,
    id_tipo_cliente INT NOT NULL,
    documento VARCHAR(20),
    direccion VARCHAR(60),
    telefono VARCHAR(20),
    email VARCHAR(40),
    CONSTRAINT fk_cliente_tipo
        FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_cliente(id_tipo_cliente)
);

CREATE TABLE pedido_compra (
    id_pedido_compra INT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_proveedor INT NOT NULL,
    id_ciudad INT NOT NULL,
    gastos DECIMAL(8,2),
    CONSTRAINT fk_pc_proveedor
        FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    CONSTRAINT fk_pc_ciudad
        FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE detalle_compra (
    id_pedido_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2),
    PRIMARY KEY (id_pedido_compra, id_producto),
    CONSTRAINT fk_dc_pedido
        FOREIGN KEY (id_pedido_compra) REFERENCES pedido_compra(id_pedido_compra),
    CONSTRAINT fk_dc_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE detalle_compra_insumo (
    id_pedido_compra INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad INT,
    precio DECIMAL(10,2),
    PRIMARY KEY (id_pedido_compra, id_insumo),
    CONSTRAINT fk_dci_pedido
        FOREIGN KEY (id_pedido_compra) REFERENCES pedido_compra(id_pedido_compra),
    CONSTRAINT fk_dci_insumo
        FOREIGN KEY (id_insumo) REFERENCES insumos(id_insumo)
);

CREATE TABLE pedido_venta (
    id_pedido_venta INT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_ciudad INT NOT NULL,
    CONSTRAINT fk_pv_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_pv_ciudad
        FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE detalle_venta (
    id_pedido_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cant_venta INT NOT NULL,
    precio_venta DECIMAL(10,2),
    PRIMARY KEY (id_pedido_venta, id_producto),
    CONSTRAINT fk_dv_pedido
        FOREIGN KEY (id_pedido_venta) REFERENCES pedido_venta(id_pedido_venta),
    CONSTRAINT fk_dv_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Insertar datos

INSERT INTO tipo_cliente VALUES
(1,'Mayorista'),
(2,'Minorista'),
(3,'Personal');

INSERT INTO tipo_producto VALUES
(1,'Agenda','Agenda 2026 A5'),
(2,'Libreta','Libretas de 100 hojas A5'),
(3,'Planner Semanal','Planner semanal sin fechas'),
(4,'Planner Diario','Planner diario sin fechas');

INSERT INTO ciudad VALUES
(1,'Montevideo','Montevideo'),
(2,'Punta del Este','Maldonado'),
(3,'Salto','Salto'),
(4,'Paysandú','Paysandú'),
(5,'Maldonado','Maldonado'),
(6,'Las Piedras','Canelones'),
(7,'Durazno','Durazno'),
(8,'Pando','Canelones');

INSERT INTO proveedor VALUES
(1,'Papeles SRL','Papeles SRL','214578230019','Arenal Grande 1234','24001234','ventas@papeles.com'),
(2,'Graficas Sur','Graficas Sur SA','211234560012','Galicia 1551','24007890','contacto@grafsur.com'),
(3,'Insumos del Este','Insumos del Este','219876540011','Camino al Cerro 300','42251234','info@inseste.com'),
(4,'Cartonera UY','Cartonera Uruguay SA','213459870017','Ruta 8 KM 17','23451234','ventas@cartonera.com'),
(5,'Tintas UY','Tintas Uruguay','215678990016','San José 850','29011234','contacto@tintauy.com');

INSERT INTO insumos VALUES
(1,'Papel Liso'),
(2,'Papel Rayado'),
(3,'Cartón'),
(4,'Láminas'),
(5,'Rulos'),
(6,'Tinta');

INSERT INTO producto (nombre_producto,id_tipo_producto,descripcion_producto,precio_producto,personalizado) VALUES
('Agenda 2026',1,'Agenda estándar',400,'NO'),
('Agenda Premium 2026',1,'Agenda tapa dura',550,'SI'),
('Cuaderno A4 Rayado',2,'80 hojas rayadas',180,'NO'),
('Cuaderno A4 Cuadriculado',2,'80 hojas cuadriculadas',220,'NO'),
('Planner Semanal',3,'Semana a la vista',300,'NO'),
('Planner Diario',4,'Día por página',350,'NO'),
('Agenda Corporativa',1,'Personalizable empresas',680,'SI'),
('Libreta A5 Rayada',2,'100 hojas A5',150,'NO'),
('Libreta A5 Lisa',2,'100 hojas A5 lisa',150,'NO'),
('Planner Docente',3,'Uso docente',380,'SI'),
('Agenda Escolar',1,'Agenda escolar',250,'NO'),
('Cuaderno Bullet',2,'Bullet journal',320,'SI'),
('Planner Mensual',3,'Vista mensual',290,'NO'),
('Agenda Minimalista',1,'Diseño minimalista',480,'NO'),
('Libreta Recetario',2,'Recetario cocina',260,'SI');

INSERT INTO cliente (cliente,id_tipo_cliente,documento,direccion,telefono,email) VALUES
('Librería Central',2,'21456789','18 de Julio 1123','24001111','central@libros.com'),
('OfiMax',1,'21234567','Colonia 1450','29005555','ventas@ofimax.com'),
('Ana López',3,'48951236','Pocitos','097123456','ana@gmail.com'),
('Mercería Sol',2,'25689123','Rivera 1245','24007890','sol@merceria.com'),
('Estudio Ríos',1,'21567895','Ciudad Vieja 325','29115522','contacto@rios.com'),
('Lucía Pérez',3,'51234987','Malvín Norte 444','099876543','lucia@gmail.com'),
('Papelería Norte',2,'29874563','Av. Italia 4550','26001234','norte@papeleria.com'),
('Juan Fernández',3,'47896512','Centro','098445566','juan@gmail.com');

INSERT INTO pedido_venta VALUES
(1,'2025-02-10',1,1),
(2,'2025-02-11',3,8),
(3,'2025-02-12',2,6),
(4,'2025-02-15',4,5),
(5,'2025-02-20',6,1),
(6,'2025-02-25',7,1),
(7,'2025-02-27',8,3);

INSERT INTO detalle_venta VALUES
(1,1,5,400),
(1,2,2,550),
(2,3,10,180),
(2,5,4,300),
(3,7,3,680),
(4,8,20,150),
(5,11,15,250),
(6,4,12,220),
(7,14,6,480);

-- validacion tablas
select*from producto;
select*from ciudad;
select*from proveedor;


-- creacion de VISTAS

	-- ver productos
CREATE VIEW vw_productos_detalle AS
SELECT p.id_producto, p.nombre_producto, tp.tipo, p.precio_producto, p.personalizado
FROM producto p
JOIN tipo_producto tp ON p.id_tipo_producto = tp.id_tipo_producto;
	
	-- ventas a cliente
CREATE VIEW vw_ventas_cliente AS
SELECT pv.id_pedido_venta, pv.fecha, c.cliente, ci.nombre_ciudad
FROM pedido_venta pv
JOIN cliente c ON pv.id_cliente = c.id_cliente
JOIN ciudad ci ON pv.id_ciudad = ci.id_ciudad;
	
	-- detalle de ventas
CREATE VIEW vw_detalle_ventas AS
SELECT dv.id_pedido_venta, p.nombre_producto,
       dv.cant_venta, dv.precio_venta,
       (dv.cant_venta * dv.precio_venta) AS subtotal
FROM detalle_venta dv
JOIN producto p ON dv.id_producto = p.id_producto;


-- creacion FUNCIONES
	-- total de venta
DELIMITER //

CREATE FUNCTION fn_total_venta(p_id_venta INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(cant_venta * precio_venta),0)
    INTO total
    FROM detalle_venta
    WHERE id_pedido_venta = p_id_venta;
    RETURN total;
END//
	
	-- precio promedio
CREATE FUNCTION fn_precio_promedio()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(precio_producto) INTO promedio FROM producto;
    RETURN promedio;
END//

DELIMITER ;


-- creacion STORED PROCEDURES
	-- ventas por cliente	
DELIMITER //

CREATE PROCEDURE sp_ventas_por_cliente(IN p_id_cliente INT)
BEGIN
    SELECT pv.id_pedido_venta, pv.fecha,
           fn_total_venta(pv.id_pedido_venta) AS total_venta
    FROM pedido_venta pv
    WHERE pv.id_cliente = p_id_cliente;
END//
-- insertar nuevo cliente
CREATE PROCEDURE sp_insertar_cliente(
    IN p_cliente VARCHAR(30),
    IN p_id_tipo_cliente INT,
    IN p_documento VARCHAR(20),
    IN p_direccion VARCHAR(40),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(30)
)
BEGIN
    INSERT INTO cliente
    (cliente,id_tipo_cliente,documento,direccion,telefono,email)
    VALUES
    (p_cliente,p_id_tipo_cliente,p_documento,p_direccion,p_telefono,p_email);
END//

DELIMITER ;


-- TRIGGERS
	-- precios mayores a 0
DELIMITER //

CREATE TRIGGER trg_precio_producto_insert
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF NEW.precio_producto <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio debe ser mayor a 0';
    END IF;
END//

CREATE TRIGGER trg_precio_producto_update
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
    IF NEW.precio_producto <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio debe ser mayor a 0';
    END IF;
END//

DELIMITER ;

-- ====================================================================================================
-- segundo script con insercion de datos + validacion vistas, funciones, stored procedures y triggers 
-- ====================================================================================================

USE proyecto_Valdez;

-- insercion de datos

INSERT INTO pedido_compra (id_pedido_compra, fecha, id_proveedor, id_ciudad, gastos)
VALUES
(6, '2025-02-05', 1, 1, 1200.00),
(7, '2025-02-08', 2, 5, 980.50),
(8, '2025-02-12', 3, 2, 1750.00);

INSERT INTO detalle_compra (id_pedido_compra, id_producto, cantidad, precio)
VALUES
(6, 1, 40, 260.00),
(6, 3, 60, 160.00),
(7, 5, 30, 210.00),
(7, 8, 50, 120.00),
(8, 10, 25, 300.00);

INSERT INTO detalle_compra_insumo (id_pedido_compra, id_insumo, cantidad, precio)
VALUES
(6, 1, 100, 35.00),
(6, 6, 20, 150.00),
(7, 2, 80, 40.00),
(8, 3, 60, 55.00),
(8, 6, 25, 145.00);

INSERT INTO pedido_venta (id_pedido_venta, fecha, id_cliente, id_ciudad)
VALUES
(8, '2025-03-01', 1, 1),
(9, '2025-03-02', 2, 6),
(10, '2025-03-03', 3, 1),
(11, '2025-03-05', 4, 5),
(12,'2025-03-06', 5, 1);

INSERT INTO detalle_venta (id_pedido_venta, id_producto, cant_venta, precio_venta)
VALUES
(6, 1, 10, 400.00),
(6, 2, 5, 550.00),
(7, 3, 20, 180.00),
(7, 4, 15, 220.00),
(8, 5, 8, 300.00),
(8, 6, 6, 350.00),
(9, 8, 25, 150.00),
(9, 11, 10, 250.00),
(10, 14, 5, 480.00);


-- prueba de vistas de producto y ventas
SELECT * FROM vw_productos_detalle;

SELECT * FROM vw_detalle_ventas;

-- prueba de funciones
SELECT fn_total_venta(6) AS total_venta_pedido_6;

SELECT fn_precio_promedio() AS precio_promedio;

-- Stored procedure
CALL sp_ventas_por_cliente(1);

-- Prueba de trigger (deberia fallar el insert porque precio es menor a 0)
INSERT INTO producto (nombre_producto, id_tipo_producto, descripcion_producto, precio_producto, personalizado)
VALUES ('Producto prueba', 1, 'Error de precio', -50, 'NO');
