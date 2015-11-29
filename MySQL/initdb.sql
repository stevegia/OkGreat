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
INSERT INTO TestingCenterHours VALUES (1, '2015-08-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-29', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-08-30', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-28', '00:00:00', '23:00:00', 1);
INSERT INTO TestingCenterHours VALUES (1, '2015-11-29', '00:00:00', '23:00:00', 1);


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
INSERT INTO Exam VALUES (1, 1, 'COURSE', 'instr', 'Sup', 1, 5, 6, 'APPROVED', '2015-08-24', '2015-12-16', 77, 1158, 1);
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
		REFERENCES TCSUser (NetId),
	FOREIGN KEY (ExamRefinedId)
		REFERENCES Exam (RefinedId)
		ON DELETE CASCADE,
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
        ON DELETE CASCADE,
	FOREIGN KEY (TermId)
		REFERENCES Term (Id));
INSERT INTO Appointment (Id, StudentNetId, StartDate, EndDate, ExamRefinedId, TestingCenterId, AppointmentStatus, TermId, SeatNumber, Version)
VALUES (1, 'student', '2015-08-28 00:00:00', '2015-12-02 00:00:00', 1, 1, 'APPROVED', 1158, 1, 1);
INSERT INTO Appointment (Id, StudentNetId, StartDate, EndDate, ExamRefinedId, TestingCenterId, AppointmentStatus, TermId, SeatNumber, Version)
VALUES (2, 'student', '2015-08-30 00:00:00', '2015-10-02 00:00:00', 1, 1, 'APPROVED', 1158, 1, 1);
