##Zoo database
drop database if exists zoo;

CREATE DATABASE zoo;

USE zoo;

-- -----------------------------------------------------
-- Table environment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS environment (
  idEnvironment INT NOT NULL,
  name VARCHAR(45) NULL,
  temperature INT NULL,
  foliage VARCHAR(45) NULL,
  PRIMARY KEY (idEnvironment));

-- -----------------------------------------------------
-- Table species
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS species (
  idSpecies INT NOT NULL,
  diet VARCHAR(45) NULL,
  preferredClimate VARCHAR(45) NULL,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (idSpecies));

-- -----------------------------------------------------
-- Table employee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS employee (
  idEmployee INT NOT NULL,
  name VARCHAR(45) NULL,
  salary INT NULL,
  role ENUM('Manager', 'Keeper', 'Veterinarian') NULL,
  PRIMARY KEY (idEmployee),
  UNIQUE INDEX idEmployee_UNIQUE (idEmployee ASC));


-- -----------------------------------------------------
-- Table location
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS location (
  idLocation INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (idLocation),
  UNIQUE INDEX name_UNIQUE (name ASC));


-- -----------------------------------------------------
-- Table exhibit
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS exhibit (
  idExhibit INT NOT NULL,
  idEnvironment INT NULL,
  openingTime DATE NULL,
  closingTime DATE NULL,
  numOfAnimals INT NOT NULL,
  employeeId INT NULL,
  idLocation INT NULL,
  description VARCHAR(45) NULL,
  PRIMARY KEY (idExhibit),
  CONSTRAINT idEnvironment
    FOREIGN KEY (idEnvironment)
    REFERENCES environment (idEnvironment),
  CONSTRAINT employeeId
    FOREIGN KEY (employeeId)
    REFERENCES employee (idEmployee),
  CONSTRAINT idLocation
    FOREIGN KEY (idLocation)
    REFERENCES location (idLocation));


-- -----------------------------------------------------
-- Table medicalHistory
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS medicalHistory (
  idmedicalHistory INT NOT NULL,
  idVet INT NULL,
  lastCheckUp DATE NULL,
  PRIMARY KEY (idmedicalHistory),
  CONSTRAINT idVet
    FOREIGN KEY (idVet)
    REFERENCES employee (idEmployee));

-- -----------------------------------------------------
-- Table animal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS animal (
  idAnimal INT NOT NULL,
  idSpeciesAn INT NULL,
  idMedicalHistoryAn INT NULL,
  animalName VARCHAR(45) NOT NULL,
  perfoms TINYINT NULL,
  idExhibitAn INT NULL,
  PRIMARY KEY (idAnimal),
  CONSTRAINT idSpeciesAn
    FOREIGN KEY (idSpeciesAn)
    REFERENCES species (idSpecies),
  CONSTRAINT idMedicalHistoryAn
    FOREIGN KEY (idMedicalHistoryAn)
    REFERENCES medicalHistory (idmedicalHistory),
  CONSTRAINT idExhibitAn
    FOREIGN KEY (idExhibitAn)
    REFERENCES exhibit (idExhibit));

-- -----------------------------------------------------
-- Table recomendations
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS recomendations (
  idrecomendation INT NOT NULL,
  idmedicalHistory INT NULL,
  recomendation VARCHAR(45) NULL,
  PRIMARY KEY (idrecomendation),
  CONSTRAINT idmedicalHistory
    FOREIGN KEY (idmedicalHistory)
    REFERENCES medicalHistory (idmedicalHistory));


-- -----------------------------------------------------
-- Procedures for reading operations
-- -----------------------------------------------------
drop procedure if exists getMedical;

DELIMITER //

create procedure getMedical()
begin

-- select 

end //

DELIMITER ;


-- -----------------------------------------------------
-- Supported Triggers 
-- -----------------------------------------------------
