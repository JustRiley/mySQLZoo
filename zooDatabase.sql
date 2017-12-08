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
  empName VARCHAR(45) NOT NULL,
  salary INT,
  role ENUM('Manager', 'Keeper', 'Veterinarian'),
  PRIMARY KEY (idEmployee),
  UNIQUE INDEX idEmployee_UNIQUE (idEmployee ASC));


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
  exhibitName varchar(45) not null,
  idEnvironment INT,
  openingTime DATE,
  closingTime DATE,
  numOfAnimals INT default 0,
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

drop procedure if exists addEnvironment;

DELIMITER // 

create procedure addEnviornment(
enviName varchar(45),
temp int,
envioFoliage varchar(45)
)

begin
 insert into environment(name, temperature, foliage)
 values (enviName, temp, enviFoliage);
end //

DELIMITER ;

drop procedure if exists removeEmp

DELIMITER //
 
create procedure removeEmp(
eName varchar(45)
)

begin
 DELETE FROM employee WHERE empName LIKE eName;
end //

DELIMITER ;

drop procedure if exists removeEmp

DELIMITER //
 
create procedure removeEnvironment(
eName varchar(45)
)

begin
 DELETE FROM environment WHERE name LIKE eName;
end //

DELIMITER ;


-- -----------------------------------------------------
-- update Foreign key objects
-- -----------------------------------------------------

-- add given animal to an exhibit
/*
drop procedure if exists addToExhibit;

DELIMITER //

create procedure addToExhibit(
aID int)
begin

update 
end //

DELIMITER ;
*/

drop procedure if exists updateEmployee;

DELIMITER //

create procedure updateEmployee(
eName varchar(45), eSalary int, eRole varchar(45), idE int)

begin
update employee
set empName = eName, salary = eSalary, role = eRole
where idEmployee = idE;
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


SET SQL_SAFE_UPDATES = 0;

-- -----------------------------------------------------
-- Sample Data
-- -----------------------------------------------------

-- exhibits
INSERT INTO exhibit (idExhibit, exhibitName, openingTime, closingTime)
values (1, 'Amazon', 8, 5);

INSERT INTO exhibit (idExhibit, exhibitName, openingTime, closingTime)
values (2, 'Safari', 8, 5);

INSERT INTO exhibit (idExhibit, exhibitName, openingTime, closingTime)
values (3, 'Arctic', 8, 5);

-- environment
INSERT INTO environment (name,temperature,foliage) 
VALUES('Forest', 75, 'tropical');

INSERT INTO environment (name,temperature,foliage) 
VALUES('Flatlands', 65, 'Desert');

INSERT INTO environment (name,temperature,foliage) 
VALUES('Icelands', 10, 'Arid');

-- employees
INSERT INTO employee (idEmployee, name, salary, role) 
VALUES (0001, 'Alice', 67000, 'Manager');

INSERT INTO employee (idEmployee, name, salary, role) 
VALUES (1001, 'Bob', 54000, 'Keeper');
INSERT INTO employee (idEmployee, name, salary, role) 
VALUES (1002, 'Claire', 54000, 'Keeper');

INSERT INTO employee (idEmployee, name, salary, role) 
VALUES (2001, 'Alex', 75000, 'Veterinarian');


-- locations
INSERT INTO location (name) VALUES ('Monkey');
INSERT INTO location (name) VALUES ('Felines');
INSERT INTO location (name) VALUES ('Arctic');

-- species
INSERT INTO species (idSpecies, diet, preferredClimate, name) 
VALUES (1, 'fruits','savannah','baboon');
INSERT INTO species (diet, preferredClimate, name) 
VALUES (2, 'insects','tropics','toucan');
INSERT INTO species (diet, preferredClimate, name) 
VALUES (3, 'fish','polar','penguin');

-- med History
INSERT INTO medicalhistory (idVet, lastCheckUp) VALUE (2001, 10/11/2017);

-- animals 

INSERT INTO animal (idSpeciesAn, animalName, perfoms, idExhibitAn)
VALUE (1,'bobo', TRUE, 2);
INSERT INTO animal (idSpeciesAn, animalName, perfoms, idExhibitAn)
VALUE (2,'Tony', FALSE, 1);
INSERT INTO animal (idSpeciesAn, animalName, perfoms, idExhibitAn)
VALUE (3,'Pearl', FALSE, 3);

#DELETE FROM animal WHERE idAnimal = 5;

