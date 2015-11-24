package application;

import jpaentities.Exam;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Haseeb on 11/21/2015.
 */
public class Validator {
    /*
	 * The singleton Validator object. It will only get instantiated once in the lifetime of the program.
	 */
    private static Validator singleton = null;

    // variables needed for JPA queries
    private static EntityManagerFactory emf;
    private static EntityManager em;
    private static Query query;

    /**
     * Private class constructor. It will only get called once in the lifetime of the program.
     * Instantiates EntityManagerFactory and EntityManager objects needed for JPA queries.
     */
    private Validator() {
        emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
        em = emf.createEntityManager();
    }

    /**
     * Ensures the Retriever class is only initiated once.
     * @return the singleton Validator
     */
    public static Validator getInstance() {
        if(singleton == null)
            singleton = new Validator();
        return singleton;
    }

    /**
     * Checks to see if exam exists and if student is eligible to take it.
     * @param netId
     * @param examRefinedId
     * @return true if student is eligible for exam, false if ineligible
     */
    public boolean eligibleForExam(String netId, String examRefinedId) {
        Retriever retriever = Retriever.getInstance();
        Exam exam = retriever.getExam(examRefinedId);
        // Exam not found
        if (exam == null) return false;

        long count;
        try {
            if (exam.getExamType().equals("COURSE")) {
                // Exam is a course exam
                query = em.createQuery("SELECT COUNT(r) FROM Roster r, TCSClass t, CourseExam c, TestingCenter tc " +
                        "WHERE r.id.netId = ?1 AND r.id.TCSClassUnrefinedId = t.unrefinedId AND t.refinedId = c.id.TCSClassRefinedId");
                query.setParameter(1, netId);

                count = (long) query.getSingleResult();
                // student is not registered for the course
                if (count == 0) return false;
            } else {
                // Exam is an ad-hoc exam
                query = em.createQuery("SELECT COUNT(a) FROM AdHocExam a WHERE a.id.studentNetId = ?1 AND a.id.examRefinedId = ?2");
                query.setParameter(1, netId);
                query.setParameter(2, examRefinedId);

                count = (long) query.getSingleResult();
                // student is not on list to take ad-hoc exam
                if (count == 0) return false;
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Checks to see if specified student has an existing appointment for specified exam
     * @param netId
     * @param examRefinedId
     * @return true if student does not have existing appointment for exam, false otherwise
     */
    public boolean noExistingAppointmentForExam(String netId, String examRefinedId) {
        try {
            query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.studentNetId = ?1 AND a.examRefinedId = ?2");
            query.setParameter(1, netId);
            query.setParameter(2, examRefinedId);
            long count = (long) query.getSingleResult();
            return !(count > 0);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Checks to see if student already has an appointment at specified date
     * @param netId
     * @param apptStartDate
     * @return true if student has no overlapping appointments, false otherwise
     */
    public boolean noOverlappingAppointments(String netId, Date apptStartDate) {
        try {
            query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.studentNetId = ?1 AND ?2 BETWEEN a.startDate AND a.endDate");
            query.setParameter(1, netId);
            query.setParameter(2, apptStartDate, TemporalType.TIMESTAMP);
            long count = (long) query.getSingleResult();
            return !(count > 0);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Checks to see if entire duration of appointment is within time period exam is active
     * @param apptStartDate
     * @param apptEndDate
     * @param exam
     * @return true if appointment is within exam's bounds, false otherwise
     */
    public boolean isAppointmentWithinExamTime(Date apptStartDate, Date apptEndDate, Exam exam) {
        return !(apptStartDate.before(exam.getStartDate()) || apptEndDate.after(exam.getEndDate()));
    }

}
