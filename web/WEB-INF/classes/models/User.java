package models;

import utils.Constants;

public abstract class User {

	private String netID;
	private String password;
	private String email;
	private String firstName;
	private String lastName;
	private Constants.UserType type;
	
	
	
	public String getNetID() {
		return netID;
	}



	public void setNetID(String netID) {
		this.netID = netID;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getFirstName() {
		return firstName;
	}



	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}



	public String getLastName() {
		return lastName;
	}



	public void setLastName(String lastName) {
		this.lastName = lastName;
	}



	public Constants.UserType getUserType() {
		return type;
	}



	public void setType(Constants.UserType type) {
		this.type = type;
	}

	public void makeStudentAppointment(Student student, Exam exam){
		//TODO: stub
	}
	public void cancelAppointment(Appointment appointment){
		//TODO: stub
	}



}
