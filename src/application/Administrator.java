/**
 * 
 */
package application;

import jpaentities.Appointment;
import jpaentities.TCSUser;
import utils.Constants;

import javax.persistence.EntityManager;

/**
 * @author Haseeb Shahid
 *
 */
@SuppressWarnings("serial")
public class Administrator extends TCSUser {
	
	/**
	 * Default constructor
	 */
	public Administrator() {
		this.setUserType(Constants.UserType.ADMINISTRATOR);
	}

	/**
	 * @param netId
	 * @param email
	 * @param password
	 * @param firstName
	 * @param lastName
	 */
	public Administrator(String netId, String email, String password, String firstName, String lastName) {
		super(netId, email, password, firstName, lastName, "ADMINISTRATOR");
	}
	
	/**
	 * @param user
	 */
	public Administrator(TCSUser user) {
		this.setNetId(user.getNetId());
		this.setEmail(user.getEmail());
		this.setPassword(user.getPassword());
		this.setFirstName(user.getFirstName());
		this.setLastName(user.getLastName());
		this.setUserType(Constants.UserType.ADMINISTRATOR);
	}

	public void checkInStudent(int appointmentId){
		Retriever retriever = Retriever.getInstance();
		Appointment appointment = retriever.getAppointmentByID(appointmentId);
		System.out.println("Before: " + appointment);
		appointment.checkInStudent();
		System.out.println("After: " + appointment);

		retriever.persist(appointment);
	}
}
