package jpaentities;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.*;

/**
 * The persistent class for the appointment database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name = "appointment")
public class Appointment implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Id")
	private int id;
	private String studentNetId;
	private Timestamp appointmentDate;
	private String examId;
	private int testingCenterId;
	private int duration;
	private int gapTime;
	private String status;

	/**
	 * 
	 */
	public Appointment() {
	}

	/**
	 * @param id
	 * @param studentNetId
	 * @param appointmentDate
	 * @param examId
	 * @param testingCenterId
	 * @param duration
	 * @param gapTime
	 * @param status
	 */
	public Appointment(int id, String studentNetId, Timestamp appointmentDate, String examId, int testingCenterId,
			int duration, int gapTime, String status) {
		this.id = id;
		this.studentNetId = studentNetId;
		this.appointmentDate = appointmentDate;
		this.examId = examId;
		this.testingCenterId = testingCenterId;
		this.duration = duration;
		this.gapTime = gapTime;
		this.status = status;
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
	 * @return the studentNetId
	 */
	public String getStudentNetId() {
		return studentNetId;
	}

	/**
	 * @param studentNetId the studentNetId to set
	 */
	public void setStudentNetId(String studentNetId) {
		this.studentNetId = studentNetId;
	}

	/**
	 * @return the appointmentDate
	 */
	public Timestamp getAppointmentDate() {
		return appointmentDate;
	}

	/**
	 * @param appointmentDate the appointmentDate to set
	 */
	public void setAppointmentDate(Timestamp appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

	/**
	 * @return the examId
	 */
	public String getExamId() {
		return examId;
	}

	/**
	 * @param examId the examId to set
	 */
	public void setExamId(String examId) {
		this.examId = examId;
	}

	/**
	 * @return the testingCenterId
	 */
	public int getTestingCenterId() {
		return testingCenterId;
	}

	/**
	 * @param testingCenterId the testingCenterId to set
	 */
	public void setTestingCenterId(int testingCenterId) {
		this.testingCenterId = testingCenterId;
	}

	/**
	 * @return the duration
	 */
	public int getDuration() {
		return duration;
	}

	/**
	 * @param duration the duration to set
	 */
	public void setDuration(int duration) {
		this.duration = duration;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Appointment [id=" + id + ", studentNetId=" + studentNetId + ", appointmentDate=" + appointmentDate
				+ ", examId=" + examId + ", testingCenterId=" + testingCenterId + ", duration=" + duration
				+ ", gapTime=" + gapTime + ", status=" + status + "]";
	}

}