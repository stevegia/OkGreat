/**
 * 
 */
package jpaentities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

/**
 * The primary key class for the closeddates database table.
 * @author Haseeb Shahid
 */
@Embeddable
public class ClosedDatePK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	private int testingCenterId;

	@Temporal(TemporalType.DATE)
	private Date closedDate;
	
	/**
	 * 
	 */
	public ClosedDatePK() {
	}

	/**
	 * @param testingCenterId
	 * @param closedDate
	 */
	public ClosedDatePK(int testingCenterId, Date closedDate) {
		this.testingCenterId = testingCenterId;
		this.closedDate = closedDate;
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
	 * @return the closedDate
	 */
	public Date getClosedDate() {
		return closedDate;
	}

	/**
	 * @param closedDate the closedDate to set
	 */
	public void setClosedDate(Date closedDate) {
		this.closedDate = closedDate;
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof ClosedDatePK)) {
			return false;
		}
		ClosedDatePK castOther = (ClosedDatePK)other;
		return 
			(this.testingCenterId == castOther.testingCenterId)
			&& this.closedDate.equals(castOther.closedDate);
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.testingCenterId;
		hash = hash * prime + this.closedDate.hashCode();
		
		return hash;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ClosedDatePK [testingCenterId=" + testingCenterId + ", closedDate=" + closedDate + "]";
	}

}
