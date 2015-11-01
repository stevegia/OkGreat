/**
 * 
 */
package application;

import jpaentities.Exam;
import jpaentities.TCSUser;
import utils.Constants;

/**
 * @author Haseeb Shahid
 *
 */
@SuppressWarnings("serial")
public class Student extends TCSUser {

	/**
	 * Default contructor
	 */
	public Student() {
		this.setUserType(Constants.UserType.STUDENT);
	}

	/**
	 * @param netId
	 * @param email
	 * @param password
	 * @param firstName
	 * @param lastName
	 */
	public Student(String netId, String email, String password, String firstName, String lastName) {
		super(netId, email, password, firstName, lastName, "STUDENT");
	}
	
	/**
	 * @param user
	 */
	public Student(TCSUser user) {
		this.setNetId(user.getNetId());
		this.setEmail(user.getEmail());
		this.setPassword(user.getPassword());
		this.setFirstName(user.getFirstName());
		this.setLastName(user.getLastName());
		this.setUserType(Constants.UserType.STUDENT);
	}

	public boolean makeAppointment(String netId, int termId, String examRefinedId, String apptDatetime) {
		Retriever retriever = Retriever.getInstance();
		Exam exam = retriever.getExam(examRefinedId);

		// Requested exam not found
		if (exam == null) return false;

		if (exam.getExamType().equals("COURSE")) {
			// Exam is a course exam
		}
		else {
			// Exam is an ad-hoc exam
		}

		return true;
	}

}
