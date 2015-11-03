package jpaentities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the courseexam database table.
 * 
 */
@Entity
@Table(name = "courseexam")
@NamedQuery(name="Courseexam.findAll", query="SELECT c FROM CourseExam c")
public class CourseExam implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private CourseExamPK id;

	public CourseExam() {
	}

	public CourseExamPK getId() {
		return this.id;
	}

	public void setId(CourseExamPK id) {
		this.id = id;
	}

}