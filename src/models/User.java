package models;

public abstract class User {

	private String netID;
	private String password;
	private String email;
	private String firstName;
	private String lastName;
	private Type type;
	
	
	
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



	public Type getType() {
		return type;
	}



	public void setType(Type type) {
		this.type = type;
	}

	public void makeStudentAppointment(Student student, Exam exam){
		//TODO: stub
	}
	public void cancelAppointment(Appointment appointment){
		//TODO: stub
	}


	public enum Type{
		ADMIN, INSTRUCTOR, STUDENT
	}
}
