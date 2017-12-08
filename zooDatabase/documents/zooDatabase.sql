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
  exhibitName VARCHAR(45),
  idEnvironment INT,
  openingTime DATE,
  closingTime DATE,
  numOfAnimals INT NOT NULL default 0,
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
-- Procedures
-- -----------------------------------------------------



DELIMITER // 

create procedure addEmployee(
eName varchar(45), salary INT, role ENUM('Manager', 'Keeper', 'Veterinarian')
)

begin
 insert into employee(name, salary, role)
 values (eName, salary, role);
end //

DELIMITER ;


DELIMITER // 

create procedure removeEmployee(
eName varchar(45)
)

begin
 DELETE FROM employee WHERE name LIKE eName;
end //

DELIMITER ;

DELIMITER // 

create procedure addAnimal(
aName varchar(45), speciesKey INT, medicalHistKey INT, exhibitKey INT, performs BOOLEAN)

begin
 insert into animal(animalName, idSpeciesAn, idMedicalHistoryAn, idExhibitAn, performs)
 values (aName, speciesKey, medicalHistKey, exhibitKey, performs);
end //

DELIMITER ;


DELIMITER // 

create procedure removeAnimal(
aName varchar(45)
)

begin
 DELETE FROM animal WHERE animalName LIKE aName;
end //

DELIMITER ;

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


DELIMITER //

create procedure updateEmployee(
eName varchar(45), eSalary int, eRole ENUM('Manager', 'Keeper', 'Veterinarian'))

begin
update employee
set name = eName, salary = eSalary, role = eRole
where name = eName;
end //

DELIMITER ;


SET SQL_SAFE_UPDATES = 0;



-- environment
INSERT INTO environment (name,temperature,foliage) 
VALUES('Forest', 75, 'tropical');

INSERT INTO environment (name,temperature,foliage) 
VALUES('Flatlands', 65, 'Desert');

INSERT INTO environment (name,temperature,foliage) 
VALUES('Icelands', 10, 'Arid');

-- employees
INSERT INTO employee (name, salary, role) 
VALUES ('Alice', 67000, 'Manager');

INSERT INTO employee (name, salary, role) 
VALUES ('Bob', 54000, 'Keeper');
INSERT INTO employee (name, salary, role) 
VALUES ('Claire', 54000, 'Keeper');

INSERT INTO employee (name, salary, role) 
VALUES ('Alex', 75000, 'Veterinarian');


-- locations
INSERT INTO location (name) VALUES ('Monkey');
INSERT INTO location (name) VALUES ('Felines');
INSERT INTO location (name) VALUES ('Arctic');

-- species
INSERT INTO species (diet, preferredClimate, name) 
VALUES ('fruits','savannah','baboon');
INSERT INTO species (diet, preferredClimate, name) 
VALUES ('insects','tropics','toucan');
INSERT INTO species (diet, preferredClimate, name) 
VALUES ('fish','polar','penguin');

-- med History
INSERT INTO medicalHistory (idVet, lastCheckUp) VALUE (1, 10/11/2017);


-- exhibits
INSERT INTO exhibit (exhibitName, openingTime, closingTime, numOfAnimals, employeeId, idLocation, description)
values ('Amazon', NOW(), NOW(), 0, 1, 1, 'Forest');

INSERT INTO exhibit (exhibitName, openingTime, closingTime, numOfAnimals, employeeId, idLocation, description)
values ('Safari', NOW(), NOW(), 0, 1, 1, 'Plains');

INSERT INTO exhibit (exhibitName, openingTime, closingTime, numOfAnimals, employeeId, idLocation, description)
values ('Arctic', NOW(), NOW(), 0, 1,1, 'Icy');


-- animals 

INSERT INTO animal (idSpeciesAn, animalName, performs, idExhibitAn, idMedicalHistoryAn)
VALUE (1,'bobo', TRUE, 2, 1);
INSERT INTO animal (idSpeciesAn, animalName, performs, idExhibitAn, idMedicalHistoryAn)
VALUE (2,'Tony', FALSE, 1, 1);
INSERT INTO animal (idSpeciesAn, animalName, performs, idExhibitAn, idMedicalHistoryAn)
VALUE (3,'Pearl', FALSE, 3, 1);