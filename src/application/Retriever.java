/**
 * 
 */
package application;

import javax.persistence.*;

import jpaentities.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.List;
import java.util.Date;
import jpaentities.TCSUser;

import java.util.*;

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

	public void persist(Object o){
		em.getTransaction().begin();
		em.persist(o);
		em.getTransaction().commit();
	}


	public List<Appointment> getAppointmentsForStudent(String netId, int termId) {
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.studentNetId = ?1 AND a.termId = ?2");
			query.setParameter(1, netId);
			query.setParameter(2, termId);

			// appointment(s) exists in database
			return query.getResultList();
		} catch(Exception e) {
			// user not found in database
			return null;
		}
	}

	public Appointment getAppointmentByID(int appointmentID){
		try{
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.id = ?1");
			query.setParameter(1, appointmentID);

			return (Appointment) query.getSingleResult();
		}catch (Exception e){
			//appointment not found in database
			return null;
		}
	}

	public List<Appointment> getAppointmentsInTerm(int termId) {
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.termId = ?1");
			query.setParameter(1, termId);

			// appointment(s) exists in database
			return query.getResultList();
		} catch(Exception e) {
			// user not found in database
			return null;
		}
	}

	public List<Appointment> getAppointmentsBetweenDates(Date date1, Date date2) {
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.appointmentDate BETWEEN ?1 AND ?2");
			query.setParameter(1, date1, TemporalType.TIMESTAMP);
			query.setParameter(2, date2, TemporalType.TIMESTAMP);

			// appointment(s) exists in database
			return query.getResultList();
		} catch (Exception e) {
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

		try {
			query = em.createQuery("SELECT t FROM TestingCenter t");
			// return the testing center if it exists in the database
			return (TestingCenter) query.getSingleResult();
		} catch (Exception e) {
			// the testing center does not exist in the database
			return null;
		}
	}
		}
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
	public Appointment getAppointment(int id){
		query = em.createQuery("SELECT t FROM Appointment t WHERE t.id = ?1");
		query.setParameter(1, id);
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
		try{	query = em.createQuery("SELECT t FROM Exam t WHERE t.termId = ?1 AND t.instructorNetId =?2");
			query.setParameter(1, termId);
			query.setParameter(2, netId);


			JSONArray arrayToReturn = new JSONArray();


			List<Exam> returnedExamList = query.getResultList();

			for(Exam exam : returnedExamList){
				JSONObject examJson = new JSONObject();



				examJson.put("examName",exam.getExamName());
				examJson.put("id",exam.getId());
				examJson.put("refinedId",exam.getRefinedId());
				examJson.put("startDate",exam.getStartDate().toString());
				examJson.put("endDate",exam.getEndDate().toString());
				examJson.put("examStatus",exam.getExamStatus());
				examJson.put("duration",exam.getDuration());




				CourseExam courseExam = new CourseExam();
				try{
					query = em.createQuery("SELECT t FROM CourseExam t WHERE t.id.examRefinedId  = ?1");
					query.setParameter(1, exam.getRefinedId());
					courseExam = (CourseExam)query.getSingleResult();
				}
				catch(Exception ex){

					System.out.println("courseExam error block");
					System.out.println(ex.toString());
				}




				System.out.println("got here");
				System.out.println(courseExam.getId().getExamRefinedId());

				TCSClass tcsclass = new TCSClass();
				try{
					query = em.createQuery("SELECT t FROM TCSClass t WHERE t.refinedId = ?1");
					query.setParameter(1, courseExam.getId().getTCSClassRefinedId());
					tcsclass = (TCSClass)query.getSingleResult();
					examJson.put("subject",tcsclass.getSubject());
					examJson.put("section",tcsclass.getSection());
					examJson.put("catalogNumber",tcsclass.getCatalogNumber());



				}catch(Exception ex){
					System.out.println("TCSclass error block");
					System.out.println(ex.toString());
				}





				System.out.println(tcsclass.toString());


				query = em.createQuery("SELECT t FROM Appointment t WHERE t.examRefinedId = ?1");
				query.setParameter(1, exam.getRefinedId());
				List<Appointment> returnedAppointmentList = query.getResultList();
				JSONArray appointmentListJson = new JSONArray();
				for(Appointment appointment: returnedAppointmentList){
					JSONObject jsonAppointment = new JSONObject();
					jsonAppointment.put("id",appointment.getId());
					jsonAppointment.put("netId",appointment.getStudentNetId());
					jsonAppointment.put("seatNumber",appointment.getSeatNumber());
					jsonAppointment.put("appointmentStatus",appointment.getAppointmentStatus());
					jsonAppointment.put("appointmentDate",appointment.getAppointmentDate());
					appointmentListJson.put(jsonAppointment);
				}
				examJson.put("appointments", appointmentListJson);
				arrayToReturn.put(examJson);

			}
			System.out.print(arrayToReturn.toString());
			System.out.println("RETURN");
			return arrayToReturn.toString();
		}catch(Exception ex){
			System.out.println("outer error block");
			System.out.println(ex.toString());
			return ex.toString();


		}


	}


}
