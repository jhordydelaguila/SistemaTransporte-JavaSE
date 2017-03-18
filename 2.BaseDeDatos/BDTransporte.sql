-- MySQL Script generated by MySQL Workbench
-- 12/11/15 15:35:07
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BaseTransporte
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BaseTransporte
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BaseTransporte` ;
USE `BaseTransporte` ;

-- -----------------------------------------------------
-- Table `BaseTransporte`.`Chofer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`Chofer` (
  `choferid` CHAR(5) NOT NULL,
  `dni` CHAR(8) NULL,
  `nombre` VARCHAR(20) NULL,
  `apellidoMaterno` VARCHAR(30) NULL,
  `apellidoPaterno` VARCHAR(30) NULL,
  `fechaNacimiento` DATE NULL,
  `estadoCivil` VARCHAR(20) NULL,
  PRIMARY KEY (`choferid`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`CiudadDestino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`CiudadDestino` (
  `ciudaddestinoid` CHAR(5) NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `codigoPostal` VARCHAR(20) NULL,
  `provincia` VARCHAR(30) NULL,
  PRIMARY KEY (`ciudaddestinoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`TerminalDestino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`TerminalDestino` (
  `terminaldestinoid` CHAR(5) NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `direccion` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `telefono` VARCHAR(10) NULL,
  `ciudaddestinoid` CHAR(5) NOT NULL,
  PRIMARY KEY (`terminaldestinoid`, `ciudaddestinoid`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_TerminalDestino_CiudadDestino1_idx` (`ciudaddestinoid` ASC),
  CONSTRAINT `fk_TerminalDestino_CiudadDestino1`
    FOREIGN KEY (`ciudaddestinoid`)
    REFERENCES `BaseTransporte`.`CiudadDestino` (`ciudaddestinoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`CiudadOrigen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`CiudadOrigen` (
  `ciudadorigenid` CHAR(5) NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `codigoPostal` VARCHAR(20) NULL,
  `provincia` VARCHAR(30) NULL,
  PRIMARY KEY (`ciudadorigenid`),
  UNIQUE INDEX `codigoPostal_UNIQUE` (`codigoPostal` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`TerminalOrigen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`TerminalOrigen` (
  `terminalorigenid` CHAR(5) NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `direccion` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `telefono` VARCHAR(10) NULL,
  `ciudadorigenid` CHAR(5) NOT NULL,
  PRIMARY KEY (`terminalorigenid`, `ciudadorigenid`),
  INDEX `fk_TerminalOrigen_Ciudad1_idx` (`ciudadorigenid` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `fk_TerminalOrigen_Ciudad1`
    FOREIGN KEY (`ciudadorigenid`)
    REFERENCES `BaseTransporte`.`CiudadOrigen` (`ciudadorigenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`Categoria` (
  `categoriaid` CHAR(5) NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`categoriaid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`Bus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`Bus` (
  `busid` CHAR(5) BINARY NOT NULL,
  `capacidad` INT(11) NULL,
  `matricula` VARCHAR(45) NULL,
  `estado` VARCHAR(20) NULL,
  `choferid` CHAR(5) NOT NULL,
  `categoriaid` CHAR(5) NOT NULL,
  `terminaldestinoid` CHAR(5) NOT NULL,
  `terminalorigenid` CHAR(5) NOT NULL,
  PRIMARY KEY (`busid`, `choferid`, `categoriaid`, `terminaldestinoid`, `terminalorigenid`),
  INDEX `fk_Bus_Chofer_idx` (`choferid` ASC),
  INDEX `fk_Bus_Terminal1_idx` (`terminaldestinoid` ASC),
  INDEX `fk_Bus_TerminalOrigen1_idx` (`terminalorigenid` ASC),
  INDEX `fk_Bus_table11_idx` (`categoriaid` ASC),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC),
  CONSTRAINT `fk_Bus_Chofer`
    FOREIGN KEY (`choferid`)
    REFERENCES `BaseTransporte`.`Chofer` (`choferid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bus_Terminal1`
    FOREIGN KEY (`terminaldestinoid`)
    REFERENCES `BaseTransporte`.`TerminalDestino` (`terminaldestinoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bus_TerminalOrigen1`
    FOREIGN KEY (`terminalorigenid`)
    REFERENCES `BaseTransporte`.`TerminalOrigen` (`terminalorigenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bus_table11`
    FOREIGN KEY (`categoriaid`)
    REFERENCES `BaseTransporte`.`Categoria` (`categoriaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`Pasaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`Pasaje` (
  `pasajeid` CHAR(5) NOT NULL,
  `horasalida` VARCHAR(10) NULL,
  `fechasalida` DATE NULL,
  `estado` VARCHAR(15) NULL,
  `busid` CHAR(5) BINARY NOT NULL,
  PRIMARY KEY (`pasajeid`, `busid`),
  INDEX `fk_Pasaje_Bus1_idx` (`busid` ASC),
  CONSTRAINT `fk_Pasaje_Bus1`
    FOREIGN KEY (`busid`)
    REFERENCES `BaseTransporte`.`Bus` (`busid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`Pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`Pasajero` (
  `dni` CHAR(8) NOT NULL,
  `nombre` VARCHAR(20) NULL,
  `apellidoMaterno` VARCHAR(30) NULL,
  `apellidoPaterno` VARCHAR(30) NULL,
  `fechaNacimiento` DATE NULL,
  `edad` INT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseTransporte`.`VentaPasaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseTransporte`.`VentaPasaje` (
  `ventapasajeid` CHAR(5) NOT NULL,
  `fecha` DATE NULL,
  `precio` DECIMAL(9,2) NULL,
  `asiento` INT NOT NULL,
  `pasajeid` CHAR(5) NOT NULL,
  `dni` CHAR(8) NOT NULL,
  PRIMARY KEY (`ventapasajeid`, `pasajeid`, `dni`),
  INDEX `fk_VentaPasaje_Pasaje1_idx` (`pasajeid` ASC),
  UNIQUE INDEX `asiento_UNIQUE` (`asiento` ASC),
  INDEX `fk_VentaPasaje_Pasajero1_idx` (`dni` ASC),
  CONSTRAINT `fk_VentaPasaje_Pasaje1`
    FOREIGN KEY (`pasajeid`)
    REFERENCES `BaseTransporte`.`Pasaje` (`pasajeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaPasaje_Pasajero1`
    FOREIGN KEY (`dni`)
    REFERENCES `BaseTransporte`.`Pasajero` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;