CREATE TABLE Message (
	Id INT NOT NULL AUTO_INCREMENT,
	DateMade DATETIME,
	MessageSubject VARCHAR(255),
	Content TEXT,
	ReceiverNetId VARCHAR(20),
	PRIMARY KEY(Id),
	FOREIGN KEY(ReceiverNetId) REFERENCES TCSUser(NetId)
);