package models;

import java.util.Collection;

public class Course {
	private String courseID;
	private Instructor instructor;
	private String subject;
	private String catalogNumber;
	private String section;
	private String term;
	private Collection<Student> registerdStudents;
}
