-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema meeting_setter
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema meeting_setter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `meeting_setter` DEFAULT CHARACTER SET utf8 ;
USE `meeting_setter` ;

-- -----------------------------------------------------
-- Table `meeting_setter`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meeting_setter`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `cell_number` VARCHAR(50) NOT NULL,
  `questions_comments` VARCHAR(500) NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meeting_setter`.`client_business`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meeting_setter`.`client_business` (
  `business_name` VARCHAR(50) NOT NULL,
  `website` VARCHAR(50) NOT NULL,
  `annual_revenue` INT NOT NULL,
  `clients_client_id` INT NOT NULL,
  PRIMARY KEY (`clients_client_id`),
  CONSTRAINT `fk_client_business_clients1`
    FOREIGN KEY (`clients_client_id`)
    REFERENCES `meeting_setter`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meeting_setter`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meeting_setter`.`locations` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `location_address` VARCHAR(255) NOT NULL,
  `location_size` VARCHAR(50) NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meeting_setter`.`meetings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meeting_setter`.`meetings` (
  `meeting_id` INT NOT NULL AUTO_INCREMENT,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `duration_in_minutes` TIME NOT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`meeting_id`, `location_id`),
  INDEX `fk_meetings_location1_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `fk_meetings_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `meeting_setter`.`locations` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `meeting_setter`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meeting_setter`.`bookings` (
  `client_id` INT NOT NULL,
  `meeting_id` INT NOT NULL,
  `business_type` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`client_id`, `meeting_id`),
  INDEX `fk_bookings_clients_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_clients`
    FOREIGN KEY (`client_id`)
    REFERENCES `meeting_setter`.`clients` (`client_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bookings_meetings`
    FOREIGN KEY ()
    REFERENCES `meeting_setter`.`meetings` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meeting_setter`.`chairpersons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meeting_setter`.`chairpersons` (
  `employee_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meeting_setter`.`chairperson_for_meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meeting_setter`.`chairperson_for_meeting` (
  `employee_id` INT NULL,
  `meeting_id` INT NOT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `meeting_id`, `location_id`),
  INDEX `fk_chairperson_for_meeting_meetings1_idx` (`meeting_id` ASC, `location_id` ASC) VISIBLE,
  CONSTRAINT `fk_chairperson_for_meeting_chairperson1`
    FOREIGN KEY ()
    REFERENCES `meeting_setter`.`chairpersons` ()
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_chairperson_for_meeting_meetings1`
    FOREIGN KEY (`meeting_id` , `location_id`)
    REFERENCES `meeting_setter`.`meetings` (`meeting_id` , `location_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
