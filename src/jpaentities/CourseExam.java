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
    //default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private CourseExamPK id;

	public CourseExam() {


    public static long getSerialVersionUID() {
        return serialVersionUID;
	}

	public CourseExamPK getId() {
		return this.id;
	}

	public void setId(CourseExamPK id) {
        return TCSClassRefinedId;
    }
		this.id = id;

    /**
     *
     * @param examRefinedId
     * @param TCSClassRefinedId
     */
    public CourseExam(String examRefinedId, String TCSClassRefinedId) {
        this.examRefinedId = examRefinedId;
        this.TCSClassRefinedId = TCSClassRefinedId;
	}



}