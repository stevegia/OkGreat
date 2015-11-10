package jpaentities;

import javax.persistence.*;

/**
 * Created by Gartusk on 11/1/2015.
 */


@Entity
@Table(name="tcsclass")
public class TCSClass {
    //default serial version id, required for serializable classes.
    private static final long serialVersionUID = 1L;
    public TCSClass(){};


    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private int id;
    private String unrefinedId;
    private String refinedId;
    private String subject;
    private String catalogNumber;
    private String section;
    private String InstructorNetId;
    @Version
    private int version;

    /**
     *
     * @param id
     * @param unrefinedId
     * @param refinedId
     * @param subject
     * @param catalogNumber
     * @param section
     * @param instructorNetId
     */
    public TCSClass(int id, String unrefinedId, String refinedId, String subject, String catalogNumber, String section, String instructorNetId) {
        this.id = id;
        this.unrefinedId = unrefinedId;
        this.refinedId = refinedId;
        this.subject = subject;
        this.catalogNumber = catalogNumber;
        this.section = section;
        InstructorNetId = instructorNetId;
    }


    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUnrefinedId() {
        return unrefinedId;
    }

    public void setUnrefinedId(String unrefinedId) {
        this.unrefinedId = unrefinedId;
    }

    public String getRefinedId() {
        return refinedId;
    }

    public void setRefinedId(String refinedId) {
        this.refinedId = refinedId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getCatalogNumber() {
        return catalogNumber;
    }

    public void setCatalogNumber(String catalogNumber) {
        this.catalogNumber = catalogNumber;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public String getInstructorNetId() {
        return InstructorNetId;
    }

    public void setInstructorNetId(String instructorNetId) {
        InstructorNetId = instructorNetId;
    }
}
