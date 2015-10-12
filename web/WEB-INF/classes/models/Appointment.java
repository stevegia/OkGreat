package models;

import java.util.Date;

import utils.Status;

public class Appointment {
	private String appointmentID;
	private Student student;
	private Date date;
	private Exam exam;
	private Status status;
	
	public void prepare(){
		if(checkValid()){
			status = Status.APPROVED;
		} else {
			status = Status.DENIED;
		}
		//TODO: stub
	}
	public void activate(){
		if(status == Status.APPROVED){
			status = Status.ACTIVE;
		}
		//TODO: stub
	}
	public boolean checkValid(){
		//TODO: stub
		return true;
	}
	public void checkInStudent(){
		if(status == Status.ACTIVE){
			status = Status.CHECKED_IN;
		}
		//TODO: stub
	}
	public void end(){
		if(status == Status.ACTIVE || status == Status.CHECKED_IN){
			status = Status.INACTIVE;
		}
		//TODO: stub
	}
}
