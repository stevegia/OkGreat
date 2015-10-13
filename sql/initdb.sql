/* Table for users of the system
The 'UserType' field specified Instructor, Administrator, or Student */
CREATE TABLE TCSUser (
	NetId VARCHAR(20) NOT NULL,
	Password VARCHAR(20),
	Email VARCHAR(30),
	FirstName VARCHAR(20),
	LastName VARCHAR(20),
	UserType CHAR(15),
	PRIMARY KEY (NetId),
	UNIQUE (Email)
);

/* Inserting dummy user into TCSUser table */
INSERT INTO TCSUser (NetId, Password, Email, FirstName, LastName, UserType)
VALUES ('akwok', 'pass123', 'akwok@stonybrook.edu', 'Antony', 'Kwok', 'Student');
INSERT INTO TCSUser (NetId, Password, Email, FirstName, LastName, UserType)
VALUES ('sgia', 'pass123', 'sgia@stonybrook.edu', 'Steven', 'Gia', 'Instructor');
INSERT INTO TCSUser (NetId, Password, Email, FirstName, LastName, UserType)
VALUES ('hshahid', 'pass123', 'hshahid@stonybrook.edu', 'Haseeb', 'Shahid', 'Admin');
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

/* Table for course information */
CREATE TABLE Course (
	Id CHAR(10) NOT NULL,
	Subject CHAR(3),
	CatalogNumber INT,
	Section CHAR(5),
	InstructorNetId VARCHAR(20),
	PRIMARY KEY (Id),
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
	CourseID CHAR(10) NOT NULL,
	PRIMARY KEY (NetId, CourseId),
	FOREIGN KEY (NetId)
		REFERENCES TCSUser (NetId),
	FOREIGN KEY (CourseId)
		REFERENCES Course (Id)
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
	PRIMARY KEY (Id)
);

/* Table for testing center hours of operation.
Since the hours can change on a day-by-day basis, each day of the term is a tuple in the table */
CREATE TABLE TestingCenterHours (
	TestingCenterId INT NOT NULL,
	OpenDate DATE,
	StartTime TIME,
	EndTime TIME,
	PRIMARY KEY (TestingCenterId, OpenDate),
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
		ON DELETE CASCADE
);

/* Table for the dates in which the testing center is closed */
CREATE TABLE ClosedDates (
	TestingCenterId INT NOT NULL,
	ClosedDate DATE,
	PRIMARY KEY (TestingCenterId, ClosedDate),
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
		ON DELETE CASCADE
);

/* Table for exam information */
CREATE TABLE Exam (
	Id CHAR(15) NOT NULL,
	ExamType CHAR(6),
	InstructorNetId VARCHAR(20),
	Name VARCHAR(20),
	TestingCenterId INT,
	NumberOfStudents INT,
	NumberOfAppointments INT,
	Status VARCHAR(15),
	StartDate DATETIME,
	EndDate DATETIME,
	Duration INT,
	PRIMARY KEY (Id),
	FOREIGN KEY (InstructorNetId)
		REFERENCES TCSUser (NetId),
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
);

/* Table for course exam information */
CREATE TABLE CourseExam (
	ExamId CHAR(15) NOT NULL,
	CourseId CHAR(10) NOT NULL,
	Section CHAR(5),
	PRIMARY KEY (ExamId, CourseId),
	FOREIGN KEY (ExamId)
		REFERENCES Exam (Id)
		ON DELETE CASCADE,
	FOREIGN KEY (CourseId)
		REFERENCES Course (Id)
		ON DELETE CASCADE
);

/* Table for Ad-Hoc Exam information.
Since Ad-Hoc Exams require a list of students, each student is a tuple in this table */
CREATE TABLE AdHocExam (
	ExamId CHAR(15) NOT NULL,
	StudentNetId VARCHAR(20) NOT NULL,
	PRIMARY KEY (ExamId, StudentNetId),
	FOREIGN KEY (ExamId)
		REFERENCES Exam (Id)
		ON DELETE CASCADE,
	FOREIGN KEY (StudentNetId)
		REFERENCES TCSUser (NetId)
		ON DELETE CASCADE
);

/* Table for Appointment information */
CREATE TABLE Appointment (
	Id INT NOT NULL AUTO_INCREMENT,
	StudentNetId VARCHAR(20),
	AppointmentDate DATETIME,
	ExamId CHAR(15),
	TestingCenterId INT,
	Duration INT,
	GapTime INT,
	Status VARCHAR(15),
	PRIMARY KEY(Id),
	FOREIGN KEY (StudentNetId)
		REFERENCES TCSUser (NetId)
		ON DELETE CASCADE,
	FOREIGN KEY (ExamId)
		REFERENCES Exam (Id)
		ON DELETE CASCADE,
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
);