SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `projet_pizza` ;
CREATE SCHEMA IF NOT EXISTS `projet_pizza` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `projet_pizza` ;

-- -----------------------------------------------------
-- Table `habilitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `habilitation` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `habilitation` (
  `habilitation_id` INT NOT NULL,
  `habilitation_modifier` TINYINT(1) NULL,
  `habilitationcol` TINYINT(1) NULL,
  PRIMARY KEY (`habilitation_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `personnel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `personnel` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `personnel` (
  `personnel_id` INT NOT NULL,
  `personnel_nom` VARCHAR(45) NULL,
  `personnel_password` VARCHAR(45) NOT NULL,
  `personnel_habilitation_habilitation_id` INT NULL,
  `habilitation_habilitation_id` INT NOT NULL,
  PRIMARY KEY (`personnel_id`, `habilitation_habilitation_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `commande` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `commande` (
  `commande_id` INT NOT NULL,
  `commande_date` DATE NOT NULL,
  `commande_etat` VARCHAR(10) NOT NULL,
  `personnel_personnel_id` INT NOT NULL,
  PRIMARY KEY (`commande_id`, `personnel_personnel_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `restaurant` (
  `restaurant_id` INT NOT NULL,
  `restaurant_raison_sociale` VARCHAR(45) NULL,
  `restaurant_longitude` DOUBLE NULL,
  `restaurant_latitude` DOUBLE NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `table` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `table` (
  `table_id` INT NOT NULL,
  `restaurant_restaurant_id` INT NOT NULL,
  PRIMARY KEY (`table_id`, `restaurant_restaurant_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `client` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `client` (
  `client_id` INT(11) NOT NULL,
  `client_name` VARCHAR(80) NULL,
  `client_table` INT NULL,
  `commande_commande_id` INT NOT NULL,
  `table_table_id` INT NOT NULL,
  `table_restaurant_restaurant_id` INT NOT NULL,
  PRIMARY KEY (`client_id`, `commande_commande_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `produit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produit` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `produit` (
  `produit_id` INT NOT NULL,
  `produit_nom` VARCHAR(80) NOT NULL,
  `produit_description` VARCHAR(250) NOT NULL,
  `produit_prix` FLOAT NOT NULL,
  PRIMARY KEY (`produit_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `commande_produit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `commande_produit` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `commande_produit` (
  `produit_produit_id` INT NOT NULL,
  `commande_commande_id` INT NOT NULL,
  PRIMARY KEY (`produit_produit_id`, `commande_commande_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
