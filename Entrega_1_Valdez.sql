create schema proyecto_Valdez

-- creacion de tablas
create table producto (
id_producto INT PRIMARY KEY NOT NULL,
nombre_producto varchar(20) NOT NULL,
id_tipo_producto INT NOT NULL,
descripcion_producto varchar (30) NOT NULL,
precio_producto decimal(10,2), 
personalizado varchar (2),
CONSTRAINT fk_producto_tipo
        FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id_tipo_producto)
);

create table tipo_cliente (
id_tipo_cliente int primary key not null,
desc_cliente varchar(20) not null
);

create table cliente (
id_cliente int primary key not null,
cliente varchar(20) NOT NULL,
id_tipo_cliente int not null,
documento varchar (20),
direccion varchar (40),
telefono varchar (20),
email varchar (30),
    CONSTRAINT fk_cliente_tipo
        FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_cliente(id_tipo_cliente)
);

create table proveedor (
id_proveedor int primary key not null,
nombre varchar(20) not null,
razon_social varchar (20),
documento varchar (20),
direccion varchar (20),
telefono varchar (20),
email varchar (20)
);

create table ciudad (
id_ciudad int primary key not null,
nombre_ciudad varchar (30),
departamento varchar (30)
);

create table insumos (
id_insumo int primary key not null,
desc_insumo varchar (30)
);

create table pedido_compra (
id_pedido_compra int primary key not null,
fecha date NOT NULL,
id_proveedor int not null,
id_ciudad int not null,
id_insumo int not null,
gastos decimal (8,2) not null,
CONSTRAINT fk_compra_proveedor
        FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    CONSTRAINT fk_compra_ciudad
        FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad),
    CONSTRAINT fk_compra_insumo
        FOREIGN KEY (id_insumo) REFERENCES insumos(id_insumo)
);

