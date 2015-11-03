package jpaentities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the tcsclass database table.
 * 
 */
@Entity
@Table(name = "tcsclass")
@NamedQuery(name="TCSClass.findAll", query="SELECT t FROM TCSClass t")
public class TCSClass implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private int catalogNumber;

	private String instructorNetId;

	private String refinedId;

	private String section;

	private String subject;

	private String unrefinedId;

	public TCSClass() {
	}

	/**
	 * @param catalogNumber
	 * @param instructorNetId
	 * @param refinedId
	 * @param section
	 * @param subject
	 * @param unrefinedId
	 */
	public TCSClass(int catalogNumber, String instructorNetId, String refinedId, String section, String subject,
			String unrefinedId) {
		this.catalogNumber = catalogNumber;
		this.instructorNetId = instructorNetId;
		this.refinedId = refinedId;
		this.section = section;
		this.subject = subject;
		this.unrefinedId = unrefinedId;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCatalogNumber() {
		return this.catalogNumber;
	}

	public void setCatalogNumber(int catalogNumber) {
		this.catalogNumber = catalogNumber;
	}

	public String getInstructorNetId() {
		return this.instructorNetId;
	}

	public void setInstructorNetId(String instructorNetId) {
		this.instructorNetId = instructorNetId;
	}

	public String getRefinedId() {
		return this.refinedId;
	}

	public void setRefinedId(String refinedId) {
		this.refinedId = refinedId;
	}

	public String getSection() {
		return this.section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getSubject() {
		return this.subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getUnrefinedId() {
		return this.unrefinedId;
	}

	public void setUnrefinedId(String unrefinedId) {
		this.unrefinedId = unrefinedId;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TCSClass [id=" + id + ", catalogNumber=" + catalogNumber + ", instructorNetId=" + instructorNetId
				+ ", refinedId=" + refinedId + ", section=" + section + ", subject=" + subject + ", unrefinedId="
				+ unrefinedId + "]";
	}

}