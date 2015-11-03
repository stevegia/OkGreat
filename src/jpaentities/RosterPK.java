package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the roster database table.
 * 
 */
@Embeddable
public class RosterPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	private String netId;

	private String TCSClassUnrefinedId;

	public RosterPK() {
	}
	public String getNetId() {
		return this.netId;
	}
	public void setNetId(String netId) {
		this.netId = netId;
	}
	public String getTCSClassUnrefinedId() {
		return this.TCSClassUnrefinedId;
	}
	public void setTCSClassUnrefinedId(String TCSClassUnrefinedId) {
		this.TCSClassUnrefinedId = TCSClassUnrefinedId;
	}

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
			&& this.TCSClassUnrefinedId.equals(castOther.TCSClassUnrefinedId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.netId.hashCode();
		hash = hash * prime + this.TCSClassUnrefinedId.hashCode();
		
		return hash;
	}
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RosterPK [netId=" + netId + ", TCSClassUnrefinedId=" + TCSClassUnrefinedId + "]";
	}
	
}