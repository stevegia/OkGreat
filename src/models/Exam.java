package models;

import java.util.Collection;
import java.util.Date;

import utils.Status;

public class Exam {
	private String examID;
	private Instructor instructor;
	private Status status;
	private double duration;
	private Date startDate;
	private Date endDate;
	private Collection<Appointment> appointments;
	private int numSeats, seatsTaken;
	
	public Exam(Date startDate, Date endDate){
		if(endDate.before(startDate)){
			throw new IllegalArgumentException("End time cannot be before starting time");
		}
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	public boolean checkExamStarted(){
		Date currentDate = new Date();
		return currentDate.after(startDate) && currentDate.before(endDate);
	}
	public boolean checkExamEnded(){
		Date currentDate = new Date();
		return currentDate.after(endDate);
	}
}
