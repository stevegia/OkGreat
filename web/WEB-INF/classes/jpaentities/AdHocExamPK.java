package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the adhocexam database table.
 * 
 */
@Embeddable
public class AdHocExamPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	private String examRefinedId;

	private String studentNetId;

	public AdHocExamPK() {
	}
	public String getExamRefinedId() {
		return this.examRefinedId;
	}
	public void setExamRefinedId(String examRefinedId) {
		this.examRefinedId = examRefinedId;
	}
	public String getStudentNetId() {
		return this.studentNetId;
	}
	public void setStudentNetId(String studentNetId) {
		this.studentNetId = studentNetId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof AdHocExamPK)) {
			return false;
		}
		AdHocExamPK castOther = (AdHocExamPK)other;
		return 
			this.examRefinedId.equals(castOther.examRefinedId)
			&& this.studentNetId.equals(castOther.studentNetId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.examRefinedId.hashCode();
		hash = hash * prime + this.studentNetId.hashCode();
		
		return hash;
	}
}