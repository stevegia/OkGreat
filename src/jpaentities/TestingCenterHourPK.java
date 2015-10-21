package jpaentities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

/**
 * The primary key class for the testingcenterhours database table.
 * @author Haseeb Shahid
 */
@Embeddable
public class TestingCenterHourPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	private int testingCenterId;

	@Temporal(TemporalType.DATE)
	private Date openDate;

	/**
	 * 
	 */
	public TestingCenterHourPK() {
	}

	/**
	 * @param testingCenterId
	 * @param openDate
	 */
	public TestingCenterHourPK(int testingCenterId, Date openDate) {
		this.testingCenterId = testingCenterId;
		this.openDate = openDate;
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
	 * @return the openDate
	 */
	public Date getOpenDate() {
		return openDate;
	}

	/**
	 * @param openDate the openDate to set
	 */
	public void setOpenDate(Date openDate) {
		this.openDate = openDate;
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof TestingCenterHourPK)) {
			return false;
		}
		TestingCenterHourPK castOther = (TestingCenterHourPK)other;
		return 
			(this.testingCenterId == castOther.testingCenterId)
			&& this.openDate.equals(castOther.openDate);
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.testingCenterId;
		hash = hash * prime + this.openDate.hashCode();
		
		return hash;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TestingcenterhourPK [testingCenterId=" + testingCenterId + ", openDate=" + openDate + "]";
	}

}