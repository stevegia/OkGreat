/**
 * 
 */
package application;

import jpaentities.TCSUser;
import utils.Constants;

/**
 * @author Haseeb Shahid
 *
 */
@SuppressWarnings("serial")
public class Instructor extends TCSUser {
	
	/**
	 * Default constructor
	 */
	public Instructor() {
		this.setUserType(Constants.UserType.INSTRUCTOR);
	}

	/**
	 * @param netId
	 * @param email
	 * @param password
	 * @param firstName
	 * @param lastName
	 */
	public Instructor(String netId, String email, String password, String firstName, String lastName) {
		super(netId, email, password, firstName, lastName, "INSTRUCTOR");
	}
	
	/**
	 * @param user
	 */
	public Instructor(TCSUser user) {
		this.setNetId(user.getNetId());
		this.setEmail(user.getEmail());
		this.setPassword(user.getPassword());
		this.setFirstName(user.getFirstName());
		this.setLastName(user.getLastName());
		this.setUserType(Constants.UserType.INSTRUCTOR);
	}

}
