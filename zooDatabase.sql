##Zoo database
drop database if exists zoo;

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
<<<<<<< HEAD
  idEmployee INT NOT NULL,
  empName VARCHAR(45) NOT NULL,
  salary INT NULL,
  role ENUM('Manager', 'Keeper', 'Veterinarian') NULL,
  PRIMARY KEY (idEmployee),
  UNIQUE INDEX idEmployee_UNIQUE (idEmployee ASC));
=======
  idEmployee INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45),
  salary INT,
  role ENUM('Manager', 'Keeper', 'Veterinarian'),
  PRIMARY KEY (idEmployee));
>>>>>>> master


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
<<<<<<< HEAD
  idExhibit INT NOT NULL,
  exhibitName varchar(45) not null,
  idEnvironment INT NULL,
  openingTime DATE NULL,
  closingTime DATE NULL,
  numOfAnimals INT default 0,
  employeeId INT NULL,
  idLocation INT NULL,
  description VARCHAR(45) NULL,
=======
  idExhibit INT NOT NULL AUTO_INCREMENT,
  idEnvironment INT,
  openingTime DATE,
  closingTime DATE,
  numOfAnimals INT NOT NULL,
  employeeId INT,
  idLocation INT,
  description VARCHAR(45),
>>>>>>> master
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


<<<<<<< HEAD
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
-- Insert new elements into tables
-- -----------------------------------------------------
drop procedure if exists addAnimal;

DELIMITER // 

create procedure addAnimal(
idA int,
aName varchar(45)
)

begin
 insert into animal(idAnimal, animalName)
 values (idA, aName);
end //

DELIMITER ;

drop procedure if exists addExhibit;

DELIMITER // 

create procedure addExhibit(
idE int,
eName varchar(45)
)

begin
 insert into exhibit(idExhibit, exhibitName)
 values (idE, eName);
end //

DELIMITER ;


drop procedure if exists addEmployee;

DELIMITER // 

create procedure addEmployee(
idE int,
eName varchar(45)
)

begin
 insert into employee(idEmployee, empName)
 values (idE, eName);
end //

DELIMITER ;

-- -----------------------------------------------------
-- update Foreign key objects
-- -----------------------------------------------------
=======

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

>>>>>>> master
