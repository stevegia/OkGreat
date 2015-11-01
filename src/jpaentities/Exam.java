package jpaentities;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.*;

/**
 * The persistent class for the exam database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name = "exam")
public class Exam implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Id")
	private String id;
	private String examType;
	private String instructorNetId;
	private String examName;
	private int testingCenterId;
	private int numberOfStudents;
	private int numberOfAppointments;
	private String examStatus;
	private Timestamp startDate;
	private Timestamp endDate;
	private int duration;
	private int termId;

	/**
	 * 
	 */
	public Exam() {
	}

	/**
	 * @param id
	 * @param examType
	 * @param instructorNetId
	 * @param name
	 * @param testingCenterId
	 * @param numberOfStudents
	 * @param numberOfAppointments
	 * @param examStatus
	 * @param startDate
	 * @param endDate
	 * @param duration
	 * @param termId
	 */
	public Exam(String id, String examType, String instructorNetId, String name, int testingCenterId,
			int numberOfStudents, int numberOfAppointments, String examStatus, Timestamp startDate, Timestamp endDate,
			int duration,int termId) {
		this.termId=termId;
		this.id = id;
		this.examType = examType;
		this.instructorNetId = instructorNetId;
		this.examName = name;
		this.testingCenterId = testingCenterId;
		this.numberOfStudents = numberOfStudents;
		this.numberOfAppointments = numberOfAppointments;
		this.examStatus = examStatus;
		this.startDate = startDate;
		this.endDate = endDate;
		this.duration = duration;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the examType
	 */
	public String getExamType() {
		return examType;
	}

	/**
	 * @param examType the examType to set
	 */
	public void setExamType(String examType) {
		this.examType = examType;
	}

	/**
	 * @return the instructorNetId
	 */
	public String getInstructorNetId() {
		return instructorNetId;
	}

	/**
	 * @param instructorNetId the instructorNetId to set
	 */
	public void setInstructorNetId(String instructorNetId) {
		this.instructorNetId = instructorNetId;
	}

	/**
	 * @return the name
	 */
	public String getExamName() {
		return examName;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.examName = name;
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
	 * @return the numberOfStudents
	 */
	public int getNumberOfStudents() {
		return numberOfStudents;
	}

	/**
	 * @param numberOfStudents the numberOfStudents to set
	 */
	public void setNumberOfStudents(int numberOfStudents) {
		this.numberOfStudents = numberOfStudents;
	}

	/**
	 * @return the numberOfAppointments
	 */
	public int getNumberOfAppointments() {
		return numberOfAppointments;
	}

	/**
	 * @param numberOfAppointments the numberOfAppointments to set
	 */
	public void setNumberOfAppointments(int numberOfAppointments) {
		this.numberOfAppointments = numberOfAppointments;
	}

	/**
	 * @return the examStatus
	 */
	public String getExamStatus() {
		return examStatus;
	}

	/**
	 * @param examStatus the examStatus to set
	 */
	public void setExamStatus(String examStatus) {
		this.examStatus = examStatus;
	}

	/**
	 * @return the startDate
	 */
	public Timestamp getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public Timestamp getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
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

	public int getTermId() {
		return termId;
	}

	public void setTermId(int termId) {
		this.termId = termId;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override

	public String toString() {
		return "Exam [id=" + id + ", examType=" + examType + ", instructorNetId=" + instructorNetId + ", name=" + examName
				+ ", testingCenterId=" + testingCenterId + ", numberOfStudents=" + numberOfStudents
				+ ", numberOfAppointments=" + numberOfAppointments + ", examStatus=" + examStatus + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", duration=" + duration + "]";
	}

}