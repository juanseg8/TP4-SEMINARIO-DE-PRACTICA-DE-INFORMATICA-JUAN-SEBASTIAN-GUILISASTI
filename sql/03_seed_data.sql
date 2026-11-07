-- StockFlow - Datos de prueba
-- Escenario consistente con el prototipo JavaFX y los casos CP01/CP03.

USE stockflow_db;

INSERT INTO rol (nombre, descripcion) VALUES
('ADMINISTRADOR', 'Gestiona usuarios, roles, sucursales, productos y configuraciones.'),
('ENCARGADO_SUCURSAL', 'Opera y consulta información de una o más sucursales asignadas.'),
('RESPONSABLE_INVENTARIO_COMPRAS', 'Consulta información consolidada y decide sobre recomendaciones.');

INSERT INTO sucursal (nombre, direccion) VALUES
('Centro', 'Av. Central 100'),
('Norte', 'Av. Norte 250'),
('Sur', 'Av. Sur 300'),
('Oeste', 'Av. Oeste 450'),
('Deposito Central', 'Ruta Provincial 5 Km 10');

INSERT INTO usuario (id_rol, nombre, usuario, clave_hash, email) VALUES
((SELECT id_rol FROM rol WHERE nombre = 'ADMINISTRADOR'),
 'Administrador StockFlow', 'admin', '210000$h54Z9EgQjIqYf07UOOJw4Q==$EdYhK/odTnCz0b6y/i+ekYUmy4ArQHfsnWXO7qJxnks=', 'admin@delta.local'),
((SELECT id_rol FROM rol WHERE nombre = 'ENCARGADO_SUCURSAL'),
 'Encargado Centro', 'encargado.centro', '210000$5540WKGL6NX0tGbTkidolw==$4RdICyIR3S+l/nx3wk/t20dNexOeI/Ptx0tmjW7ciAY=', 'centro@delta.local'),
((SELECT id_rol FROM rol WHERE nombre = 'RESPONSABLE_INVENTARIO_COMPRAS'),
 'Responsable de Inventario y Compras', 'compras', '210000$cutMYvIahXxee+JbyLJapg==$AKWDc1RuPBrj6tr3rxeUkMitHjd5co6uv1Q6+yvZnSc=', 'compras@delta.local');

INSERT INTO usuario_sucursal (id_usuario, id_sucursal)
SELECT u.id_usuario, s.id_sucursal
FROM usuario u
JOIN sucursal s ON s.nombre IN ('Centro', 'Norte', 'Sur', 'Oeste', 'Deposito Central')
WHERE u.usuario = 'compras';

INSERT INTO usuario_sucursal (id_usuario, id_sucursal)
SELECT u.id_usuario, s.id_sucursal
FROM usuario u
JOIN sucursal s ON s.nombre = 'Centro'
WHERE u.usuario = 'encargado.centro';

INSERT INTO categoria (nombre, descripcion) VALUES
('Herramientas electricas', 'Herramientas accionadas electricamente.'),
('Herramientas manuales', 'Herramientas de uso manual.'),
('Medicion', 'Instrumentos de medicion.'),
('Seguridad industrial', 'Elementos de proteccion personal e indumentaria tecnica.'),
('Fijaciones e insumos', 'Tornilleria, anclajes y consumibles de taller.');

INSERT INTO producto (id_categoria, codigo, nombre, descripcion) VALUES
((SELECT id_categoria FROM categoria WHERE nombre = 'Herramientas electricas'),
 'TAL-001', 'Taladro Percutor', 'Taladro percutor de uso general.'),
((SELECT id_categoria FROM categoria WHERE nombre = 'Herramientas manuales'),
 'MAR-001', 'Martillo Galponero', 'Martillo para trabajos generales.'),
((SELECT id_categoria FROM categoria WHERE nombre = 'Herramientas electricas'),
 'SIE-001', 'Sierra Circular', 'Sierra circular electrica.'),
((SELECT id_categoria FROM categoria WHERE nombre = 'Medicion'),
 'CIN-001', 'Cinta Metrica 5m', 'Cinta metrica de cinco metros.'),
((SELECT id_categoria FROM categoria WHERE nombre = 'Herramientas electricas'),
 'AMO-001', 'Amoladora Angular', 'Amoladora angular de 115mm 850W.'),
((SELECT id_categoria FROM categoria WHERE nombre = 'Herramientas manuales'),
 'DES-001', 'Set de Destornilladores', 'Juego de 6 destornilladores con punta imantada.'),
