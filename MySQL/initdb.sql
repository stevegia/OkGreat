# DROP/CREATE DB
DROP DATABASE IF EXISTS testing_center_scheduler;

CREATE DATABASE testing_center_scheduler;

USE testing_center_scheduler;

/* Table for users of the system
The 'UserType' field specified Instructor, Administrator, or Student */
CREATE TABLE TCSUser (
	NetId VARCHAR(20) NOT NULL,
	Password VARCHAR(20),
	Email VARCHAR(255),
	FirstName VARCHAR(20),
	LastName VARCHAR(20),
	UserType ENUM('ADMINISTRATOR', 'INSTRUCTOR', 'STUDENT') NOT NULL,
	PRIMARY KEY (NetId),
	UNIQUE (Email)
);

/* Inserting dummy users into TCSUser table */
INSERT INTO TCSUser (NetId, Password, Email, FirstName, LastName, UserType)
VALUES ('admin', 'a123', 'admin@stonybrook.edu', 'Test', 'Admin', 'ADMINISTRATOR');
INSERT INTO TCSUser (NetId, Password, Email, FirstName, LastName, UserType)
VALUES ('instr', 'i123', 'instr@stonybrook.edu', 'Test', 'Instructor', 'INSTRUCTOR');
INSERT INTO TCSUser (NetId, Password, Email, FirstName, LastName, UserType)
VALUES ('student', 's123', 'student@stonybrook.edu', 'Test', 'Student', 'STUDENT');

/* Query for importing information from user.csv */
/*LOAD DATA LOCAL INFILE 'C:/Users/Haseeb/Desktop/user.csv'
INTO TABLE TCSUser
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(FirstName, LastName, NetID, Email)
SET Password = 'pass';*/

/* For testing, all users from user.csv are imported as Students */
/*UPDATE TCSUser SET UserType = 'Student';*/

/* Table for term information */
CREATE TABLE Term (
	Id INT NOT NULL,
    TermName VARCHAR(255),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (Id)
);

/* Inserting specific terms into Term table */
INSERT INTO Term (Id, TermName, StartDate, EndDate)
VALUES (1158, 'Fall 2015', '2015-08-24', '2015-12-16');
INSERT INTO Term (Id, TermName, StartDate, EndDate)
VALUES (1161, 'Winter 2016', '2016-01-05', '2016-01-22');
INSERT INTO Term (Id, TermName, StartDate, EndDate)
VALUES (1164, 'Spring 2016', '2016-01-25', '2016-05-18');
INSERT INTO Term (Id, TermName, StartDate, EndDate)
VALUES (1166, 'Summer 2016', '2016-05-31', '2016-08-20');
INSERT INTO Term (Id, TermName, StartDate, EndDate)
VALUES (1168, 'Fall 2016', '2016-08-29', '2016-12-21');

/* Table for class information */
CREATE TABLE TCSClass (
	Id INT NOT NULL AUTO_INCREMENT,
	UnrefinedId CHAR(10) NOT NULL,
    RefinedId CHAR(16) NOT NULL,
	Subject CHAR(3),
	CatalogNumber INT,
	Section CHAR(4),
	InstructorNetId VARCHAR(20),
    Version INT,
	PRIMARY KEY (Id),
    UNIQUE (UnrefinedId),
    UNIQUE (RefinedId),
	FOREIGN KEY (InstructorNetId)
		REFERENCES TCSUser (NetId)
);

/* Query for importing information from class.csv */
/*LOAD DATA LOCAL INFILE 'C:/Users/Haseeb/Desktop/class.csv'
INTO TABLE Course
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Id, Subject, CatalogNumber, Section, InstructorNetId);*/

/* Table for roster information */
CREATE TABLE Roster (
	NetId VARCHAR(20) NOT NULL,
	TCSClassUnrefinedId CHAR(10) NOT NULL,
    TermId INT,
    Version INT,
	PRIMARY KEY (NetId, TCSClassUnrefinedId),
	FOREIGN KEY (NetId)
		REFERENCES TCSUser (NetId),
	FOREIGN KEY (TCSClassUnrefinedId)
		REFERENCES TCSClass (UnrefinedId)
		ON DELETE CASCADE,
	FOREIGN KEY (TermId)
		REFERENCES Term (Id)
        ON DELETE CASCADE
);

/* Query for importing information from roster.csv */
/*LOAD DATA LOCAL INFILE 'C:/Users/Haseeb/Desktop/roster.csv'
INTO TABLE Roster
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(NetID, CourseId);*/

/* Table for testiing center information */
CREATE TABLE TestingCenter (
	Id INT NOT NULL AUTO_INCREMENT,
	NumberOfSeats INT,
	NumberofSetAsideSeats INT,
	GapTime INT,
	ReminderInterval INT,
    CurrentTerm INT,
	PRIMARY KEY (Id),
    FOREIGN KEY (CurrentTerm)
		REFERENCES Term (Id)
);

/* Inserting a tuple into the TestingCenter table */
INSERT INTO TestingCenter (NumberOfSeats, NumberofSetAsideSeats, GapTime, ReminderInterval, CurrentTerm)
VALUES (64, 10, 30, 30, 1158);

/* Table for testing center hours of operation.
Since the hours can change on a day-by-day basis, each day of the term is a tuple in the table */
CREATE TABLE TestingCenterHours (
	TestingCenterId INT NOT NULL,
	OpenDate DATE NOT NULL,
	StartTime TIME,
	EndTime TIME,
    Version INT,
	PRIMARY KEY (TestingCenterId, OpenDate),
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
		ON DELETE CASCADE
);

