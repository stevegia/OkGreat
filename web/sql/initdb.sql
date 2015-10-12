CREATE TABLE TCSUser (
	NetId VARCHAR(20) NOT NULL,
	Password VARCHAR(20),
	Email VARCHAR(20),
	FirstName VARCHAR(20),
	LastName VARCHAR(20),
	UserType CHAR(15),
	PRIMARY KEY (NetId),
	UNIQUE (Email)
);

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

CREATE TABLE TestingCenter (
	Id INT NOT NULL,
	NumberOfSeats INT,
	NumberofSetAsideSeats INT,
	GapTime INT,
	ReminderInterval INT,
	PRIMARY KEY (Id)
);

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

CREATE TABLE ClosedDates (
	TestingCenterId INT NOT NULL,
	ClosedDate DATE,
	PRIMARY KEY (TestingCenterId, ClosedDate),
	FOREIGN KEY (TestingCenterId)
		REFERENCES TestingCenter (Id)
		ON DELETE CASCADE
);

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

CREATE TABLE Appointment (
	Id INT NOT NULL,
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