package application;

import jpaentities.Appointment;
import jpaentities.Exam;
import jpaentities.TestingCenter;
import jpaentities.TestingCenterHour;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

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
            query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.studentNetId = ?1 AND a.examRefinedId = ?2 AND a.appointmentStatus <> 'CANCELLED'");
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
     * Checks to see if there is already an appointment at specified date
     * @param apptStartDate
     * @return true if there are no overlapping appointments, false otherwise
     */
    public boolean noOverlappingAppointments(Date apptStartDate) {
        try {
            query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.appointmentStatus <> 'CANCELLED' AND ?1 BETWEEN a.startDate AND a.endDate");
            query.setParameter(1, apptStartDate, TemporalType.TIMESTAMP);
            long count = (long) query.getSingleResult();
            return !(count > 0);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Checks to see if the testing center has enough time to hold the exam
     * @param examStart exam start date
     * @param examEnd exam end date
     * @param numberOfStudents number of students needing to take the exam
     * @param duration duration of the exam IN MINUTES
     * @return true if there is enough time to schedule the exam, false otherwise
     */
    public boolean isSchedulable(Date examStart, Date examEnd, int numberOfStudents, int duration) {
        LocalDateTime start = examStart.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().atStartOfDay();
        LocalDateTime end = examEnd.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        Retriever retriever = Retriever.getInstance();

        // FIRST GET THE TOTAL NUMBER OF MINUTES THE TESTING CENTER HAS AVAILABLE IN THE DATE RANGE
        int totalTestingCenterMinutes = 0;
        LocalTime hourStart;
        LocalTime hourEnd;
        for (LocalDateTime date = start; date.isBefore(end); date = date.plusDays(1)) {
            Date convertedDate = Date.from(date.atZone(ZoneId.systemDefault()).toInstant());
            TestingCenterHour tch = retriever.getTestingCenterHour(convertedDate);
            if (tch != null) {
                hourStart = tch.getStartTime().toLocalTime();
                hourEnd = tch.getEndTime().toLocalTime();
                totalTestingCenterMinutes += (int) ChronoUnit.MINUTES.between(hourStart, hourEnd);
            }
            else return false;
        }

        TestingCenter testingCenter = Retriever.getTestingCenter();
        totalTestingCenterMinutes *= testingCenter.getNumberOfSeats() - testingCenter.getNumberOfSetAsideSeats();

        // SECOND GET THE TOTAL NUMBER OF MINUTES BEING TAKEN UP BY EXISTING APPOINTMENTS IN THE DATE RANGE
        List<Appointment> appointments;
        try {
            query = em.createQuery("SELECT a FROM Appointment a WHERE a.appointmentStatus <> 'CANCELLED' AND a.startDate BETWEEN ?1 and ?2");
            query.setParameter(1, examStart, TemporalType.TIMESTAMP);
            query.setParameter(2, examEnd, TemporalType.TIMESTAMP);
            appointments = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        int totalApptDuration = 0;
        LocalDate apptStart;
        LocalDate apptEnd;
        for (Appointment appointment : appointments) {
            apptStart = appointment.getStartDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            apptEnd = appointment.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            totalApptDuration += (int) ChronoUnit.MINUTES.between(apptStart, apptEnd);
        }

        // LASTLY GET THE TOTAL NUMBER OF MINUTES THE EXAM NEEDS FOR ALL ITS STUDENTS
        int totalExamDuration = numberOfStudents * (duration + testingCenter.getGapTime());

        return totalExamDuration <= totalTestingCenterMinutes - totalApptDuration;
    }

}
