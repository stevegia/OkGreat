package models;

import java.util.Collection;
import java.util.Date;

public class Student extends User {
	
	private Collection<Course> registeredCourses;
	
	public void makeAppointment(Exam exam){
		makeStudentAppointment(this, exam);
	}
	public void viewAppointments(){
		//TODO: stub
	}
	public void examSearch(Date startDate, Date endDate, String examID){
		//TODO: stub
	}
}
