package models;

import java.util.Date;

public class Student extends User {

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