((SELECT id_categoria FROM categoria WHERE nombre = 'Seguridad industrial'),
 'CAS-001', 'Casco de Seguridad', 'Casco dielectrico con arnes regulable.'),
((SELECT id_categoria FROM categoria WHERE nombre = 'Herramientas manuales'),
 'LLI-001', 'Llave Inglesa 10p', 'Llave ajustable de acero cromo vanadio.');

-- Inventario de Taladro Percutor
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 8, 15, 30
FROM producto p JOIN sucursal s ON s.nombre = 'Centro'
WHERE p.codigo = 'TAL-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 48, 15, 30
FROM producto p JOIN sucursal s ON s.nombre = 'Norte'
WHERE p.codigo = 'TAL-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 18, 10, 30
FROM producto p JOIN sucursal s ON s.nombre = 'Sur'
WHERE p.codigo = 'TAL-001';

-- Inventario de Martillo Galponero
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 40, 10, 20
FROM producto p JOIN sucursal s ON s.nombre = 'Centro'
WHERE p.codigo = 'MAR-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 5, 10, 20
FROM producto p JOIN sucursal s ON s.nombre = 'Sur'
WHERE p.codigo = 'MAR-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 16, 10, 20
FROM producto p JOIN sucursal s ON s.nombre = 'Oeste'
WHERE p.codigo = 'MAR-001';

-- Inventario de Sierra Circular
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 22, 5, 15
FROM producto p JOIN sucursal s ON s.nombre = 'Oeste'
WHERE p.codigo = 'SIE-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 2, 5, 15
FROM producto p JOIN sucursal s ON s.nombre = 'Norte'
WHERE p.codigo = 'SIE-001';

-- Inventario de Cinta Metrica 5m
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 110, 30, 80
FROM producto p JOIN sucursal s ON s.nombre = 'Sur'
WHERE p.codigo = 'CIN-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 12, 30, 80
FROM producto p JOIN sucursal s ON s.nombre = 'Centro'
WHERE p.codigo = 'CIN-001';

-- Inventario de Amoladora Angular (con par Sobrestock -> Deficit listo para Generar recomendaciones en vivo)
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 65, 20, 45
FROM producto p JOIN sucursal s ON s.nombre = 'Deposito Central'
WHERE p.codigo = 'AMO-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 4, 12, 25
FROM producto p JOIN sucursal s ON s.nombre = 'Oeste'
WHERE p.codigo = 'AMO-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 18, 12, 25
FROM producto p JOIN sucursal s ON s.nombre = 'Norte'
WHERE p.codigo = 'AMO-001';

-- Inventario de Set de Destornilladores (con par Sobrestock -> Deficit listo para Generar recomendaciones en vivo)
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 25, 20, 50
FROM producto p JOIN sucursal s ON s.nombre = 'Centro'
WHERE p.codigo = 'DES-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 40, 20, 50
FROM producto p JOIN sucursal s ON s.nombre = 'Norte'
WHERE p.codigo = 'DES-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 95, 30, 60
FROM producto p JOIN sucursal s ON s.nombre = 'Deposito Central'
WHERE p.codigo = 'DES-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 9, 20, 45
FROM producto p JOIN sucursal s ON s.nombre = 'Sur'
WHERE p.codigo = 'DES-001';

-- Inventario de Casco de Seguridad
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 70, 25, 60
FROM producto p JOIN sucursal s ON s.nombre = 'Deposito Central'
WHERE p.codigo = 'CAS-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 28, 20, 40
FROM producto p JOIN sucursal s ON s.nombre = 'Centro'
WHERE p.codigo = 'CAS-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 22, 15, 35
FROM producto p JOIN sucursal s ON s.nombre = 'Oeste'
WHERE p.codigo = 'CAS-001';

-- Inventario de Llave Inglesa 10p
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 32, 15, 35
FROM producto p JOIN sucursal s ON s.nombre = 'Norte'
WHERE p.codigo = 'LLI-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 24, 15, 30
FROM producto p JOIN sucursal s ON s.nombre = 'Sur'
WHERE p.codigo = 'LLI-001';

INSERT INTO inventario (id_producto, id_sucursal, stock_actual, stock_minimo, stock_maximo)
SELECT p.id_producto, s.id_sucursal, 19, 12, 30
FROM producto p JOIN sucursal s ON s.nombre = 'Oeste'
WHERE p.codigo = 'LLI-001';

-- Alertas activas derivadas del escenario de inventario
INSERT INTO alerta (id_inventario, tipo, estado)
SELECT i.id_inventario, 'DEFICIT', 'ACTIVA'
FROM inventario i
WHERE i.stock_actual < i.stock_minimo;

