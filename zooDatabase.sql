##Zoo database
CREATE DATABASE zoo;

USE zoo;

-- -----------------------------------------------------
-- Table environment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS environment (
  idEnvironment INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45),
  temperature INT,
  foliage VARCHAR(45),
  PRIMARY KEY (idEnvironment));

-- -----------------------------------------------------
-- Table species
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS species (
  idSpecies INT NOT NULL AUTO_INCREMENT,
  diet VARCHAR(45),
  preferredClimate VARCHAR(45),
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (idSpecies));

-- -----------------------------------------------------
-- Table employee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS employee (
  idEmployee INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45),
  salary INT,
  role ENUM('Manager', 'Keeper', 'Veterinarian'),
  PRIMARY KEY (idEmployee));


-- -----------------------------------------------------
-- Table location
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS location (
  idLocation INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (idLocation));


-- -----------------------------------------------------
-- Table exhibit
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS exhibit (
  idExhibit INT NOT NULL AUTO_INCREMENT,
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
  idmedicalHistory INT NOT NULL AUTO_INCREMENT,
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
  idAnimal INT NOT NULL AUTO_INCREMENT,
  idSpeciesAn INT,
  idMedicalHistoryAn INT,
  animalName VARCHAR(45) NOT NULL,
  performs BOOLEAN,
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
  idrecomendation INT NOT NULL AUTO_INCREMENT,
  idmedicalHistory INT,
  recomendation VARCHAR(45),
  PRIMARY KEY (idrecomendation),
  CONSTRAINT idmedicalHistory
    FOREIGN KEY (idmedicalHistory)
    REFERENCES medicalHistory (idmedicalHistory));



-- -----------------------------------------------------
-- Triggers
-- -----------------------------------------------------
#
DELIMITER //

CREATE TRIGGER inc_num_animals AFTER INSERT ON animal
	FOR EACH ROW
	BEGIN
	UPDATE exhibit SET exhibit.numOfAnimals = exhibit.numOfAnimals +1 WHERE exhibit.idExhibit = NEW.idExhibitAn;
	END;//

DELIMITER ;

DELIMITER //

CREATE TRIGGER dec_num_animals AFTER DELETE ON animal
	FOR EACH ROW
	BEGIN
	UPDATE exhibit SET exhibit.numOfAnimals = numOfAnimals -1 WHERE exhibit.idExhibit = OLD.idExhibitAn;
	END;//

DELIMITER ;


SET SQL_SAFE_UPDATES = 0;

INSERT INTO environment (name,temperature,foliage) VALUE ("test",1,"test1");
INSERT INTO employee (name, salary, role) VALUE ("Test", 1, 'Manager');
INSERT INTO location (name) VALUE ("test2");

INSERT INTO exhibit (idEnvironment, openingTime, closingTime, numOfAnimals, employeeId, idLocation, description) 
VALUE (1, NOW(), NOW(), 0, 1, 1, "exhibit");

INSERT INTO species (diet, preferredClimate, name) VALUE ("tes","est","est1");

INSERT INTO medicalhistory (idVet, lastCheckUp) VALUE (1, NOW());

INSERT INTO animal (idSpeciesAn, idMedicalHistoryAn, animalName, perfoms, idExhibitAn) VALUE (1,1,"test",FALSE,2);

#DELETE FROM animal WHERE idAnimal = 5;

