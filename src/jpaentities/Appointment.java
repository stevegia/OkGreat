package jpaentities;

import utils.Status;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the appointment database table.
 * 
 */
@Entity
@Table(name = "appointment")
@NamedQuery(name="Appointment.findAll", query="SELECT a FROM Appointment a")
public class Appointment implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Temporal(TemporalType.TIMESTAMP)
	private Date appointmentDate;

	private String appointmentStatus;

	private int duration;

	private String examRefinedId;

	private int gapTime;

	private int seatNumber;

	private String studentNetId;

	private int termId;

	private int testingCenterId;
	private static EntityManagerFactory emf;
	private static EntityManager em;
	private static Query query;

	public Appointment() {
	}

	/**
	 * @param appointmentDate
	 * @param appointmentStatus
	 * @param duration
	 * @param examRefinedId
	 * @param gapTime
	 * @param seatNumber
	 * @param studentNetId
	 * @param termId
	 * @param testingCenterId
	 */
	public Appointment(Date appointmentDate, String appointmentStatus, int duration, String examRefinedId, int gapTime,
			int seatNumber, String studentNetId, int termId, int testingCenterId) {
		this.appointmentDate = appointmentDate;
		this.appointmentStatus = appointmentStatus;
		this.duration = duration;
		this.examRefinedId = examRefinedId;
		this.gapTime = gapTime;
		this.seatNumber = seatNumber;
		this.studentNetId = studentNetId;
		this.termId = termId;
		this.testingCenterId = testingCenterId;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getAppointmentDate() {
		return this.appointmentDate;
	}

	public void setAppointmentDate(Date appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

	public String getAppointmentStatus() {
		return this.appointmentStatus;
	}

	public void setAppointmentStatus(String appointmentStatus) {
		this.appointmentStatus = appointmentStatus;
	}

	public int getDuration() {
		return this.duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getExamRefinedId() {
		return this.examRefinedId;
	}

	public void setExamRefinedId(String examRefinedId) {
		this.examRefinedId = examRefinedId;
	}

	public int getGapTime() {
		return this.gapTime;
	}

	public void setGapTime(int gapTime) {
		this.gapTime = gapTime;
	}

	public int getSeatNumber() {
		return this.seatNumber;
	}

	public void setSeatNumber(int seatNumber) {
		this.seatNumber = seatNumber;
	}

	public String getStudentNetId() {
		return this.studentNetId;
	}

	public void setStudentNetId(String studentNetId) {
		this.studentNetId = studentNetId;
	}

	public int getTermId() {
		return this.termId;
	}

	public void setTermId(int termId) {
		this.termId = termId;
	}

	public int getTestingCenterId() {
		return this.testingCenterId;
	}

	public void setTestingCenterId(int testingCenterId) {
		this.testingCenterId = testingCenterId;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Appointment [id=" + id + ", appointmentDate=" + appointmentDate + ", appointmentStatus="
				+ appointmentStatus + ", duration=" + duration + ", examRefinedId=" + examRefinedId + ", gapTime="
				+ gapTime + ", seatNumber=" + seatNumber + ", studentNetId=" + studentNetId + ", termId=" + termId
				+ ", testingCenterId=" + testingCenterId + "]";
	}
	public void checkInStudent() {
		setAppointmentStatus(String.valueOf(Status.CHECKED_IN));
	}
	public void cancel() {
		this.setAppointmentStatus(String.valueOf(Status.CANCELLED));
	}

}