INSERT INTO alerta (id_inventario, tipo, estado)
SELECT i.id_inventario, 'SOBRESTOCK', 'ACTIVA'
FROM inventario i
WHERE i.stock_actual > i.stock_maximo;

-- Recomendaciones iniciales en estado PENDIENTE
INSERT INTO recomendacion (
    id_inventario_origen, id_inventario_destino,
    cantidad_recomendada, estado
)
SELECT io.id_inventario, id.id_inventario, 7, 'PENDIENTE'
FROM inventario io
JOIN producto po ON po.id_producto = io.id_producto
JOIN sucursal so ON so.id_sucursal = io.id_sucursal
JOIN inventario id ON id.id_producto = io.id_producto
JOIN sucursal sd ON sd.id_sucursal = id.id_sucursal
WHERE po.codigo = 'TAL-001'
  AND so.nombre = 'Norte'
  AND sd.nombre = 'Centro';

INSERT INTO recomendacion (
    id_inventario_origen, id_inventario_destino,
    cantidad_recomendada, estado
)
SELECT io.id_inventario, id.id_inventario, 5, 'PENDIENTE'
FROM inventario io
JOIN producto po ON po.id_producto = io.id_producto
JOIN sucursal so ON so.id_sucursal = io.id_sucursal
JOIN inventario id ON id.id_producto = io.id_producto
JOIN sucursal sd ON sd.id_sucursal = id.id_sucursal
WHERE po.codigo = 'MAR-001'
  AND so.nombre = 'Centro'
  AND sd.nombre = 'Sur';

INSERT INTO recomendacion (
    id_inventario_origen, id_inventario_destino,
    cantidad_recomendada, estado
)
SELECT io.id_inventario, id.id_inventario, 3, 'PENDIENTE'
FROM inventario io
JOIN producto po ON po.id_producto = io.id_producto
JOIN sucursal so ON so.id_sucursal = io.id_sucursal
JOIN inventario id ON id.id_producto = io.id_producto
JOIN sucursal sd ON sd.id_sucursal = id.id_sucursal
WHERE po.codigo = 'SIE-001'
  AND so.nombre = 'Oeste'
  AND sd.nombre = 'Norte';

INSERT INTO recomendacion (
    id_inventario_origen, id_inventario_destino,
    cantidad_recomendada, estado
)
SELECT io.id_inventario, id.id_inventario, 18, 'PENDIENTE'
FROM inventario io
JOIN producto po ON po.id_producto = io.id_producto
JOIN sucursal so ON so.id_sucursal = io.id_sucursal
JOIN inventario id ON id.id_producto = io.id_producto
JOIN sucursal sd ON sd.id_sucursal = id.id_sucursal
WHERE po.codigo = 'CIN-001'
  AND so.nombre = 'Sur'
  AND sd.nombre = 'Centro';

-- Ejemplos históricos de decisiones y transferencias (APROBADA / RECHAZADA / EN_TRANSITO / COMPLETADA)
SET @usuario_compras := (SELECT id_usuario FROM usuario WHERE usuario = 'compras');

-- 1) Recomendación histórica RECHAZADA
INSERT INTO recomendacion (
    id_inventario_origen, id_inventario_destino,
    cantidad_recomendada, estado,
    id_usuario_decision, fecha_decision, motivo_decision
)
SELECT io.id_inventario, id.id_inventario, 8, 'RECHAZADA',
       @usuario_compras, DATE_SUB(NOW(), INTERVAL 3 DAY),
       'Reposición cubierta por entrega programada de proveedor local.'
FROM inventario io
JOIN producto po ON po.id_producto = io.id_producto
JOIN sucursal so ON so.id_sucursal = io.id_sucursal
JOIN inventario id ON id.id_producto = io.id_producto
JOIN sucursal sd ON sd.id_sucursal = id.id_sucursal
WHERE po.codigo = 'CAS-001'
  AND so.nombre = 'Deposito Central'
  AND sd.nombre = 'Oeste';

-- 2) Recomendación histórica APROBADA con transferencia EN_TRANSITO
INSERT INTO recomendacion (
    id_inventario_origen, id_inventario_destino,
    cantidad_recomendada, cantidad_aprobada, estado,
    id_usuario_decision, fecha_decision, motivo_decision
)
SELECT io.id_inventario, id.id_inventario, 12, 12, 'APROBADA',
       @usuario_compras, DATE_SUB(NOW(), INTERVAL 1 DAY),
       'Aprobada para reforzar stock de seguridad en sucursal Centro.'
