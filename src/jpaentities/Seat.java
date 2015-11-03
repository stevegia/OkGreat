package jpaentities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the seat database table.
 * 
 */
@Entity
@NamedQuery(name="Seat.findAll", query="SELECT s FROM Seat s")
public class Seat implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int number;

	private byte setAside;

	public Seat() {
	}

	public int getNumber() {
		return this.number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public byte getSetAside() {
		return this.setAside;
	}

	public void setSetAside(byte setAside) {
		this.setAside = setAside;
	}

}