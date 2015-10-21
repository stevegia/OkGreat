package jpaentities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the course database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name = "course")
public class Course implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "Id")
	private String id;
	private int catalogNumber;
	private String instructorNetId;
	private String section;
	private String subject;
	
	/**
	 * 
	 */
	public Course() {
	}

	/**
	 * @param id
	 * @param catalogNumber
	 * @param instructorNetId
	 * @param section
	 * @param subject
	 */
	public Course(String id, int catalogNumber, String instructorNetId, String section, String subject) {
		this.id = id;
		this.catalogNumber = catalogNumber;
		this.instructorNetId = instructorNetId;
		this.section = section;
		this.subject = subject;
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
	 * @return the catalogNumber
	 */
	public int getCatalogNumber() {
		return catalogNumber;
	}

	/**
	 * @param catalogNumber the catalogNumber to set
	 */
	public void setCatalogNumber(int catalogNumber) {
		this.catalogNumber = catalogNumber;
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
	 * @return the section
	 */
	public String getSection() {
		return section;
	}

	/**
	 * @param section the section to set
	 */
	public void setSection(String section) {
		this.section = section;
	}

	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * @param subject the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Course [id=" + id + ", catalogNumber=" + catalogNumber + ", instructorNetId=" + instructorNetId
				+ ", section=" + section + ", subject=" + subject + "]";
	}

}