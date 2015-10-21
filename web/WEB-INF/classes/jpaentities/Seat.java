package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the seat database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name = "seat")
public class Seat implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Number")
	private int number;
	private int appointmentId;
	private boolean setAside;

	/**
	 * 
	 */
	public Seat() {
	}

	/**
	 * @param number
	 * @param appointmentId
	 * @param setAside
	 */
	public Seat(int number, int appointmentId, boolean setAside) {
		this.number = number;
		this.appointmentId = appointmentId;
		this.setAside = setAside;
	}

	/**
	 * @return the number
	 */
	public int getNumber() {
		return number;
	}

	/**
	 * @param number the number to set
	 */
	public void setNumber(int number) {
		this.number = number;
	}

	/**
	 * @return the appointmentId
	 */
	public int getAppointmentId() {
		return appointmentId;
	}

	/**
	 * @param appointmentId the appointmentId to set
	 */
	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}

	/**
	 * @return the setAside
	 */
	public boolean isSetAside() {
		return setAside;
	}

	/**
	 * @param setAside the setAside to set
	 */
	public void setSetAside(boolean setAside) {
		this.setAside = setAside;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Seat [number=" + number + ", appointmentId=" + appointmentId + ", setAside=" + setAside + "]";
	}

}