package jpaentities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the message database table.
 * 
 */
@Entity
@Table(name = "message")
@NamedQuery(name="Message.findAll", query="SELECT m FROM Message m")
public class Message implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Lob
	private String content;

	@Temporal(TemporalType.TIMESTAMP)
	private Date dateMade;

	private String messageSubject;

	private String receiverNetId;

	public Message() {
	}

	/**
	 * @param content
	 * @param dateMade
	 * @param messageSubject
	 * @param receiverNetId
	 */
	public Message(String content, Date dateMade, String messageSubject, String receiverNetId) {
		this.content = content;
		this.dateMade = dateMade;
		this.messageSubject = messageSubject;
		this.receiverNetId = receiverNetId;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDateMade() {
		return this.dateMade;
	}

	public void setDateMade(Date dateMade) {
		this.dateMade = dateMade;
	}

	public String getMessageSubject() {
		return this.messageSubject;
	}

	public void setMessageSubject(String messageSubject) {
		this.messageSubject = messageSubject;
	}

	public String getReceiverNetId() {
		return this.receiverNetId;
	}

	public void setReceiverNetId(String receiverNetId) {
		this.receiverNetId = receiverNetId;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Message [id=" + id + ", content=" + content + ", dateMade=" + dateMade + ", messageSubject="
				+ messageSubject + ", receiverNetId=" + receiverNetId + "]";
	}

}