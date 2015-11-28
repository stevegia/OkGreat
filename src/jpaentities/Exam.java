package jpaentities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import utils.Status;

/**
 * The persistent class for the exam database table.
 * 
 */
@Entity
@Table(name = "exam")
@NamedQuery(name="Exam.findAll", query="SELECT e FROM Exam e")
public class Exam implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private int duration;

	@Temporal(TemporalType.TIMESTAMP)
	private Date endDate;

	private String examName;

	private String examStatus;

	private String examType;

	private String instructorNetId;

	private int numberOfAppointments;

	private int numberOfStudents;

	private String refinedId;

	@Temporal(TemporalType.TIMESTAMP)
	private Date startDate;

	private int termId;

	private int testingCenterId;

	@Version
	private int version;

	public Exam() {
	}

	/**
	 * @param duration
	 * @param endDate
	 * @param examName
	 * @param examStatus
	 * @param examType
	 * @param instructorNetId
	 * @param numberOfAppointments
	 * @param numberOfStudents
	 * @param refinedId
	 * @param startDate
	 * @param termId
	 * @param testingCenterId
	 */
	public Exam(int duration, Date endDate, String examName, String examStatus, String examType, String instructorNetId,
			int numberOfAppointments, int numberOfStudents, String refinedId, Date startDate, int termId,
			int testingCenterId) {
		this.duration = duration;
		this.endDate = endDate;
		this.examName = examName;
		this.examStatus = examStatus;
		this.examType = examType;
		this.instructorNetId = instructorNetId;
		this.numberOfAppointments = numberOfAppointments;
		this.numberOfStudents = numberOfStudents;
		this.refinedId = refinedId;
		this.startDate = startDate;
		this.termId = termId;
		this.testingCenterId = testingCenterId;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDuration() {
		return this.duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getExamName() {
		return this.examName;
	}

	public void setExamName(String examName) {
		this.examName = examName;
	}

	public String getExamStatus() {
		return this.examStatus;
	}

	public void setExamStatus(String examStatus) {
		this.examStatus = examStatus;
	}

	public String getExamType() {
		return this.examType;
	}

	public void setExamType(String examType) {
		this.examType = examType;
	}

	public String getInstructorNetId() {
		return this.instructorNetId;
	}

	public void setInstructorNetId(String instructorNetId) {
		this.instructorNetId = instructorNetId;
	}

	public int getNumberOfAppointments() {
		return this.numberOfAppointments;
	}

	public void setNumberOfAppointments(int numberOfAppointments) {
		this.numberOfAppointments = numberOfAppointments;
	}

	public int getNumberOfStudents() {
		return this.numberOfStudents;
	}

	public void setNumberOfStudents(int numberOfStudents) {
		this.numberOfStudents = numberOfStudents;
	}

	public String getRefinedId() {
		return this.refinedId;
	}

	public void setRefinedId(String refinedId) {
		this.refinedId = refinedId;
	}

	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
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


	public void cancel(){
		this.setExamStatus(String.valueOf(Status.CANCELLED));
	}
	public void deny(){
		this.setExamStatus(String.valueOf(Status.DENIED));
	}
	public void approve(){
		this.setExamStatus(String.valueOf(Status.APPROVED));
	}


	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Exam [id=" + id + ", duration=" + duration + ", endDate=" + endDate + ", examName=" + examName
				+ ", examStatus=" + examStatus + ", examType=" + examType + ", instructorNetId=" + instructorNetId
				+ ", numberOfAppointments=" + numberOfAppointments + ", numberOfStudents=" + numberOfStudents
				+ ", refinedId=" + refinedId + ", startDate=" + startDate + ", termId=" + termId + ", testingCenterId="
				+ testingCenterId + "]";
	}

}