INSERT INTO TCSClass (UnrefinedId, RefinedId, Subject, CatalogNumber, Section, InstructorNetId)
VALUES ('88222-1158', 'AAS102-1_1158', 'AAS', 102, '1', 'instr');

INSERT INTO Roster (NetId, TCSClassUnrefinedId, TermId)
VALUES ('student', '88222-1158', 1158);

INSERT INTO Exam (RefinedId, ExamType, InstructorNetId, ExamName, TestingCenterId, NumberOfStudents, NumberOfAppointments, ExamStatus, StartDate, EndDate, Duration, TermId)
VALUES ('AAS102-1_1158_ex1', 'COURSE', 'instr', 'AA Exam 1', 1, 10, 0, 'APPROVED', '2015-11-05 12:00:00', '2015-11-10 12:00:00', 80, 1158);

INSERT INTO CourseExam (ExamRefinedId, TCSClassRefinedId)
VALUES ('AAS102-1_1158_ex1', 'AAS102-1_1158');

INSERT INTO Seat (SetAside)
VALUES (0);