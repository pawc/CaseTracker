CREATE DATABASE CaseTracker;

CREATE TABLE CaseTracker.incidents (
	id INT NOT NULL AUTO_INCREMENT,
	latitude DECIMAL(7, 5),
	longitude DECIMAL(7, 5),
	address VARCHAR(200),
	region VARCHAR(20) NOT NULL,
	incidentDate DATE NOT NULL,
	followUpDate DATE,
	followedUp BOOLEAN NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE CaseTracker.defendants (
	indexID INT NOT NULL AUTO_INCREMENT,
	id VARCHAR(13),
	firstName VARCHAR(20), 
	lastName VARCHAR(20) NOT NULL,
	address VARCHAR(200),
	telephoneNumber VARCHAR(15),
	emailAddress VARCHAR(50),
	secondOffence BOOLEAN NOT NULL,
	PRIMARY KEY (indexID)
);

CREATE TABLE CaseTracker.vehicles (
	registration VARCHAR(15) NOT NULL,
	owner INT NOT NULL, 
	make VARCHAR(20),
	colour VARCHAR(15),
	isTrailer BOOLEAN NOT NULL,
	PRIMARY KEY (registration),
	INDEX fk_Vehicel (owner),
	CONSTRAINT fk_Vehicle FOREIGN KEY (owner) REFERENCES CaseTracker.defendants (indexID)
);

CREATE TABLE CaseTracker.complainants (
	indexID INT NOT NULL AUTO_INCREMENT,
	id VARCHAR(13),
	firstName VARCHAR(20), 
	lastName VARCHAR(20) NOT NULL,
	address VARCHAR(200),
	telephoneNumber VARCHAR(15),
	emailAddress VARCHAR(50),
	PRIMARY KEY (indexID)
);

CREATE TABLE CaseTracker.staff (
	id INT NOT NULL AUTO_INCREMENT,
	firstName VARCHAR(20),
	lastName VARCHAR(20) NOT NULL,
	department VARCHAR(20) NOT NULL,
	position VARCHAR(20),
	username VARCHAR(20),
	passwordHash BIGINT NOT NULL,
	salt BIGINT NOT NULL,
	permissions INT NOT NULL,
	PRIMARY KEY (id)
);

/* TODO: Beta
CREATE TABLE CaseTracker.inspectors (
id INT NOT NULL AUTO_INCREMENT,
inspectorID INT NOT NULL,
society VARCHAR (50),
AuthorityNumber VARCHAR (20),
speciality VARCHAR (50),
PRIMARY KEY (id),
INDEX fk_InspectorID (inspectorID),
CONSTRAINT fk_InspectorID FOREIGN KEY (inspectorID) REFERENCES CaseTracker.staff (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);*/

CREATE TABLE CaseTracker.cases (
	caseNumber VARCHAR(12) NOT NULL,
	reference VARCHAR(30) NOT NULL,
	caseType VARCHAR(20) NOT NULL,
	details VARCHAR(500) NULL DEFAULT NULL,
	animalsInvolved VARCHAR(500) NOT NULL,
	staffID INT(11) NOT NULL,
	incidentID INT(11) NOT NULL,
	defendantID INT NOT NULL,
	complainantID INT NOT NULL,
	nextCourtDate DATE,
	outcome VARCHAR(255),
	returnVisit BOOLEAN NOT NULL,
	returnDate DATE,
	PRIMARY KEY (caseNumber),
	INDEX fk_ComplainantID (complainantID),
	INDEX fk_DefendantID (defendantID),
	INDEX fk_IncidentID (incidentID),
	INDEX fk_StaffID (staffID),
	CONSTRAINT fk_ComplainantID FOREIGN KEY (complainantID) REFERENCES CaseTracker.complainants (indexID) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_DefendantID FOREIGN KEY (defendantID) REFERENCES CaseTracker.defendants (indexID) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_IncidentID FOREIGN KEY (incidentID) REFERENCES CaseTracker.incidents (id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_StaffID FOREIGN KEY (staffID) REFERENCES CaseTracker.staff (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE CaseTracker.evidence (
	id INT NOT NULL AUTO_INCREMENT,
	fileLocation VARCHAR(255) NOT NULL,
	description VARCHAR(255),
	caseNumber VARCHAR(12) NOT NULL,
	PRIMARY KEY (id),
	INDEX fk_CaseNumber (caseNumber),
	CONSTRAINT fk_CaseNumber FOREIGN KEY (caseNumber) REFERENCES CaseTracker.cases (caseNumber) ON UPDATE RESTRICT ON DELETE RESTRICT
);

INSERT INTO CaseTracker.staff VALUES (NULL, 'root', 'root', 'System', 'Admin', 'root', -634923903, 3227621176210808074, 0);
INSERT INTO CaseTracker.staff VALUES (NULL, 'inspector', 'inspector', 'inspector', 'inspector', 'inspector', -5922475058343094375, -5922475058261058398, 1);