FROM inventario io
JOIN producto po ON po.id_producto = io.id_producto
JOIN sucursal so ON so.id_sucursal = io.id_sucursal
JOIN inventario id ON id.id_producto = io.id_producto
JOIN sucursal sd ON sd.id_sucursal = id.id_sucursal
WHERE po.codigo = 'CAS-001'
  AND so.nombre = 'Deposito Central'
  AND sd.nombre = 'Centro';

SET @rec_casco_transito := LAST_INSERT_ID();

INSERT INTO transferencia (
    id_recomendacion, id_usuario_responsable, cantidad, estado, fecha_registro, observacion
)
VALUES (
    @rec_casco_transito, @usuario_compras, 12, 'EN_TRANSITO',
    DATE_SUB(NOW(), INTERVAL 1 DAY), 'Creada al aprobar la recomendación'
);

SET @transf_casco_transito := LAST_INSERT_ID();

INSERT INTO historial_transferencia (id_transferencia, id_usuario, estado, fecha_hora, observacion) VALUES
(@transf_casco_transito, @usuario_compras, 'PENDIENTE', DATE_SUB(NOW(), INTERVAL 1 DAY), 'Transferencia registrada.'),
(@transf_casco_transito, @usuario_compras, 'EN_TRANSITO', DATE_SUB(NOW(), INTERVAL 12 HOUR), 'Traslado iniciado.');

-- 3) Recomendación histórica APROBADA con transferencia COMPLETADA y movimientos registrados
INSERT INTO recomendacion (
    id_inventario_origen, id_inventario_destino,
    cantidad_recomendada, cantidad_aprobada, estado,
    id_usuario_decision, fecha_decision, motivo_decision
)
SELECT io.id_inventario, id.id_inventario, 6, 6, 'APROBADA',
       @usuario_compras, DATE_SUB(NOW(), INTERVAL 2 DAY),
       'Aprobada para equilibrar dotación de herramientas manuales.'
FROM inventario io
JOIN producto po ON po.id_producto = io.id_producto
JOIN sucursal so ON so.id_sucursal = io.id_sucursal
JOIN inventario id ON id.id_producto = io.id_producto
JOIN sucursal sd ON sd.id_sucursal = id.id_sucursal
WHERE po.codigo = 'LLI-001'
  AND so.nombre = 'Norte'
  AND sd.nombre = 'Oeste';

SET @rec_llave_completada := LAST_INSERT_ID();

INSERT INTO transferencia (
    id_recomendacion, id_usuario_responsable, cantidad, estado,
    fecha_registro, fecha_finalizacion, observacion
)
VALUES (
    @rec_llave_completada, @usuario_compras, 6, 'COMPLETADA',
    DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY),
    'Creada al aprobar la recomendación'
);

SET @transf_llave_completada := LAST_INSERT_ID();

INSERT INTO historial_transferencia (id_transferencia, id_usuario, estado, fecha_hora, observacion) VALUES
(@transf_llave_completada, @usuario_compras, 'PENDIENTE', DATE_SUB(NOW(), INTERVAL 2 DAY), 'Transferencia registrada.'),
(@transf_llave_completada, @usuario_compras, 'EN_TRANSITO', DATE_SUB(NOW(), INTERVAL 36 HOUR), 'Traslado iniciado.'),
(@transf_llave_completada, @usuario_compras, 'COMPLETADA', DATE_SUB(NOW(), INTERVAL 1 DAY), 'Transferencia finalizada. Inventarios actualizados atómicamente.');

INSERT INTO movimiento (id_inventario, id_usuario, id_transferencia, tipo, cantidad, fecha_hora, observacion)
SELECT i.id_inventario, @usuario_compras, @transf_llave_completada, 'SALIDA', 6,
       DATE_SUB(NOW(), INTERVAL 1 DAY), 'Salida por transferencia interna'
FROM inventario i
JOIN producto p ON p.id_producto = i.id_producto
JOIN sucursal s ON s.id_sucursal = i.id_sucursal
WHERE p.codigo = 'LLI-001' AND s.nombre = 'Norte';

INSERT INTO movimiento (id_inventario, id_usuario, id_transferencia, tipo, cantidad, fecha_hora, observacion)
SELECT i.id_inventario, @usuario_compras, @transf_llave_completada, 'ENTRADA', 6,
       DATE_SUB(NOW(), INTERVAL 1 DAY), 'Entrada por transferencia interna'
FROM inventario i
JOIN producto p ON p.id_producto = i.id_producto
JOIN sucursal s ON s.id_sucursal = i.id_sucursal
WHERE p.codigo = 'LLI-001' AND s.nombre = 'Oeste';
