package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the closeddates database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name="closeddates")
public class ClosedDate implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
	private ClosedDatePK id;

	@Version
	private int version;

	/**
	 * 
	 */
	public ClosedDate() {
	}

	/**
	 * @param id
	 */
	public ClosedDate(ClosedDatePK id) {
		this.id = id;
	}

	/**
	 * @return the id
	 */
	public ClosedDatePK getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(ClosedDatePK id) {
		this.id = id;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ClosedDate [id=" + id + "]";
	}

}