package jpaentities;

import java.io.Serializable;
import javax.persistence.*;
import utils.Constants;

/**
 * The persistent class for the tcsuser database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name = "tcsuser")
public class TCSUser implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "NetId")
	private String netId;
	private String email;
	private String password;
	private String firstName;
	private String lastName;

	@Enumerated(EnumType.STRING)
	private Constants.UserType userType;
	
	/**
	 * 
	 */
	public TCSUser() {
	}
	
	/**
	 * @param netId
	 * @param email
	 * @param password
	 * @param firstName
	 * @param lastName
	 * @param userType
	 */
	public TCSUser(String netId, String email, String password, String firstName, String lastName, String userType) {
		this.netId = netId;
		this.email = email;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		if(userType.equals("ADMINISTRATOR")){
			this.userType = Constants.UserType.ADMINISTRATOR;
		}
		if(userType.equals("INSTRUCTOR")){
			this.userType = Constants.UserType.INSTRUCTOR;
		}
		if(userType.equals("STUDENT")){
			this.userType = Constants.UserType.STUDENT;
		}

	}
	
	/**
	 * @return the netId
	 */
	public String getNetId() {
		return netId;
	}

	/**
	 * @param netId the netId to set
	 */
	public void setNetId(String netId) {
		this.netId = netId;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * @return the userType
	 */
	public Constants.UserType getUserType() {
		return this.userType;
	}

	/**
	 * @param userType the userType to set
	 */
	public void setUserType(Constants.UserType userType) {
		this.userType = userType;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TCSUser [netId=" + netId + ", email=" + email + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", userType=" + userType.toString() + "]";
	}
	
}
