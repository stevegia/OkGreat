package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the roster database table.
 * @author Haseeb Shahid
 */
@Embeddable
public class RosterPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	private String netId;
	private String courseID;

	/**
	 * 
	 */
	public RosterPK() {
	}
	
	/**
	 * @param netId
	 * @param courseID
	 */
	public RosterPK(String netId, String courseID) {
		this.netId = netId;
		this.courseID = courseID;
	}

	/**
	 * @return the netId
	 */
	public String getNetId() {
		return netId;
	}

	/**
	 * @param netId the netId to set
	 */
	public void setNetId(String netId) {
		this.netId = netId;
	}

	/**
	 * @return the courseID
	 */
	public String getCourseID() {
		return courseID;
	}

	/**
	 * @param courseID the courseID to set
	 */
	public void setCourseID(String courseID) {
		this.courseID = courseID;
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof RosterPK)) {
			return false;
		}
		RosterPK castOther = (RosterPK)other;
		return 
			this.netId.equals(castOther.netId)
			&& this.courseID.equals(castOther.courseID);
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.netId.hashCode();
		hash = hash * prime + this.courseID.hashCode();
		
		return hash;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RosterPK [netId=" + netId + ", courseID=" + courseID + "]";
	}
	
}