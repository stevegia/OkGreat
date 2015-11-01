package jpaentities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the roster database table.
 * @author Haseeb Shahid
 */
@Entity
@Table(name = "roster")
public class Roster implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private RosterPK id;

	/**
	 * 
	 */
	public Roster() {
	}

	/**
	 * @param id
	 */
	public Roster(RosterPK id) {
		this.id = id;
	}

	/**
	 * @return the id
	 */
	public RosterPK getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(RosterPK id) {
		this.id = id;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Roster [id=" + id + "]";
	}

}