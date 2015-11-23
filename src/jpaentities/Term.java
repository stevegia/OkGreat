package jpaentities;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.*;

/**
 * Created by Gartusk on 10/31/2015.
 */

@Entity
@Table(name = "term")
public class Term implements Serializable {
    //default serial version id, required for serializable classes.
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private int id;
    private String termName;
    private Timestamp startDate;
    private Timestamp endDate;



    public Term(){}
    /**
     * @param id
     * @param termName
     * @param startDate
     * @param endDate
     *
     */
    public Term(int id,String termName,Timestamp startDate, Timestamp endDate){
        this.id= id;
        this.termName = termName;
        this.startDate = startDate;
        this.endDate = endDate;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTermName() {
        return termName;
    }

    public void setTermName(String termName) {
        this.termName = termName;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "Term{" +
                "id='" + id + '\'' +
                ", termName='" + termName + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                '}';
    }
}
