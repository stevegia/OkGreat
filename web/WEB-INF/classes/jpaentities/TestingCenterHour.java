package jpaentities;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Time;

/**
 * The persistent class for the testingcenterhours database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name="testingcenterhours")
public class TestingCenterHour implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private TestingCenterHourPK id;
	private Time endTime;
	private Time startTime;

	/**
	 * 
	 */
	public TestingCenterHour() {
	}

	/**
	 * @param id
	 * @param endTime
	 * @param startTime
	 */
	public TestingCenterHour(TestingCenterHourPK id, Time endTime, Time startTime) {
		this.id = id;
		this.endTime = endTime;
		this.startTime = startTime;
	}

	/**
	 * @return the id
	 */
	public TestingCenterHourPK getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(TestingCenterHourPK id) {
		this.id = id;
	}

	/**
	 * @return the endTime
	 */
	public Time getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the startTime
	 */
	public Time getStartTime() {
		return startTime;
	}

	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TestingCenterHour [id=" + id + ", endTime=" + endTime + ", startTime=" + startTime + "]";
	}

}