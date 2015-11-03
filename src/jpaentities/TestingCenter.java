package jpaentities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the testingcenter database table.
 * 
 */
@Entity
@Table(name = "testingcenter")
@NamedQuery(name="Testingcenter.findAll", query="SELECT t FROM TestingCenter t")
public class TestingCenter implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private int currentTerm;

	private int gapTime;

	private int numberOfSeats;

	private int numberofSetAsideSeats;

	private int reminderInterval;

	public TestingCenter() {
	}

	/**
	 * @param currentTerm
	 * @param gapTime
	 * @param numberOfSeats
	 * @param numberofSetAsideSeats
	 * @param reminderInterval
	 */
	public TestingCenter(int currentTerm, int gapTime, int numberOfSeats, int numberofSetAsideSeats,
			int reminderInterval) {
		this.currentTerm = currentTerm;
		this.gapTime = gapTime;
		this.numberOfSeats = numberOfSeats;
		this.numberofSetAsideSeats = numberofSetAsideSeats;
		this.reminderInterval = reminderInterval;
	}

	public int getCurrentTerm() {
		return this.currentTerm;
	}

	public void setCurrentTerm(int currentTerm) {
		this.currentTerm = currentTerm;
	}

	public int getGapTime() {
		return this.gapTime;
	}

	public void setGapTime(int gapTime) {
		this.gapTime = gapTime;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNumberOfSeats() {
		return this.numberOfSeats;
	}

	public void setNumberOfSeats(int numberOfSeats) {
		this.numberOfSeats = numberOfSeats;
	}

	public int getNumberOfSetAsideSeats() {
		return this.numberofSetAsideSeats;
	}

	public void setNumberOfSetAsideSeats(int numberofSetAsideSeats) {
		this.numberofSetAsideSeats = numberofSetAsideSeats;
	}

	public int getReminderInterval() {
		return this.reminderInterval;
	}

	public void setReminderInterval(int reminderInterval) {
		this.reminderInterval = reminderInterval;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TestingCenter [id=" + id + ", currentTerm=" + currentTerm + ", gapTime=" + gapTime + ", numberOfSeats="
				+ numberOfSeats + ", numberofSetAsideSeats=" + numberofSetAsideSeats + ", reminderInterval="
				+ reminderInterval + "]";
	}

}