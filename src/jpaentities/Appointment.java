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

	private String appointmentStatus;

	@Temporal(TemporalType.TIMESTAMP)
	private Date endDate;

	private String examRefinedId;

	private int seatNumber;

	@Temporal(TemporalType.TIMESTAMP)
	private Date startDate;

	private String studentNetId;

	private int termId;

	private int testingCenterId;

    @Version
    private int version;

	public Appointment() {
	}

	/**
	 * @param appointmentStatus
	 * @param endDate
	 * @param examRefinedId
	 * @param seatNumber
	 * @param startDate
	 * @param studentNetId
	 * @param termId
	 * @param testingCenterId
	 */
	public Appointment(String appointmentStatus, Date endDate, String examRefinedId, int seatNumber, Date startDate,
					   String studentNetId, int termId, int testingCenterId) {
		this.appointmentStatus = appointmentStatus;
		this.endDate = endDate;
		this.examRefinedId = examRefinedId;
		this.seatNumber = seatNumber;
		this.startDate = startDate;
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

	public String getAppointmentStatus() {
		return this.appointmentStatus;
	}

	public void setAppointmentStatus(String appointmentStatus) {
		this.appointmentStatus = appointmentStatus;
	}

	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getExamRefinedId() {
		return this.examRefinedId;
	}

	public void setExamRefinedId(String examRefinedId) {
		this.examRefinedId = examRefinedId;
	}

	public int getSeatNumber() {
		return this.seatNumber;
	}

	public void setSeatNumber(int seatNumber) {
		this.seatNumber = seatNumber;
	}

	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
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
		return "Appointment [id=" + id + ", appointmentStatus=" + appointmentStatus + ", endDate=" + endDate
				+ ", examRefinedId=" + examRefinedId + ", seatNumber=" + seatNumber + ", startDate=" + startDate
				+ ", studentNetId=" + studentNetId + ", termId=" + termId + ", testingCenterId=" + testingCenterId
				+ "]";
	}

	public void checkInStudent() {
		setAppointmentStatus(String.valueOf(Status.CHECKED_IN));
	}
	public void cancel() {
		this.setAppointmentStatus(String.valueOf(Status.CANCELLED));
	}

}