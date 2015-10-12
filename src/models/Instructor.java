package models;

import java.util.Collection;
import java.util.Date;

public class Instructor extends User {
	
	private Collection<Course> instructedCourses;
	
	public void submitExamRequests(Course course, double duration, Date startDate, Date endDate){
		//TODO: stub
	}
	public void viewRequests(){
		//TODO: stub
	}
	public void cancelExamRequest(Exam exam){
		//TODO: stub
	}
	public void viewExamDetails(String examID){
		//TODO: stub
	}
}