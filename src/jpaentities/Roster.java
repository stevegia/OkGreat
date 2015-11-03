package jpaentities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the roster database table.
 * 
 */
@Entity
@Table(name = "roster")
@NamedQuery(name="Roster.findAll", query="SELECT r FROM Roster r")
public class Roster implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private RosterPK id;

	private int termId;

	public Roster() {
	}

	public RosterPK getId() {
		return this.id;
	}

	public void setId(RosterPK id) {
		this.id = id;
	}

	public int getTermId() {
		return this.termId;
	}

	public void setTermId(int termId) {
		this.termId = termId;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Roster [id=" + id + ", termId=" + termId + "]";
	}

}