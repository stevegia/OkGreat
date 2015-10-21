package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the testingcenter database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name = "testingcenter")
public class TestingCenter implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Id")
	private int id;
	private int numberOfSeats;
	private int numberOfSetAsideSeats;
	private int gapTime;
	private int reminderInterval;

	/**
	 * 
	 */
	public TestingCenter() {
	}
	
	/**
	 * @param id
	 * @param numberOfSeats
	 * @param numberOfSetAsideSeats
	 * @param gapTime
	 * @param reminderInterval
	 */
	public TestingCenter(int id, int numberOfSeats, int numberOfSetAsideSeats, int gapTime, int reminderInterval) {
		this.id = id;
		this.numberOfSeats = numberOfSeats;
		this.numberOfSetAsideSeats = numberOfSetAsideSeats;
		this.gapTime = gapTime;
		this.reminderInterval = reminderInterval;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the numberOfSeats
	 */
	public int getNumberOfSeats() {
		return numberOfSeats;
	}

	/**
	 * @param numberOfSeats the numberOfSeats to set
	 */
	public void setNumberOfSeats(int numberOfSeats) {
		this.numberOfSeats = numberOfSeats;
	}

	/**
	 * @return the numberOfSetAsideSeats
	 */
	public int getNumberOfSetAsideSeats() {
		return numberOfSetAsideSeats;
	}

	/**
	 * @param numberOfSetAsideSeats the numberOfSetAsideSeats to set
	 */
	public void setNumberOfSetAsideSeats(int numberOfSetAsideSeats) {
		this.numberOfSetAsideSeats = numberOfSetAsideSeats;
	}

	/**
	 * @return the gapTime
	 */
	public int getGapTime() {
		return gapTime;
	}

	/**
	 * @param gapTime the gapTime to set
	 */
	public void setGapTime(int gapTime) {
		this.gapTime = gapTime;
	}

	/**
	 * @return the reminderInterval
	 */
	public int getReminderInterval() {
		return reminderInterval;
	}

	/**
	 * @param reminderInterval the reminderInterval to set
	 */
	public void setReminderInterval(int reminderInterval) {
		this.reminderInterval = reminderInterval;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TestingCenter [id=" + id + ", numberOfSeats=" + numberOfSeats + ", numberOfSetAsideSeats="
				+ numberOfSetAsideSeats + ", gapTime=" + gapTime + ", reminderInterval=" + reminderInterval + "]";
	}
   
}
