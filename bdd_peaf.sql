-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema peaf
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema peaf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `peaf` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `peaf` ;

-- -----------------------------------------------------
-- Table `peaf`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peaf`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(500) NULL,
  `prenom` VARCHAR(500) NULL,
  `email` VARCHAR(500) NULL,
  `mdp` VARCHAR(500) NULL,
  `solde` DECIMAL(8,2) NULL,
  `controlp` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peaf`.`commerce`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peaf`.`commerce` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(500) NULL,
  `adresse` VARCHAR(500) NULL,
  `email` VARCHAR(500) NULL,
  `mdp` VARCHAR(500) NULL,
  `solde` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peaf`.`achat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peaf`.`achat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `commerce_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `date` DATETIME NULL,
  `montant` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id`, `commerce_id`, `client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_achat_commerce1_idx` (`commerce_id` ASC) VISIBLE,
  INDEX `fk_achat_client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_achat_commerce1`
    FOREIGN KEY (`commerce_id`)
    REFERENCES `peaf`.`commerce` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_achat_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `peaf`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peaf`.`offre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peaf`.`offre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `commerce_id` INT NOT NULL,
  `datedebut` DATETIME NULL,
  `datefin` DATETIME NULL,
  `pourcentage` DECIMAL(8,2) NULL,
  `remise` DECIMAL(8,2) NULL,
  `montantdepart` DECIMAL(8,2) NULL,
  `notation` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id`, `commerce_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_offre_commerce1_idx` (`commerce_id` ASC) VISIBLE,
  CONSTRAINT `fk_offre_commerce1`
    FOREIGN KEY (`commerce_id`)
    REFERENCES `peaf`.`commerce` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peaf`.`favoris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peaf`.`favoris` (
  `commerce_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`commerce_id`, `client_id`),
  INDEX `fk_favoris_client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_favoris_commerce`
    FOREIGN KEY (`commerce_id`)
    REFERENCES `peaf`.`commerce` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favoris_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `peaf`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peaf`.`acces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peaf`.`acces` (
  `commerce_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`commerce_id`, `client_id`),
  INDEX `fk_acces_client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_acces_commerce1`
    FOREIGN KEY (`commerce_id`)
    REFERENCES `peaf`.`commerce` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acces_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `peaf`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
