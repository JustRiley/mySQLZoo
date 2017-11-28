##Zoo database
CREATE DATABASE zoo;

USE zoo;

-- -----------------------------------------------------
-- Table environment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS environment (
  idEnvironment INT NOT NULL,
  name VARCHAR(45),
  temperature INT,
  foliage VARCHAR(45),
  PRIMARY KEY (idEnvironment));

-- -----------------------------------------------------
-- Table species
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS species (
  idSpecies INT NOT NULL,
  diet VARCHAR(45) NULL,
  preferredClimate VARCHAR(45),
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (idSpecies));

-- -----------------------------------------------------
-- Table employee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS employee (
  idEmployee INT NOT NULL,
  name VARCHAR(45),
  salary INT,
  role ENUM('Manager', 'Keeper', 'Veterinarian'),
  PRIMARY KEY (idEmployee);


-- -----------------------------------------------------
-- Table location
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS location (
  idLocation INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (idLocation);


-- -----------------------------------------------------
-- Table exhibit
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS exhibit (
  idExhibit INT NOT NULL,
  idEnvironment INT,
  openingTime DATE,
  closingTime DATE,
  numOfAnimals INT NOT NULL,
  employeeId INT,
  idLocation INT,
  description VARCHAR(45),
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
  idVet INT,
  lastCheckUp DATE,
  PRIMARY KEY (idmedicalHistory),
  CONSTRAINT idVet
    FOREIGN KEY (idVet)
    REFERENCES employee (idEmployee));

-- -----------------------------------------------------
-- Table animal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS animal (
  idAnimal INT NOT NULL,
  idSpeciesAn INT,
  idMedicalHistoryAn INT,
  animalName VARCHAR(45) NOT NULL,
  perfoms BOOLEAN,
  idExhibitAn INT,
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
  idmedicalHistory INT,
  recomendation VARCHAR(45),
  PRIMARY KEY (idrecomendation),
  CONSTRAINT idmedicalHistory
    FOREIGN KEY (idmedicalHistory)
    REFERENCES medicalHistory (idmedicalHistory));

