/**
 * 
 */
package application;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import jpaentities.Appointment;
import jpaentities.Exam;
import jpaentities.TCSUser;
import jpaentities.Term;

import java.util.List;

import java.util.List;

/**
 * @author Haseeb Shahid
 *
 */
public class Retriever {
	/*
	 * The singleton Retriever object. It will only get instantiated once in the lifetime of the program.
	 */
	private static Retriever singleton = null;
	
	// variables needed for JPA queries
	private static EntityManagerFactory emf;
	private static EntityManager em;
	private static Query query;
	
	/**
	 * Private class constructor. It will only get called once in the lifetime of the program.
	 * Instantiates EntityManagerFactory and EntityManager objects needed for JPA queries.
	 */
	private Retriever() {
		emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
		em = emf.createEntityManager();
	}
	
	/**
	 * Ensures the Retriever class is only initiated once.
	 * @return the singleton Retriever
	 */
	public static Retriever getInstance() {
		if(singleton == null)
			singleton = new Retriever();
		return singleton;
	}

	public List<Appointment> getAppointmentsForStudent(String netId) {
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.studentNetId = ?1");
			query.setParameter(1, netId);

			// appointment(s) exists in database
			return query.getResultList();
		} catch(Exception e) {
			// user not found in database
			return null;
		}
	}

	public Exam getExam(String examRefinedId) {
		try {
			query = em.createQuery("SELECT e FROM Exam e WHERE e.refinedId = ?1");
			query.setParameter(1, examRefinedId);

			// exam exists in database
			return (Exam) query.getSingleResult();
		} catch(Exception e) {
			// exam not found in database
			return null;
		}
	}
	
	/**
	 * Queries the database for a TCSUser object with specified netId and password.
	 * @param netId
	 * @param password
	 * @return the TCSUser matching the parameters if present or null if not present
	 */
	public TCSUser getUser(String netId, String password) {
		try {
    		query = em.createQuery("SELECT t FROM TCSUser t WHERE t.netId = ?1 AND t.password = ?2");
    		query.setParameter(1, netId);
    		query.setParameter(2, password);
    		System.out.println(netId);

    		// user exists in database
    		return (TCSUser) query.getSingleResult();
        } catch(Exception e) {
        	// user not found in database
        	return null;
        }
	}

	public Appointment testGetAppointment(){
		query = em.createQuery("SELECT t FROM Appointment t WHERE t.id = ?1");
		query.setParameter(1, 0);
		Appointment result = (Appointment) query.getSingleResult();
		System.out.println(result.toString());
	return result;
	}


	public List<Exam> getExamsInTerm(String netId, int termId){
		query = em.createQuery("SELECT t FROM Exam t WHERE t.termId = ?1 AND t.instructorNetId =?2");
		query.setParameter(1, termId);
		query.setParameter(2, netId);

		List<Exam> returnedList = query.getResultList();

		for(Exam element : returnedList){
			System.out.println(element.toString());
		}


		return returnedList;


	}

	public String getExamsInTermString(String netId, int termId){
		query = em.createQuery("SELECT t FROM Exam t WHERE t.termId = ?1 AND t.instructorNetId =?2");
		query.setParameter(1, termId);
		query.setParameter(2, netId);

		String JSONTORETURN = "[";

		List<Exam> returnedList = query.getResultList();

		for(Exam element : returnedList){
			System.out.println(element.toString());
		}


		return "";
	}


}
