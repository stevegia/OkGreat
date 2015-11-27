package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the courseexam database table.
 * 
 */
@Embeddable
public class CourseExamPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	private String examRefinedId;

	private String TCSClassRefinedId;

	public CourseExamPK() {
	}

	public String getExamRefinedId() {
		return this.examRefinedId;
	}
	public void setExamRefinedId(String examRefinedId) {
		this.examRefinedId = examRefinedId;
	}
	public String getTCSClassRefinedId() {
		return this.TCSClassRefinedId;
	}
	public void setTCSClassRefinedId(String TCSClassRefinedId) {
		this.TCSClassRefinedId = TCSClassRefinedId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof CourseExamPK)) {
			return false;
		}
		CourseExamPK castOther = (CourseExamPK)other;
		return 
			this.examRefinedId.equals(castOther.examRefinedId)
			&& this.TCSClassRefinedId.equals(castOther.TCSClassRefinedId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.examRefinedId.hashCode();
		hash = hash * prime + this.TCSClassRefinedId.hashCode();
		
		return hash;
	}
}