/* Table for the dates in which the testing center is closed */
CREATE TABLE ClosedDates (
	TestingCenterId INT NOT NULL,
	ClosedDate DATE,
    Version INT,
	PRIMARY KEY (TestingCenterId, ClosedDate),
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
		ON DELETE CASCADE
);

/* Table for exam information */
CREATE TABLE Exam (
	Id INT NOT NULL AUTO_INCREMENT,
	RefinedId CHAR(20) NOT NULL,
	ExamType ENUM('AD-HOC', 'COURSE') NOT NULL,
	InstructorNetId VARCHAR(20),
	ExamName VARCHAR(255),
	TestingCenterId INT,
	NumberOfStudents INT,
	NumberOfAppointments INT,
	ExamStatus VARCHAR(15),
	StartDate DATETIME,
	EndDate DATETIME,
	Duration INT,
    TermId INT,
    Version INT,
	PRIMARY KEY (Id),
    UNIQUE (RefinedId),
	FOREIGN KEY (InstructorNetId)
		REFERENCES TCSUser (NetId),
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id),
	FOREIGN KEY (TermId)
		REFERENCES Term (Id)
);

/* Table for course exam information */
CREATE TABLE CourseExam (
	ExamRefinedId CHAR(20) NOT NULL,
	TCSClassRefinedId CHAR(16) NOT NULL,
    Version INT,
	PRIMARY KEY (ExamRefinedId, TCSClassRefinedId),
	FOREIGN KEY (ExamRefinedId)
		REFERENCES Exam (RefinedId)
		ON DELETE CASCADE,
	FOREIGN KEY (TCSClassRefinedId)
		REFERENCES TCSClass (RefinedId)
		ON DELETE CASCADE
);

/* Table for Ad-Hoc Exam information.
Since Ad-Hoc Exams require a list of students, each student is a tuple in this table */
CREATE TABLE AdHocExam (
	ExamRefinedId CHAR(20) NOT NULL,
	StudentNetId VARCHAR(20) NOT NULL,
    StudentFirstName VARCHAR(20),
	StudentLastName VARCHAR(20),
    Version INT,
	PRIMARY KEY (ExamRefinedId, StudentNetId),
	FOREIGN KEY (ExamRefinedId)
		REFERENCES Exam (RefinedId)
		ON DELETE CASCADE,
	FOREIGN KEY (StudentNetId)
		REFERENCES TCSUser (NetId)
		ON DELETE CASCADE
);

/* Table for Appointment information */
CREATE TABLE Appointment (
	Id INT NOT NULL AUTO_INCREMENT,
	StudentNetId VARCHAR(20),
	StartDate DATETIME,
    EndDate DATETIME,
	ExamRefinedId CHAR(20),
	TestingCenterId INT,
	AppointmentStatus VARCHAR(15),
    TermId INT,
    SeatNumber INT,
    Version INT,
	PRIMARY KEY (Id),
	FOREIGN KEY (StudentNetId)
		REFERENCES TCSUser (NetId)
		ON DELETE CASCADE,
	FOREIGN KEY (ExamRefinedId)
		REFERENCES Exam (RefinedId)
		ON DELETE CASCADE,
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
        ON DELETE CASCADE,
	FOREIGN KEY (TermId)
		REFERENCES Term (Id)
);


/*Everday */
INSERT INTO TestingCenterHours VALUES (1, '2015-01-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-01-31', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-02-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-03-31', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-04-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-05-31', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-06-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-07-31', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-31', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-09-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-10-31', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-1', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-2', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-3', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-4', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-5', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-6', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-7', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-8', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-9', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-10', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-11', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-12', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-13', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-14', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-15', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-16', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-17', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-18', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-19', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-20', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-21', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-22', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-23', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-24', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-25', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-26', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-27', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-12-31', '00:00:00', '23:00:00', 1);



INSERT INTO TCSClass (UnrefinedId, RefinedId, Subject, CatalogNumber, Section, InstructorNetId)
VALUES ('88222-1158', 'AAS102-1_1158', 'AAS', 102, '1', 'instr');

INSERT INTO Roster (NetId, TCSClassUnrefinedId, TermId)
VALUES ('student', '88222-1158', 1158);

INSERT INTO Exam (RefinedId, ExamType, InstructorNetId, ExamName, TestingCenterId, NumberOfStudents, NumberOfAppointments, ExamStatus, StartDate, EndDate, Duration, TermId)
VALUES ('AAS102-1_1158_ex1', 'COURSE', 'instr', 'AA Exam 1', 1, 10, 0, 'APPROVED', '2015-11-05 12:00:00', '2015-12-10 15:00:00', 80, 1158);

INSERT INTO CourseExam (ExamRefinedId, TCSClassRefinedId)
VALUES ('AAS102-1_1158_ex1', 'AAS102-1_1158');

INSERT INTO Appointment (Id, StudentNetId, StartDate, EndDate, ExamRefinedId, TestingCenterId, AppointmentStatus, TermId, SeatNumber, Version)
VALUES (1, 'student', '2015-11-22 00:00:00', '2015-11-22 10:00:00', 1, 1, 'APPROVED', 1158, 1, 1);
INSERT INTO Appointment (Id, StudentNetId, StartDate, EndDate, ExamRefinedId, TestingCenterId, AppointmentStatus, TermId, SeatNumber, Version)
VALUES (1, 'student', '2015-11-22 00:00:00', '2015-11-22 10:00:00', 1, 1, 'APPROVED', 1158, 1, 1);


