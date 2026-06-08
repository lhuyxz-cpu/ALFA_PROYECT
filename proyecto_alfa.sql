-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2026 a las 03:32:52
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_alfa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado_cita` enum('PENDIENTE','CONFIRMADA','CANCELADA','FINALIZADA') DEFAULT 'PENDIENTE',
  `id_usuario` int(11) NOT NULL,
  `id_moto` int(11) NOT NULL,
  `id_taller` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_cita`, `fecha`, `hora`, `estado_cita`, `id_usuario`, `id_moto`, `id_taller`, `id_servicio`) VALUES
(1, '2026-06-10', '08:00:00', 'CONFIRMADA', 1, 1, 1, 1),
(2, '2026-06-11', '09:30:00', 'PENDIENTE', 2, 2, 2, 2),
(3, '2026-06-12', '10:00:00', 'CONFIRMADA', 3, 3, 3, 3),
(4, '2026-06-13', '14:00:00', 'FINALIZADA', 4, 4, 4, 4),
(5, '2026-06-14', '15:30:00', 'PENDIENTE', 5, 5, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `id_cotizacion` int(11) NOT NULL,
  `fecha_cotizacion` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `estado_cotizacion` enum('PENDIENTE','APROBADA','RECHAZADA') DEFAULT 'PENDIENTE',
  `id_orden` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cotizacion`
--

INSERT INTO `cotizacion` (`id_cotizacion`, `fecha_cotizacion`, `total`, `estado_cotizacion`, `id_orden`) VALUES
(1, '2026-06-10', 230000.00, 'APROBADA', 1),
(2, '2026-06-11', 120000.00, 'PENDIENTE', 2),
(3, '2026-06-12', 180000.00, 'APROBADA', 3),
(4, '2026-06-13', 95000.00, 'APROBADA', 4),
(5, '2026-06-14', 140000.00, 'PENDIENTE', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moto`
--

CREATE TABLE `moto` (
  `id_moto` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `cilindraje` int(11) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `kilometraje` int(11) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `moto`
--

INSERT INTO `moto` (`id_moto`, `placa`, `marca`, `modelo`, `cilindraje`, `color`, `anio`, `kilometraje`, `id_usuario`) VALUES
(1, 'ABC123', 'Yamaha', 'FZ25', 250, 'Negro', 2023, 12000, 1),
(2, 'DEF456', 'Honda', 'CB190R', 190, 'Rojo', 2022, 18000, 2),
(3, 'GHI789', 'AKT', 'NKD125', 125, 'Azul', 2021, 25000, 3),
(4, 'JKL321', 'Suzuki', 'GN125', 125, 'Blanco', 2020, 30000, 4),
(5, 'MNO654', 'Bajaj', 'Pulsar NS200', 200, 'Gris', 2024, 5000, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_trabajo`
--

CREATE TABLE `orden_trabajo` (
  `id_orden` int(11) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `descripcion_falla` text DEFAULT NULL,
  `diagnostico` text DEFAULT NULL,
  `estado_orden` enum('ABIERTA','EN_PROCESO','FINALIZADA') DEFAULT 'ABIERTA',
  `id_cita` int(11) NOT NULL,
  `id_tecnico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden_trabajo`
--

INSERT INTO `orden_trabajo` (`id_orden`, `fecha_ingreso`, `descripcion_falla`, `diagnostico`, `estado_orden`, `id_cita`, `id_tecnico`) VALUES
(1, '2026-06-10', 'Ruido en el motor', 'Desgaste de rodamientos', 'EN_PROCESO', 1, 1),
(2, '2026-06-11', 'Frenos desgastados', 'Cambio de pastillas requerido', 'ABIERTA', 2, 2),
(3, '2026-06-12', 'Bateria descargada', 'Bateria en mal estado', 'FINALIZADA', 3, 3),
(4, '2026-06-13', 'Vibracion en direccion', 'Necesita alineacion', 'FINALIZADA', 4, 4),
(5, '2026-06-14', 'Luces intermitentes fallando', 'Problema electrico', 'ABIERTA', 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` enum('EFECTIVO','TARJETA','TRANSFERENCIA','NEQUI','DAVIPLATA') DEFAULT NULL,
  `fecha_pago` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado_pago` enum('PENDIENTE','PAGADO','RECHAZADO') DEFAULT 'PENDIENTE',
  `id_cotizacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_pago`, `monto`, `metodo_pago`, `fecha_pago`, `estado_pago`, `id_cotizacion`) VALUES
(1, 230000.00, 'TRANSFERENCIA', '2026-05-30 01:20:46', 'PAGADO', 1),
(2, 120000.00, 'EFECTIVO', '2026-05-30 01:20:46', 'PENDIENTE', 2),
(3, 180000.00, 'NEQUI', '2026-05-30 01:20:46', 'PAGADO', 3),
(4, 95000.00, 'TARJETA', '2026-05-30 01:20:46', 'PAGADO', 4),
(5, 140000.00, 'DAVIPLATA', '2026-05-30 01:20:46', 'PENDIENTE', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `id_servicio` int(11) NOT NULL,
  `nombre_servicio` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `duracion_estimada` varchar(50) DEFAULT NULL,
  `id_taller` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`id_servicio`, `nombre_servicio`, `descripcion`, `costo`, `duracion_estimada`, `id_taller`) VALUES
(1, 'Cambio de Aceite', 'Cambio completo de aceite y filtro', 50000.00, '30 minutos', 1),
(2, 'Revision General', 'Inspeccion completa de la motocicleta', 80000.00, '1 hora', 2),
(3, 'Cambio de Frenos', 'Sustitucion de pastillas de freno', 120000.00, '45 minutos', 3),
(4, 'Diagnostico Electronico', 'Revision de sensores y sistema electrico', 70000.00, '40 minutos', 4),
(5, 'Alineacion y Balanceo', 'Ajuste de direccion y estabilidad', 60000.00, '35 minutos', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `taller`
--

CREATE TABLE `taller` (
  `id_taller` int(11) NOT NULL,
  `nombre_taller` varchar(100) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `horario_atencion` varchar(100) DEFAULT NULL,
  `capacidad_diaria` int(11) DEFAULT NULL,
  `estado_taller` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `taller`
--

INSERT INTO `taller` (`id_taller`, `nombre_taller`, `direccion`, `telefono`, `correo`, `horario_atencion`, `capacidad_diaria`, `estado_taller`) VALUES
(1, 'Moto Expertos', 'Calle 100 #15-20', '3101111111', 'contacto@motoexpertos.com', '8AM-6PM', 20, 'ACTIVO'),
(2, 'Speed Motors', 'Carrera 30 #45-10', '3102222222', 'info@speedmotors.com', '7AM-5PM', 15, 'ACTIVO'),
(3, 'Full Motos', 'Calle 80 #22-15', '3103333333', 'servicio@fullmotos.com', '8AM-7PM', 25, 'ACTIVO'),
(4, 'Moto Service', 'Avenida 68 #40-12', '3104444444', 'contacto@motoservice.com', '8AM-6PM', 18, 'ACTIVO'),
(5, 'Taller Elite', 'Calle 170 #10-50', '3105555555', 'elite@taller.com', '7AM-6PM', 30, 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnico`
--

CREATE TABLE `tecnico` (
  `id_tecnico` int(11) NOT NULL,
  `nombre_tecnico` varchar(100) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `id_taller` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnico`
--

INSERT INTO `tecnico` (`id_tecnico`, `nombre_tecnico`, `especialidad`, `telefono`, `id_taller`) VALUES
(1, 'Juan Perez', 'Mecanica General', '3106000001', 1),
(2, 'Andres Gomez', 'Electricidad', '3106000002', 2),
(3, 'Carlos Ruiz', 'Motor', '3106000003', 3),
(4, 'Felipe Torres', 'Suspension', '3106000004', 4),
(5, 'Miguel Castro', 'Diagnostico', '3106000005', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `rol` enum('CLIENTE','ADMIN') DEFAULT 'CLIENTE',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado_usuario` enum('ACTIVO','INACTIVO','BLOQUEADO') DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `apellido`, `correo`, `contrasena`, `telefono`, `direccion`, `rol`, `fecha_registro`, `estado_usuario`) VALUES
(1, 'Luis', 'Leon', 'luis@gmail.com', '1234', '3001111111', 'Bogotá', 'ADMIN', '2026-05-30 00:51:45', 'ACTIVO'),
(2, 'Ana', 'Martinez', 'ana@gmail.com', '1234', '3002222222', 'Medellín', 'CLIENTE', '2026-05-30 00:51:45', 'ACTIVO'),
(3, 'Carlos', 'Ramirez', 'carlos@gmail.com', '1234', '3003333333', 'Cali', 'CLIENTE', '2026-05-30 00:51:45', 'ACTIVO'),
(4, 'Sofia', 'Gomez', 'sofia@gmail.com', '1234', '3004444444', 'Bogotá', 'CLIENTE', '2026-05-30 00:51:45', 'ACTIVO'),
(5, 'David', 'Torres', 'david@gmail.com', '1234', '3005555555', 'Tunja', 'CLIENTE', '2026-05-30 00:51:45', 'ACTIVO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_moto` (`id_moto`),
  ADD KEY `id_taller` (`id_taller`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`id_cotizacion`),
  ADD KEY `id_orden` (`id_orden`);

--
-- Indices de la tabla `moto`
--
ALTER TABLE `moto`
  ADD PRIMARY KEY (`id_moto`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  ADD PRIMARY KEY (`id_orden`),
  ADD KEY `id_cita` (`id_cita`),
  ADD KEY `id_tecnico` (`id_tecnico`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_cotizacion` (`id_cotizacion`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `id_taller` (`id_taller`);

--
-- Indices de la tabla `taller`
--
ALTER TABLE `taller`
  ADD PRIMARY KEY (`id_taller`);

--
-- Indices de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`id_tecnico`),
  ADD KEY `id_taller` (`id_taller`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  MODIFY `id_cotizacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `moto`
--
ALTER TABLE `moto`
  MODIFY `id_moto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  MODIFY `id_orden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `taller`
--
ALTER TABLE `taller`
  MODIFY `id_taller` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  MODIFY `id_tecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_moto`) REFERENCES `moto` (`id_moto`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`),
  ADD CONSTRAINT `cita_ibfk_4` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`);

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `cotizacion_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `orden_trabajo` (`id_orden`) ON DELETE CASCADE;

--
-- Filtros para la tabla `moto`
--
ALTER TABLE `moto`
  ADD CONSTRAINT `moto_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  ADD CONSTRAINT `orden_trabajo_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `cita` (`id_cita`),
  ADD CONSTRAINT `orden_trabajo_ibfk_2` FOREIGN KEY (`id_tecnico`) REFERENCES `tecnico` (`id_tecnico`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_cotizacion`) REFERENCES `cotizacion` (`id_cotizacion`);

--
-- Filtros para la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
