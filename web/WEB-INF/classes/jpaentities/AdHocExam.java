package jpaentities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the adhocexam database table.
 * 
 */
@Entity
@Table(name = "adhocexam")
@NamedQuery(name="Adhocexam.findAll", query="SELECT a FROM AdHocExam a")
public class AdHocExam implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private AdHocExamPK id;

	private String studentFirstName;

	private String studentLastName;

	public AdHocExam() {
	}

	public AdHocExamPK getId() {
		return this.id;
	}

	public void setId(AdHocExamPK id) {
		this.id = id;
	}

	public String getStudentFirstName() {
		return this.studentFirstName;
	}

	public void setStudentFirstName(String studentFirstName) {
		this.studentFirstName = studentFirstName;
	}

	public String getStudentLastName() {
		return this.studentLastName;
	}

	public void setStudentLastName(String studentLastName) {
		this.studentLastName = studentLastName;
	}

}