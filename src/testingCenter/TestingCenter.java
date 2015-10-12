package testingCenter;

import java.util.Collection;
import java.util.Date;

import models.Appointment;

public class TestingCenter {
	private Collection<Seat> seats;
	private double gapTime;
	private double reminderInterval;
	private Collection<Date> closedDates;
	
	public void calculateActualUtilization(){
		//TODO: stub
	}
	public void calculateExpectedUtilization(){
		//TODO: stub
	}
	public void sendEmail(){
		//TODO: stub
	}
	public void releaseSeat(int seatNumber){
		//TODO: stub
	}
	public void setAppointmentStatus(String appointmentId){
		//TODO: stub
	}
	public void checkSupurflous(Appointment appointment){
		//TODO: stub
	}
}
