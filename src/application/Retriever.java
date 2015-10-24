package application;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import jpaentities.TCSUser;
import jpaentities.Appointment;
import jpaentities.Course;
import jpaentities.Exam;
import jpaentities.Rooster;
import jpaentities.Seat;
import jpaentities.TestingCenter;
import jpaentities.TestingCenterHour;
import jpaentities.TestingCenterHourPK;
import jpaentities.ClosedDate;
import jpaentities.ClosedDatePK;


/**
 * @author Haseeb Shahid
 *
 */
public class Retriever {
	public static TCSUser validate(String netId, String password) {
		try {
			System.out.println("before EMF");
        	EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
    		EntityManager em = emf.createEntityManager();
			System.out.println("After EMF");
    		Query query = em.createQuery("SELECT t FROM TCSUser t WHERE t.netId = ?1 AND t.password = ?2");
    		query.setParameter(1, netId);
    		query.setParameter(2, password);
			TCSUser user = (TCSUser) query.getSingleResult();
			System.out.println(query.toString());
    		return user ;
        } catch(Exception e) {
        	return null;
        }
	}
    public static TestingCenter getTestingCenter() {
        try {
            System.out.println("before EMF");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
            EntityManager em = emf.createEntityManager();
            System.out.println("After EMF");
            Query query = em.createQuery("SELECT t FROM TestingCenter t");
            TestingCenter testingCenter = (TestingCenter) query.getSingleResult();
            System.out.println(query.toString());
            return testingCenter;
        } catch(Exception e) {
            return null;
        }
    }       
    public static TestingCenterHour getTestingCenterHour(DATE date) {
        try {
            System.out.println("before EMF");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
            EntityManager em = emf.createEntityManager();
            System.out.println("After EMF");
            Query query = em.createQuery("SELECT t FROM TestingCenterHour t WHERE t.Date = ?1");
            query.setParameter(1, date);
            TestingCenterHour hour = (TestingCenterHour) query.getSingleResult();
            System.out.println(query.toString());
            return hour;
        } catch(Exception e) {
            return null;
        }
    }        
    public static Roster getRoster(String netId, String courseId) {
        try {
            System.out.println("before EMF");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
            EntityManager em = emf.createEntityManager();
            System.out.println("After EMF");
            Query query = em.createQuery("SELECT t FROM Roster t WHERE t.NetId = ?1 AND t.CourseId = ?2");
            query.setParameter(1, netId);
            query.setParameter(2, courseId);
            Roster roster = (Roster) query.getSingleResult();
            System.out.println(query.toString());
            return roster;
        } catch(Exception e) {
            return null;
        }
    } 
    public static Appointment getAppointment(Date date) {
        try {
            System.out.println("before EMF");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
            EntityManager em = emf.createEntityManager();
            System.out.println("After EMF");
            Query query = em.createQuery("SELECT FROM Appoint WHERE date = ?1");
            query.setParameter(1, date);
            Appointment appointment = (Appointment) query.getSingleResult();
            System.out.println(query.toString());
            return appointment ;
        } catch(Exception e) {
            return null;
        }
    }  
    public static Exam getExam(Date date) {
        try {
            System.out.println("before EMF");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
            EntityManager em = emf.createEntityManager();
            System.out.println("After EMF");
            Query query = em.createQuery("SELECT FROM Exam WHERE StartDate >= ?1 AND EndDate <= ?1");
            query.setParameter(1, date);
            Exam exam = (Exam) query.getSingleResult();
            System.out.println(query.toString());
            return exam ;
        } catch(Exception e) {
            return null;
        }
    }     
    public static Exam getExam(Date date, String status) {
        try {
            System.out.println("before EMF");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
            EntityManager em = emf.createEntityManager();
            System.out.println("After EMF");
            Query query = em.createQuery("SELECT FROM Exam WHERE StartDate >= ?1 AND EndDate <= ?1 AND Status = ?2");
            query.setParameter(1, date);
            query.setParameter(2, status);
            Exam exam = (Exam) query.getSingleResult();
            System.out.println(query.toString());
            return exam ;
        } catch(Exception e) {
            return null;
        }
    }      
}
