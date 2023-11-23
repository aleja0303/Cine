-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-11-2023 a las 03:35:55
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cine`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `BORRAR_RESERVA` (IN `IDR` INT)   BEGIN
	DELETE FROM `reservas` WHERE ID = IDR;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREAR_RESERVA` (IN `CED` INT, IN `I1` INT, IN `I2` INT, IN `I3` INT, IN `I4` INT, IN `I5` INT, IN `I6` INT, IN `I7` INT, IN `I8` INT)   BEGIN
	INSERT INTO `reservas`(`CEDULA_CLIENTE`, `ID_S1`, `ID_S2`, `ID_S3`, `ID_S4`, `ID_S5`, `ID_S6`, `ID_S7`, `ID_S8`, `ESTADO_PAGO`) VALUES (CED, I1, I2, I3, I4, I5, I6 , I7, I8, 0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREAR_TARJETA` (IN `CEDULA` INT)   BEGIN
	INSERT INTO tarjeta (FONDOS, CEDULA_CLIENTE) VALUES (70000, CEDULA);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INICIAR_SESION` (IN `COR` VARCHAR(60), IN `CONT` VARCHAR(60))   BEGIN
	DECLARE RESULT TEXT;
    IF ((SELECT COUNT(NOMBRE) FROM cliente WHERE CORREO = COR && PASSWORD = CONT) = 1) THEN
    	SELECT * FROM cliente WHERE CORREO = COR && PASSWORD = CONT;
	ELSE
    	SET RESULT = "ERROR";
        SELECT RESULT;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `NUEVO_USUARIO` (IN `NOM` VARCHAR(40), IN `COR` VARCHAR(60), IN `CED` INT, IN `CONT` VARCHAR(60))   BEGIN
	DECLARE RESULT TEXT;
    IF ((SELECT COUNT(NOMBRE) FROM cliente WHERE NOMBRE = NOM) = 0) THEN
    	INSERT INTO cliente (NOMBRE, CEDULA, CORREO, PASSWORD) VALUES (NOM, CED, COR, CONT);
        SET RESULT = "CREADO";
   	ELSE 
    	SET RESULT = "NO CREADO";
    END IF;
    SELECT RESULT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OBTENER_SALA` (IN `IDP` INT)   BEGIN
	SELECT ID, ESTADO FROM sillas WHERE ID_SALA = IDP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAGAR` (IN `IDR` INT, IN `IDT` INT, IN `VAL` INT)   BEGIN
	SELECT * FROM reservas AS RES WHERE ID = IDR;
    IF(RES.ID_S1 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S1;
    END IF;
    IF(RES.ID_S2 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S2;
    END IF;
    IF(RES.ID_S3 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S3;
    END IF;
    IF(RES.ID_S4 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S4;
    END IF;
    IF(RES.ID_S5 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S5;
    END IF;
    IF(RES.ID_S6 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S6;
    END IF;
    IF(RES.ID_S7 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S7;
    END IF;
    IF(RES.ID_S8 != 0) THEN 
    	UPDATE sillas SET ESTADO = 1 WHERE ID = ID_S8;
    END IF;
	UPDATE tarjeta SET FONDOS = ((SELECT FONDOS FROM tarjeta WHERE ID = IDT) - VAL) WHERE ID = IDT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RECARGAR_TARJETA` (IN `IDT` INT)   BEGIN
	UPDATE tarjeta SET FONDOS = ((SELECT FONDOS FROM tarjeta WHERE ID = IDT) + 50000) WHERE ID = IDT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `NOMBRE` varchar(40) DEFAULT NULL,
  `CEDULA` int(11) NOT NULL,
  `CORREO` varchar(60) DEFAULT NULL,
  `PASSWORD` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`NOMBRE`, `CEDULA`, `CORREO`, `PASSWORD`) VALUES
('MARIO', 10924913, 'MARIO@GMAIL.COM', 'HOLA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `ID` int(11) NOT NULL,
  `CEDULA_CLIENTE` int(11) DEFAULT NULL,
  `ID_S1` int(11) DEFAULT NULL,
  `ID_S2` int(11) DEFAULT NULL,
  `ID_S3` int(11) DEFAULT NULL,
  `ID_S4` int(11) DEFAULT NULL,
  `ID_S5` int(11) DEFAULT NULL,
  `ID_S6` int(11) DEFAULT NULL,
  `ID_S7` int(11) DEFAULT NULL,
  `ID_S8` int(11) DEFAULT NULL,
  `ESTADO_PAGO` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salas`
--

CREATE TABLE `salas` (
  `ID` int(11) NOT NULL,
  `NOMBRE_PELICULA` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `salas`
--

INSERT INTO `salas` (`ID`, `NOMBRE_PELICULA`) VALUES
(1, 'Terminator 2'),
(2, 'Barbie');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sillas`
--

CREATE TABLE `sillas` (
  `ID` int(11) NOT NULL,
  `FILA` varchar(2) DEFAULT NULL,
  `COLUMNA` int(10) DEFAULT NULL,
  `ESTADO` int(1) DEFAULT NULL,
  `ID_SALA` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sillas`
--

INSERT INTO `sillas` (`ID`, `FILA`, `COLUMNA`, `ESTADO`, `ID_SALA`) VALUES
(1, 'A', 1, 0, 1),
(2, 'A', 2, 0, 1),
(3, 'A', 3, 0, 1),
(4, 'A', 4, 0, 1),
(5, 'A', 5, 0, 1),
(6, 'A', 6, 0, 1),
(7, 'A', 7, 0, 1),
(8, 'A', 8, 0, 1),
(9, 'A', 9, 0, 1),
(10, 'A', 10, 0, 1),
(11, 'A', 11, 0, 1),
(12, 'A', 12, 0, 1),
(13, 'A', 13, 0, 1),
(14, 'A', 14, 0, 1),
(15, 'A', 15, 0, 1),
(16, 'A', 16, 0, 1),
(17, 'A', 17, 0, 1),
(18, 'A', 18, 0, 1),
(19, 'A', 19, 0, 1),
(20, 'A', 20, 0, 1),
(21, 'B', 1, 0, 1),
(22, 'B', 2, 0, 1),
(23, 'B', 3, 0, 1),
(24, 'B', 4, 0, 1),
(25, 'B', 5, 0, 1),
(26, 'B', 6, 0, 1),
(27, 'B', 7, 0, 1),
(28, 'B', 8, 0, 1),
(29, 'B', 9, 0, 1),
(30, 'B', 10, 0, 1),
(31, 'B', 11, 0, 1),
(32, 'B', 12, 0, 1),
(33, 'B', 13, 0, 1),
(34, 'B', 14, 0, 1),
(35, 'B', 15, 0, 1),
(36, 'B', 16, 0, 1),
(37, 'B', 17, 0, 1),
(38, 'B', 18, 0, 1),
(39, 'B', 19, 0, 1),
(40, 'B', 20, 0, 1),
(41, 'C', 1, 0, 1),
(42, 'C', 2, 0, 1),
(43, 'C', 3, 0, 1),
(44, 'C', 4, 0, 1),
(45, 'C', 5, 0, 1),
(46, 'C', 6, 0, 1),
(47, 'C', 7, 0, 1),
(48, 'C', 8, 0, 1),
(49, 'C', 9, 0, 1),
(50, 'C', 10, 0, 1),
(51, 'C', 11, 0, 1),
(52, 'C', 12, 0, 1),
(53, 'C', 13, 0, 1),
(54, 'C', 14, 0, 1),
(55, 'C', 15, 0, 1),
(56, 'C', 16, 0, 1),
(57, 'C', 17, 0, 1),
(58, 'C', 18, 0, 1),
(59, 'C', 19, 0, 1),
(60, 'C', 20, 0, 1),
(61, 'D', 1, 0, 1),
(62, 'D', 2, 0, 1),
(63, 'D', 3, 0, 1),
(64, 'D', 4, 0, 1),
(65, 'D', 5, 0, 1),
(66, 'D', 6, 0, 1),
(67, 'D', 7, 0, 1),
(68, 'D', 8, 0, 1),
(69, 'D', 9, 0, 1),
(70, 'D', 10, 0, 1),
(71, 'D', 11, 0, 1),
(72, 'D', 12, 0, 1),
(73, 'D', 13, 0, 1),
(74, 'D', 14, 0, 1),
(75, 'D', 15, 0, 1),
(76, 'D', 16, 0, 1),
(77, 'D', 17, 0, 1),
(78, 'D', 18, 0, 1),
(79, 'D', 19, 0, 1),
(80, 'D', 20, 0, 1),
(81, 'E', 1, 0, 1),
(82, 'E', 2, 0, 1),
(83, 'E', 3, 0, 1),
(84, 'E', 4, 0, 1),
(85, 'E', 5, 0, 1),
(86, 'E', 6, 0, 1),
(87, 'E', 7, 0, 1),
(88, 'E', 8, 0, 1),
(89, 'E', 9, 0, 1),
(90, 'E', 10, 0, 1),
(91, 'E', 11, 0, 1),
(92, 'E', 12, 0, 1),
(93, 'E', 13, 0, 1),
(94, 'E', 14, 0, 1),
(95, 'E', 15, 0, 1),
(96, 'E', 16, 0, 1),
(97, 'E', 17, 0, 1),
(98, 'E', 18, 0, 1),
(99, 'E', 19, 0, 1),
(100, 'E', 20, 0, 1),
(101, 'F', 1, 0, 1),
(102, 'F', 2, 0, 1),
(103, 'F', 3, 0, 1),
(104, 'F', 4, 0, 1),
(105, 'F', 5, 0, 1),
(106, 'F', 6, 0, 1),
(107, 'F', 7, 0, 1),
(108, 'F', 8, 0, 1),
(109, 'F', 9, 0, 1),
(110, 'F', 10, 0, 1),
(111, 'F', 11, 0, 1),
(112, 'F', 12, 0, 1),
(113, 'F', 13, 0, 1),
(114, 'F', 14, 0, 1),
(115, 'F', 15, 0, 1),
(116, 'F', 16, 0, 1),
(117, 'F', 17, 0, 1),
(118, 'F', 18, 0, 1),
(119, 'F', 19, 0, 1),
(120, 'F', 20, 0, 1),
(121, 'G', 1, 0, 1),
(122, 'G', 2, 0, 1),
(123, 'G', 3, 0, 1),
(124, 'G', 4, 0, 1),
(125, 'G', 5, 0, 1),
(126, 'G', 6, 0, 1),
(127, 'G', 7, 0, 1),
(128, 'G', 8, 0, 1),
(129, 'G', 9, 0, 1),
(130, 'G', 10, 0, 1),
(131, 'G', 11, 0, 1),
(132, 'G', 12, 0, 1),
(133, 'G', 13, 0, 1),
(134, 'G', 14, 0, 1),
(135, 'G', 15, 0, 1),
(136, 'G', 16, 0, 1),
(137, 'G', 17, 0, 1),
(138, 'G', 18, 0, 1),
(139, 'G', 19, 0, 1),
(140, 'G', 20, 0, 1),
(141, 'H', 1, 0, 1),
(142, 'H', 2, 0, 1),
(143, 'H', 3, 0, 1),
(144, 'H', 4, 0, 1),
(145, 'H', 5, 0, 1),
(146, 'H', 6, 0, 1),
(147, 'H', 7, 0, 1),
(148, 'H', 8, 0, 1),
(149, 'H', 9, 0, 1),
(150, 'H', 10, 0, 1),
(151, 'H', 11, 0, 1),
(152, 'H', 12, 0, 1),
(153, 'H', 13, 0, 1),
(154, 'H', 14, 0, 1),
(155, 'H', 15, 0, 1),
(156, 'H', 16, 0, 1),
(157, 'H', 17, 0, 1),
(158, 'H', 18, 0, 1),
(159, 'H', 19, 0, 1),
(160, 'H', 20, 0, 1),
(161, 'I', 1, 0, 1),
(162, 'I', 2, 0, 1),
(163, 'I', 3, 0, 1),
(164, 'I', 4, 0, 1),
(165, 'I', 5, 0, 1),
(166, 'I', 6, 0, 1),
(167, 'I', 7, 0, 1),
(168, 'I', 8, 0, 1),
(169, 'I', 9, 0, 1),
(170, 'I', 10, 0, 1),
(171, 'I', 11, 0, 1),
(172, 'I', 12, 0, 1),
(173, 'I', 13, 0, 1),
(174, 'I', 14, 0, 1),
(175, 'I', 15, 0, 1),
(176, 'I', 16, 0, 1),
(177, 'I', 17, 0, 1),
(178, 'I', 18, 0, 1),
(179, 'I', 19, 0, 1),
(180, 'I', 20, 0, 1),
(181, 'J', 1, 0, 1),
(182, 'J', 2, 0, 1),
(183, 'J', 3, 0, 1),
(184, 'J', 4, 0, 1),
(185, 'J', 5, 0, 1),
(186, 'J', 6, 0, 1),
(187, 'J', 7, 0, 1),
(188, 'J', 8, 0, 1),
(189, 'J', 9, 0, 1),
(190, 'J', 10, 0, 1),
(191, 'J', 11, 0, 1),
(192, 'J', 12, 0, 1),
(193, 'J', 13, 0, 1),
(194, 'J', 14, 0, 1),
(195, 'J', 15, 0, 1),
(196, 'J', 16, 0, 1),
(197, 'J', 17, 0, 1),
(198, 'J', 18, 0, 1),
(199, 'J', 19, 0, 1),
(200, 'J', 20, 0, 1),
(201, 'K', 1, 0, 1),
(202, 'K', 2, 0, 1),
(203, 'K', 3, 0, 1),
(204, 'K', 4, 0, 1),
(205, 'K', 5, 0, 1),
(206, 'K', 6, 0, 1),
(207, 'K', 7, 0, 1),
(208, 'K', 8, 0, 1),
(209, 'K', 9, 0, 1),
(210, 'K', 10, 0, 1),
(211, 'K', 11, 0, 1),
(212, 'K', 12, 0, 1),
(213, 'K', 13, 0, 1),
(214, 'K', 14, 0, 1),
(215, 'K', 15, 0, 1),
(216, 'K', 16, 0, 1),
(217, 'K', 17, 0, 1),
(218, 'K', 18, 0, 1),
(219, 'K', 19, 0, 1),
(220, 'K', 20, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjeta`
--

CREATE TABLE `tarjeta` (
  `ID` int(11) NOT NULL,
  `FONDOS` int(11) DEFAULT NULL,
  `CEDULA_CLIENTE` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`CEDULA`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_S1` (`ID_S1`),
  ADD KEY `ID_S2` (`ID_S2`),
  ADD KEY `ID_S3` (`ID_S3`),
  ADD KEY `ID_S4` (`ID_S4`),
  ADD KEY `ID_S5` (`ID_S5`),
  ADD KEY `ID_S6` (`ID_S6`),
  ADD KEY `ID_S7` (`ID_S7`),
  ADD KEY `ID_S8` (`ID_S8`);

--
-- Indices de la tabla `salas`
--
ALTER TABLE `salas`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `sillas`
--
ALTER TABLE `sillas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_SALA` (`ID_SALA`);

--
-- Indices de la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CEDULA_CLIENTE` (`CEDULA_CLIENTE`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `salas`
--
ALTER TABLE `salas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sillas`
--
ALTER TABLE `sillas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT de la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`ID_S1`) REFERENCES `sillas` (`ID`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`ID_S2`) REFERENCES `sillas` (`ID`),
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`ID_S3`) REFERENCES `sillas` (`ID`),
  ADD CONSTRAINT `reservas_ibfk_4` FOREIGN KEY (`ID_S4`) REFERENCES `sillas` (`ID`),
  ADD CONSTRAINT `reservas_ibfk_5` FOREIGN KEY (`ID_S5`) REFERENCES `sillas` (`ID`),
  ADD CONSTRAINT `reservas_ibfk_6` FOREIGN KEY (`ID_S6`) REFERENCES `sillas` (`ID`),
  ADD CONSTRAINT `reservas_ibfk_7` FOREIGN KEY (`ID_S7`) REFERENCES `sillas` (`ID`),
  ADD CONSTRAINT `reservas_ibfk_8` FOREIGN KEY (`ID_S8`) REFERENCES `sillas` (`ID`);

--
-- Filtros para la tabla `sillas`
--
ALTER TABLE `sillas`
  ADD CONSTRAINT `sillas_ibfk_1` FOREIGN KEY (`ID_SALA`) REFERENCES `salas` (`ID`);

--
-- Filtros para la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  ADD CONSTRAINT `tarjeta_ibfk_1` FOREIGN KEY (`CEDULA_CLIENTE`) REFERENCES `cliente` (`CEDULA`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