create table detalle_compra (
id_pedido_compra int primary key not null,
id_producto int not null,
cantidad int not null,
precio decimal (10,2),
  CONSTRAINT fk_det_compra_pedido
        FOREIGN KEY (id_pedido_compra) REFERENCES pedido_compra(id_pedido_compra),
    CONSTRAINT fk_det_compra_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

create table pedido_venta (
id_pedido_venta int primary key not null,
fecha date not null,
id_cliente int not null,
id_ciudad int not null,
CONSTRAINT fk_venta_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_venta_ciudad
        FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

create table detalle_venta (
id_pedido_venta int not null,
id_producto int not null,
cant_venta int not null,
precio_venta decimal (10,2),
  PRIMARY KEY (id_pedido_venta, id_producto),
    CONSTRAINT fk_det_venta_pedido
        FOREIGN KEY (id_pedido_venta) REFERENCES pedido_venta(id_pedido_venta),
    CONSTRAINT fk_det_venta_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);


-- relleno de tablas

Insert into tipo_cliente (id_tipo_cliente, desc_cliente)
values 
(1, "Mayorista"),
(2, "Minorista"),
(3, "Personal");


Insert into insumos (id_insumo, desc_insumo)
values (1, "Papel Liso"),
(2, "Papel Rayado"),
(3, "Carton"),
(4, "Laminas"),
(5, "Rulos"),
(6, "Tinta");



Insert into tipo_producto (id_tipo_producto, tipo, descripcion)
values 
(1, "Agenda", "Agenda 2026 A5"),
(2, "Libreta", "Libretas de 100 hojas A5"),
(3, "Planner Semanal", "Planner Semanal sin fechas A5"),
(4, "Planner Diario", "Planner Diario sin fechas A5") ;



INSERT INTO producto (id_producto, nombre_producto, id_tipo_producto, descripcion_producto, precio_producto, personalizado)
VALUES 
(1, "Agenda 2026", 1, "Agenda estandar", 400, "NO"),
(2, "Agenda Premium 2026", 1, "Agenda tapa dura", 550, "SI"),
(3, "Cuaderno A4 Rayado", 2, "80 hojas rayadas", 180, "NO"),
(4, "Cuaderno A4 Cuadric", 2, "80 hojas cuadriculadas", 220, "NO"),
(5, "Planner Semanal", 3, "Semana a la vista", 300, "NO"),
(6, "Planner Diario", 4, "Día por página", 350, "NO"),
(7, "Agenda Corporativa", 1, "Agenda personalizable empresa", 680, "SI"),
(8, "Libreta A5 Rayada", 2, "100 hojas A5", 150, "NO"),
(9, "Libreta A5 Lisa", 2, "100 hojas A5 lisas", 150, "NO"),
(10, "Planner Docente", 3, "Organización semanal docente", 380, "SI"),
(11, "Agenda Escolar", 1, "Agenda escolar básica", 250, "NO"),
(12, "Cuaderno A5 Bullet", 2, "Estilo bullet journal", 320, "SI"),
(13, "Planner Mensual", 3, "Vista mensual completa", 290, "NO"),
(14, "Agenda Minimalista", 1, "Agenda diseño minimalista", 480, "NO"),
(15, "Libreta Recetario", 2, "Recetario para cocina", 260, "SI");

INSERT INTO ciudad (id_ciudad, nombre_ciudad, departamento)
VALUES
(1, "Montevideo", "Montevideo"),
(2, "Punta del Este", "Maldonado"),
(3, "Salto", "Salto"),
(4, "Paysandú", "Paysandú"),
(5, "Maldonado", "Maldonado"),
(6, "Las Piedras", "Canelones"),
(7, "Durazno", "Durazno"),
(8, "Pando", "Canelones");

INSERT INTO proveedor (id_proveedor, nombre, razon_social, documento, direccion, telefono, email)
VALUES
(1, "Papeles SRL", "Papeles SRL", "214578230019", "Arenal Grande 1234", "24001234", "ventas@papeles.com"),
(2, "Graficas Sur", "Graficas Sur SA", "211234560012", "Galicia 1551", "24007890", "contacto@grafsur.com"),
(3, "Insumos del Este", "Insumos del Este", "219876540011", "Camino al Cerro 300", "42251234", "info@inseste.com"),
(4, "Cartonera UY", "Cartonera Uruguay SA", "213459870017", "Ruta 8 KM 17", "23451234", "ventas@cartonera.com"),
(5, "Tintas UY", "Tintas Uruguay", "215678990016", "San José 850", "29011234", "contacto@tintauy.com");

INSERT INTO cliente (id_cliente, cliente, id_tipo_cliente, documento, direccion, telefono, email)
VALUES
(1, "Librería Central", 2, "21456789", "18 de Julio 1123", "24001111", "central@libros.com"),
(2, "OfiMax", 1, "21234567", "Colonia 1450", "29005555", "ventas@ofimax.com"),
(3, "Ana López", 3, "48951236", "Pocitos 2333", "097123456", "ana@gmail.com"),
(4, "Mercería Sol", 2, "25689123", "Rivera 1245", "24007890", "sol@merceria.com"),
(5, "Estudio Ríos", 1, "21567895", "Ciudad Vieja 325", "29115522", "contacto@rios.com"),
(6, "Lucía Pérez", 3, "51234987", "Malvín Norte 444", "099876543", "lucia@gmail.com");

INSERT INTO pedido_compra (id_pedido_compra, fecha, id_proveedor, id_ciudad, id_insumo, gastos)
VALUES
(1, '2025-01-10', 1, 1, 1, 1500.00),
(2, '2025-01-15', 2, 1, 2, 1800.50),
(3, '2025-01-20', 3, 2, 4, 2200.00),
(4, '2025-01-22', 4, 6, 3, 1300.75),
(5, '2025-02-01', 5, 1, 6, 950.00);

INSERT INTO detalle_compra (id_pedido_compra, id_producto, cantidad, precio)
VALUES
(1, 1, 50, 250.00),
(2, 2, 40, 300.00),
(3, 5, 60, 200.00),
(4, 3, 30, 100.00),
(5, 4, 20, 150.00);

INSERT INTO pedido_venta (id_pedido_venta, fecha, id_cliente, id_ciudad)
VALUES
(1, '2025-02-10', 1, 1),
(2, '2025-02-11', 3, 8),
(3, '2025-02-12', 2, 6),
(4, '2025-02-15', 4, 5),
(5, '2025-02-20', 6, 1);

-- validacion tablas
select*from producto
select*from ciudad
select*from proveedor
