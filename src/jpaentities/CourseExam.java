package jpaentities;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Gartusk on 11/1/2015.
 */



@Entity
@Table(name="courseexam")
public class CourseExam {
    //default serial version id, required for serializable classes.
    private static final long serialVersionUID = 1L;



    public CourseExam(){};

    @Id
    private String examRefinedId;
    private String TCSClassRefinedId;


    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getExamRefinedId() {
        return examRefinedId;
    }

    public String getTCSClassRefinedId() {
        return TCSClassRefinedId;
    }


    /**
     *
     * @param examRefinedId
     * @param TCSClassRefinedId
     */
    public CourseExam(String examRefinedId, String TCSClassRefinedId) {
        this.examRefinedId = examRefinedId;
        this.TCSClassRefinedId = TCSClassRefinedId;
    }



}
