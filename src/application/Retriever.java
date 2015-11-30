/**
 * 
 */
package application;

import javax.persistence.*;

import jpaentities.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Date;
import jpaentities.TCSUser;
import utils.Constants;
import utils.DateUtils;

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

	public String getAppointmentsForStudentString(String netId, int termId) {
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.studentNetId = ?1 AND a.termId = ?2");
			query.setParameter(1, netId);
			query.setParameter(2, termId);
			JSONArray arrayToReturn = new JSONArray();

			List<Appointment> returnedAppointmentList = query.getResultList();

			for(Appointment appointment: returnedAppointmentList){
				JSONObject appointmentJson = new JSONObject();

				appointmentJson.put("id",appointment.getId());
				appointmentJson.put("appointmentStatus",appointment.getAppointmentStatus());
				appointmentJson.put("startDate",appointment.getStartDate());
				appointmentJson.put("endDate",appointment.getEndDate());
				appointmentJson.put("examRefinedId",appointment.getExamRefinedId());
				appointmentJson.put("termId",appointment.getTermId());
				appointmentJson.put("studentNetId",appointment.getStudentNetId());
				appointmentJson.put("testingCenterId",appointment.getTestingCenterId());
				appointmentJson.put("seatNumber",appointment.getSeatNumber());

				try{
					query = em.createQuery("SELECT t FROM Exam t WHERE t.refinedId  = ?1");
					query.setParameter(1, appointment.getExamRefinedId());
					Exam exam = (Exam)query.getSingleResult();
					appointmentJson.put("examName",exam.getExamName());
					appointmentJson.put("duration",exam.getDuration());
					/*
					appointmentJson.put("examName",courseExam.getExamName());
					appointmentJson.put("id",exam.getId());
					appointmentJson.put("refinedId",exam.getRefinedId());
					appointmentJson.put("startDate",exam.getStartDate().toString());
					appointmentJson.put("endDate",exam.getEndDate().toString());
					appointmentJson.put("examStatus",exam.getExamStatus());
					appointmentJson.put("duration",exam.getDuration())
					*/
					try{
						CourseExam courseExam = new CourseExam();
						query = em.createQuery("SELECT t FROM CourseExam t WHERE t.id.examRefinedId  = ?1");
						query.setParameter(1, exam.getRefinedId());
						courseExam = (CourseExam)query.getSingleResult();
						TCSClass tcsclass = new TCSClass();
						try{
							query = em.createQuery("SELECT t FROM TCSClass t WHERE t.refinedId = ?1");
							query.setParameter(1, courseExam.getId().getTCSClassRefinedId());
							tcsclass = (TCSClass)query.getSingleResult();
							appointmentJson.put("subject",tcsclass.getSubject());
							appointmentJson.put("section",tcsclass.getSection());
							appointmentJson.put("catalogNumber",tcsclass.getCatalogNumber());

						}catch(Exception ex){
							System.out.println("TCSclass error block");
							System.out.println(ex.toString());
						}
					}
					catch(Exception ex){

						System.out.println("courseExam error block");
						System.out.println(ex.toString());
					};
				}
				catch(Exception ex){
					System.out.println("courseExam error block");
					System.out.println(ex.toString());
				}
				arrayToReturn.put(appointmentJson);
			}

			// appointment(s) exists in database
			return arrayToReturn.toString();
		} catch(Exception ex) {
			// user not found in database
			return ex.toString();
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

	public String getAppointmentsInTermString(int termId) {
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.termId = ?1");
			query.setParameter(1, termId);;
			JSONArray arrayToReturn = new JSONArray();

			List<Appointment> returnedAppointmentList = query.getResultList();

			for(Appointment appointment: returnedAppointmentList){
				JSONObject appointmentJson = new JSONObject();

				appointmentJson.put("id",appointment.getId());

				appointmentJson.put("appointmentStatus",appointment.getAppointmentStatus());
				appointmentJson.put("startDate",appointment.getStartDate());
				appointmentJson.put("endDate",appointment.getEndDate());
				appointmentJson.put("examRefinedId",appointment.getExamRefinedId());
				appointmentJson.put("termId",appointment.getTermId());
				appointmentJson.put("studentNetId",appointment.getStudentNetId());
				appointmentJson.put("testingCenterId",appointment.getTestingCenterId());
				appointmentJson.put("seatNumber",appointment.getSeatNumber());

				try{
					query = em.createQuery("SELECT t FROM Exam t WHERE t.refinedId  = ?1");
					query.setParameter(1, appointment.getExamRefinedId());
					Exam exam = (Exam)query.getSingleResult();
					appointmentJson.put("examName",exam.getExamName());
					appointmentJson.put("instructorNetId",exam.getInstructorNetId());
					appointmentJson.put("duration",exam.getDuration());
					appointmentJson.put("examType",exam.getExamType());

					/*
					appointmentJson.put("examName",courseExam.getExamName());
					appointmentJson.put("id",exam.getId());
					appointmentJson.put("refinedId",exam.getRefinedId());
					appointmentJson.put("startDate",exam.getStartDate().toString());
					appointmentJson.put("endDate",exam.getEndDate().toString());
					appointmentJson.put("examStatus",exam.getExamStatus());
					appointmentJson.put("duration",exam.getDuration())
					*/
					try{
						CourseExam courseExam = new CourseExam();
						query = em.createQuery("SELECT t FROM CourseExam t WHERE t.id.examRefinedId  = ?1");
						query.setParameter(1, exam.getRefinedId());
						courseExam = (CourseExam)query.getSingleResult();
						TCSClass tcsclass = new TCSClass();
						try{
							query = em.createQuery("SELECT t FROM TCSClass t WHERE t.refinedId = ?1");
							query.setParameter(1, courseExam.getId().getTCSClassRefinedId());
							tcsclass = (TCSClass)query.getSingleResult();
							appointmentJson.put("subject",tcsclass.getSubject());
							appointmentJson.put("section",tcsclass.getSection());
							appointmentJson.put("catalogNumber",tcsclass.getCatalogNumber());

						}catch(Exception ex){
							System.out.println("TCSclass error block");
							System.out.println(ex.toString());
						}
					}
					catch(Exception ex){

						System.out.println("courseExam error block");
						System.out.println(ex.toString());
					};
				}
				catch(Exception ex){
					System.out.println("courseExam error block");
					System.out.println(ex.toString());
				}
				arrayToReturn.put(appointmentJson);
			}

			// appointment(s) exists in database
			return arrayToReturn.toString();
		} catch(Exception ex) {
			// user not found in database
			return ex.toString();
		}
	}

	public List<Appointment> getAppointmentsByDate(Date date){
			Date dayStart = DateUtils.getStartOfDay(date).getTime();
			Date dayEnd = DateUtils.getEndOfDay(date).getTime();

			return getAppointmentsBetweenDates(dayStart, dayEnd);
	}

	public List<Appointment> getAppointmentsBetweenDates(Date date1, Date date2) {
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.appointmentStatus <> 'CANCELLED' AND a.startDate BETWEEN ?1 AND ?2");
			query.setParameter(1, date1, TemporalType.TIMESTAMP);
			query.setParameter(2, date2, TemporalType.TIMESTAMP);

			// appointment(s) exists in database
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
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
			e.printStackTrace();
			return null;
		}
	}

	public static TestingCenter getTestingCenter() {
		try {
			query = em.createQuery("SELECT t FROM TestingCenter t");
			// return the testing center if it exists in the database
			return (TestingCenter) query.getSingleResult();
		} catch (Exception e) {
			// the testing center does not exist in the database
			e.printStackTrace();
			return null;
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
			e.printStackTrace();
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
			e.printStackTrace();
        	return null;
        }
	}

	/**
	 * Checks to see if there are seats available for a student to satisfy their appointment
	 * @param apptStartDate
	 * @return true if there are seats available, false otherwise
	 */
	public long seatsAvailable(Date apptStartDate) {
		query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.appointmentStatus <> 'CANCELLED' AND ?1 BETWEEN a.startDate AND a.endDate");
		query.setParameter(1, apptStartDate, TemporalType.TIMESTAMP);
		return (long) query.getSingleResult();
	}

    /**
     * Finds appointments that match criteria for being superfluous.
     * Sets the status of all these appointments to "SUPERFLUOUS" and returns them.
     * @param termId
     * @return a list of all superfluous appointments (could be none)
     */
    public ArrayList<Appointment> getSuperfluousAppointments(int termId) {
        ArrayList<Appointment> superfluousAppointments = new ArrayList<>();
        try {
            // get all appointments in parameter term
            query = em.createQuery("SELECT a FROM Appointment a WHERE a.termId = ?1 AND a.appointmentStatus = 'PENDING'");
            query.setParameter(1, termId);
            List<Appointment> appointments = query.getResultList();

            Retriever retriever = Retriever.getInstance();
            // check if those appointments match criteria for being superfluous
            for (Appointment appointment : appointments) {
                query = em.createQuery("SELECT COUNT(r) FROM Roster r, Appointment a, CourseExam c, TCSClass t WHERE r.id.netId = ?1 " +
                        "AND c.id.examRefinedId = ?2 AND c.id.TCSClassRefinedId = t.refinedId AND t.unrefinedId = r.id.TCSClassUnrefinedId");
                query.setParameter(1, appointment.getStudentNetId());
                query.setParameter(2, appointment.getExamRefinedId());
                long count = (long) query.getSingleResult();
                if (count == 0) {
                    appointment.setAppointmentStatus("SUPERFLUOUS");
                    retriever.persist(appointment);
                    superfluousAppointments.add(appointment);
                }
            }
        } catch (Exception e) {
            System.out.println("No appointments in specified term exist");
        }

        return superfluousAppointments;
    }

	/**
	 * Get all messages sent to the specified user
	 * @param netId
	 * @return the list of messages if the exist, null otherwise
	 */
	public List<Message> getMessagesForUser(String netId) {
		try {
			query = em.createQuery("SELECT m FROM Message m WHERE m.receiverNetId = ?1");
			query.setParameter(1, netId);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Gets all pending appointments in specified term
	 * @return the list of pending appointments if they exist, null otherwise
	 */
	public List<Appointment> getPendingAppointmentsInTerm() {
		TestingCenter testingCenter = Retriever.getTestingCenter();
		try {
			query = em.createQuery("SELECT a FROM Appointment a WHERE a.termId = ?1 AND a.appointmentStatus = 'PENDING'");
			query.setParameter(1, testingCenter.getCurrentTerm());
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
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

	public String getExamByIdString(String examRefinedId){
		query = em.createQuery("SELECT t FROM Exam t WHERE t.refinedId = ?1");
		query.setParameter(1, examRefinedId);

		JSONArray arrayToReturn = new JSONArray();
		Exam exam = (Exam) query.getSingleResult();

		JSONObject examJson = new JSONObject();

		examJson.put("examName",exam.getExamName());
		examJson.put("id",exam.getId());
		examJson.put("refinedId",exam.getRefinedId());
		examJson.put("startDate",exam.getStartDate().toString());
		examJson.put("endDate",exam.getEndDate().toString());
		examJson.put("examStatus", exam.getExamStatus());
		examJson.put("duration", exam.getDuration());

		try{
			try{
				CourseExam courseExam = new CourseExam();
				query = em.createQuery("SELECT t FROM CourseExam t WHERE t.id.examRefinedId  = ?1");
				query.setParameter(1, exam.getRefinedId());
				courseExam = (CourseExam)query.getSingleResult();
				TCSClass tcsclass = new TCSClass();
				query = em.createQuery("SELECT t FROM TCSClass t WHERE t.refinedId = ?1");
				query.setParameter(1, courseExam.getId().getTCSClassRefinedId());
				tcsclass = (TCSClass)query.getSingleResult();
				examJson.put("subject",tcsclass.getSubject());
				examJson.put("section",tcsclass.getSection());
				examJson.put("catalogNumber",tcsclass.getCatalogNumber());
				query = em.createQuery("SELECT t FROM Appointment t WHERE t.examRefinedId = ?1");
				query.setParameter(1, exam.getRefinedId());
				Appointment appointment = (Appointment)query.getSingleResult();
				examJson.put("seatNumber",appointment.getSeatNumber());
				examJson.put("appointmentStatus",appointment.getAppointmentStatus());
				examJson.put("appointmentDate",appointment.getStartDate());
				return examJson.toString();
			}catch(Exception ex){}


		}catch(Exception ex){

		}
		return examJson.toString();

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
				examJson.put("examType",exam.getExamType());

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
					jsonAppointment.put("appointmentDate",appointment.getStartDate());
					appointmentListJson.put(jsonAppointment);
				}
				examJson.put("appointments", appointmentListJson);
				arrayToReturn.put(examJson);
			}
			return arrayToReturn.toString();
		}catch(Exception ex){
			return ex.toString();
		}
	}


	public String getAllExamsInTermString( int termId){
		try{	query = em.createQuery("SELECT t FROM Exam t WHERE t.termId = ?1");
			query.setParameter(1, termId);
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
				examJson.put("examType",exam.getExamType());
				if(exam.getExamStatus().equals("PENDING")){
					String utilafter = getUtilizationWithExam(exam.getStartDate(),exam.getEndDate(),exam);
					String utilbefore = getUtilizationForDateRange(exam.getStartDate(), exam.getEndDate());
					examJson.put("utilbefore",utilbefore);
					examJson.put("utilafter",utilafter);

				}else{
					examJson.put("utilbefore","");
					examJson.put("utilafter", "");
				}

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
					jsonAppointment.put("appointmentDate",appointment.getStartDate());
					appointmentListJson.put(jsonAppointment);
				}
				examJson.put("appointments", appointmentListJson);
				arrayToReturn.put(examJson);
			}
			return arrayToReturn.toString();
		}catch(Exception ex){
			return ex.toString();
		}
	}

	/**
	 * For getting a utilization as a standalone operation or before approving an exam
	 */
	public String getUtilizationForDateRange(Date startDate, Date endDate) throws ParseException {
		return getUtilizationWithExam(startDate, endDate, null);
	}

	/**
	 * Calculates utilization within the range of dates
	 * If exam is not null, adds the expected utilization if exam is approved
	 */
	public String getUtilizationWithExam(Date startDate, Date endDate, Exam exam) throws ParseException {

		JSONArray result = new JSONArray();


		TestingCenter tc = getTestingCenter();
		int numSeats = tc.getNumberOfSeats();
		int gapTime = tc.getGapTime();


		double newExamUtilization = calculateExpectedUtilizationPerExam(gapTime, exam);

		Calendar calendar = DateUtils.getStartOfDay(startDate);

		while(calendar.before(endDate)){
			Date currentDate = calendar.getTime();

			List<Appointment> appointments = getAppointmentsByDate(currentDate);
			TestingCenterHour tcHour = getTestingCenterHour(currentDate);
			double openTime = DateUtils.getDurationInHours(tcHour.getStartTime(), tcHour.getEndTime());

			double utilization;
			utilization = calculateActualUtilization(appointments, numSeats, openTime, gapTime);
			if (DateUtils.getEndOfDay(currentDate).after(new Date())){
				List<Exam> exams = getActiveAndApprovedExamsOnDate(currentDate);
				utilization += calculateExpectedUtilization(exams, gapTime);
			}

			if(exam != null){
				if(DateUtils.isDayInRange(exam.getStartDate(), exam.getEndDate(), calendar)){
					utilization += newExamUtilization;
				}
			}

			JSONObject obj = new JSONObject();
			obj.put(Constants.DATE, currentDate.toString());
			obj.put(Constants.UTILIZATION, utilization);
			result.put(obj);

			calendar.add(Calendar.DATE, 1);
		}

		return result.toString();
	}

	private double calculateActualUtilization(List<Appointment> appointments, int numSeats, double openTime, int gapTime) {
		double totalDuration = getTotalDuration(appointments, gapTime);
		return totalDuration/ (numSeats * openTime);
	}

	private double getTotalDuration(List<Appointment> appointments, int gapTime) {
		double result = 0;
		for(Appointment appointment: appointments){
			result += DateUtils.getDurationInHours(appointment.getStartDate(), appointment.getEndDate());
		}
		return result;
	}

	/**
	 * This method calculates only the expected component of expected utilization
	 * To get the full expected utilization this value must be added to actual utilization
	 * @return
	 */
	private double calculateExpectedUtilization(List<Exam> exams, int gapTime){
		double result = 0.0;
		for(Exam exam: exams){
			result += calculateExpectedUtilizationPerExam(gapTime, exam);
		}
		return result;
	}

	/**
	 * Calculates the daily expected utilization of one exam. Returns 0.0 if exam is null
	 * @param gapTime
	 * @param exam
	 * @return
	 */
	private double calculateExpectedUtilizationPerExam(int gapTime, Exam exam) {
		if(exam == null) return 0.0;
		double result;
		int duration = exam.getDuration() + gapTime;
		int remainingApps = exam.getNumberOfStudents() - exam.getNumberOfAppointments();
		int numDays = DateUtils.getNumberOfDaysInRange(exam.getStartDate(), exam.getEndDate());

		result = duration * (remainingApps / numDays);
		return result;
	}

	public List<Exam> getActiveAndApprovedExamsOnDate(Date date){
		query = em.createQuery("SELECT e FROM Exam e WHERE e.startDate >= ?1 AND e.endDate <= ?2 AND " +
				"e.examStatus IN ('ACTIVE', 'APPROVED')");
		Calendar startOfDay = DateUtils.getStartOfDay(date);
		Calendar endOfDay = DateUtils.getEndOfDay(date);
		query.setParameter(1, startOfDay.getTime());
		query.setParameter(2, endOfDay.getTime());
		return query.getResultList();
	}

	public String getExamsForCalender(String netId, int termId){

		query = em.createQuery("SELECT a FROM Appointment a WHERE a.studentNetId = ?1 AND a.termId = ?2");
		query.setParameter(1, netId);
		query.setParameter(2, termId);
		JSONArray arrayToReturn = new JSONArray();

		List<Appointment> returnedAppointmentList = query.getResultList();


		for(Appointment appointment: returnedAppointmentList){
			JSONObject eventJson = new JSONObject();


			try{
				query = em.createQuery("SELECT t FROM Exam t WHERE t.refinedId  = ?1");
				query.setParameter(1, appointment.getExamRefinedId());
				Exam exam = (Exam)query.getSingleResult();
				eventJson.put("id",appointment.getExamRefinedId());
				eventJson.put("title",exam.getExamName());
				eventJson.put("url","appointmentModal.jsp?id=" + appointment.getExamRefinedId());
				eventJson.put("class","event-important");
				long startInMiliseconds = appointment.getStartDate().getTime();
				long endInMiliseconds = appointment.getEndDate().getTime();

				eventJson.put("start", startInMiliseconds);
				eventJson.put("end", endInMiliseconds);

				arrayToReturn.put(eventJson);

			}catch(Exception ex){

			}

		}
		return arrayToReturn.toString();
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

	public List<TestingCenterHour> getTestingCenterHour(){
		List<TestingCenterHour> returnedList = null;
		try {
			query = em.createQuery("SELECT t FROM TestingCenterHour t");
			returnedList = query.getResultList();
			for (TestingCenterHour element : returnedList) {
				System.out.println(element.toString());
			}
		} catch(Exception e) {
			return null;
		}
		return returnedList;
	}

	public String getTestingCenterHourForCalender(){
		JSONArray arrayToReturn = new JSONArray();
		try {
			query = em.createQuery("SELECT t FROM TestingCenterHour t");
			List  <TestingCenterHour> returnedList = query.getResultList();

			for (TestingCenterHour element : returnedList) {
				JSONObject hoursJson = new JSONObject();

				try{
					query = em.createQuery("SELECT c FROM ClosedDate c WHERE c.id.testingCenterId = ?1 AND c.id.closedDate = ?2 ");
					query.setParameter(1, element.getId().getTestingCenterId());
					query.setParameter(2, element.getId().getOpenDate());
					ClosedDate closedDate = (ClosedDate) query.getSingleResult();
					if(closedDate !=null){
						hoursJson.put("class","event-warning ");
					}else{
						hoursJson.put("class","event-info");
					}
				}catch(Exception ex){
					hoursJson.put("class","event-info");
					System.out.println(ex.toString());
				}
				hoursJson.put("id",element.getId().getTestingCenterId()+"and"+element.getId().getOpenDate());
				hoursJson.put("title","Testing Center Hours");
				hoursJson.put("url","timeModal.jsp?testingCenterId=" + element.getId().getTestingCenterId() +"&openDate="+element.getId().getOpenDate());
				System.out.println(element.getId().getOpenDate().getTime());
				long startInMiliseconds = element.getId().getOpenDate().getTime() + element.getStartTime().getTime()-18000000;
				long endInMiliseconds = element.getId().getOpenDate().getTime() +element.getEndTime().getTime()-18000000;
				hoursJson.put("start", startInMiliseconds);
				hoursJson.put("end", endInMiliseconds);
				arrayToReturn.put(hoursJson);
			}
		} catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
		return arrayToReturn.toString();
	}


	public String getTestingCenterHour(String incomingDate) throws ParseException {
		TestingCenterHour returnedList = null;
		JSONObject hoursJson = new JSONObject();

		SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM d HH:mm:ss z yyy");

		Date date = formatter.parse(incomingDate);
		System.out.println(incomingDate);
		System.out.println(date.toString());
		try {
			query = em.createQuery("SELECT t FROM TestingCenterHour t WHERE t.id.openDate = ?1");
			query.setParameter(1, date);
			returnedList =(TestingCenterHour) query.getSingleResult();
			long startInMiliseconds = returnedList.getId().getOpenDate().getTime() + returnedList.getStartTime().getTime()-18000000;
			long endInMiliseconds = returnedList.getId().getOpenDate().getTime() +returnedList.getEndTime().getTime()-18000000;
			hoursJson.put("date", date);
			hoursJson.put("start", new Date(startInMiliseconds));
			hoursJson.put("end", new Date(endInMiliseconds));
			hoursJson.put("startTime", returnedList.getStartTime());
			hoursJson.put("endTime", returnedList.getEndTime());


		} catch(Exception e) {
			System.out.println("Testing Center Hour date" + e.toString());
			return null;
		}


		return hoursJson.toString();
	}

	public TestingCenterHour getTestingCenterHour(Date date){
		TestingCenterHour returnedList = null;
		try {
			query = em.createQuery("SELECT t FROM TestingCenterHour t WHERE t.id.openDate = ?1");
			query.setParameter(1, date, TemporalType.DATE);
			returnedList =(TestingCenterHour) query.getSingleResult();
		} catch(Exception e) {
			return null;
		}
		return returnedList;
	}
	public TCSUser getUser(String netid){
		query = em.createQuery("SELECT u FROM TCSUser u WHERE u.netId = ?1");
		query.setParameter(1, netid);
		TCSUser user = (TCSUser) query.getSingleResult();
		return user;
	}


	public String getReportInTerm(int termId){
		String report="";
		Date startDate=null;
		Date endDate=null;
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
		GregorianCalendar cal = new GregorianCalendar();
		try{
			query = em.createQuery("SELECT t.startDate FROM Term t WHERE t.id = ?1");
			query.setParameter(1, termId);
			startDate = (Date) query.getSingleResult();
			query = em.createQuery("SELECT t.endDate FROM Term t WHERE t.id = ?1");
			query.setParameter(1, termId);
			endDate = (Date) query.getSingleResult();
			/* Day */
			cal.setTime(startDate);
			report+="<U><h3>Day</h3></U><br>";
			while (!cal.getTime().after(endDate)) {
				Date d = cal.getTime();
				cal.add(Calendar.DAY_OF_YEAR, 1);
				query = em.createQuery("SELECT COUNT(a.id) FROM Appointment a WHERE a.startDate BETWEEN ?1 AND ?2 AND (a.appointmentStatus='CHECKED_IN' OR a.appointmentStatus='APPROVED')");
				query.setParameter(1, d, TemporalType.DATE);
				query.setParameter(2, cal.getTime(), TemporalType.DATE);
				long count = (long) query.getSingleResult();
				if(count==1)
					report+=dateFormatter.format(d)+": "+count+" appointment<br>";
				else
					report+=dateFormatter.format(d)+": "+count+" appointments<br>";
			}
			/* Week */
			cal.setTime(startDate);
			report+="<U><h3>Week</h3></U><br>";
			while (!cal.getTime().after(endDate)) {
				Date startD = cal.getTime();
				int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
				cal.add(Calendar.DAY_OF_YEAR, 7-dayOfWeek);  //to get end date of week
				Date endD = cal.getTime();
				query = em.createQuery("SELECT COUNT(a.id) FROM Appointment a WHERE a.startDate BETWEEN ?1 AND ?2 AND (a.appointmentStatus='CHECKED_IN' OR a.appointmentStatus='APPROVED')");
				query.setParameter(1, startD, TemporalType.DATE);
				query.setParameter(2, endD, TemporalType.DATE);
				long count = (long)query.getSingleResult();
				if(count==1)
					report+=dateFormatter.format(startD)+": "+count+" appointment<br>";
				else
					report+=dateFormatter.format(startD)+": "+count+" appointments<br>";

				query = em.createQuery("SELECT DISTINCT c.subject, c.catalogNumber, c.section FROM Appointment a, TCSClass c, Exam e, CourseExam ce WHERE a.startDate BETWEEN ?1 AND ?2 " +
						"AND a.examRefinedId=e.refinedId AND e.refinedId=ce.id.examRefinedId AND ce.id.TCSClassRefinedId =c.refinedId " +
						"AND (a.appointmentStatus='CHECKED_IN' OR a.appointmentStatus='APPROVED')");
				query.setParameter(1, startD, TemporalType.DATE);
				query.setParameter(2, endD, TemporalType.DATE);
				report+="&nbsp&nbsp&nbsp&nbsp&nbsp Courses: ";
				List<Object[]> courseInfos = query.getResultList();
				for(Object[] courseInfo : courseInfos) {
					report+=(String) courseInfo[0]+courseInfo[1]+courseInfo[2]+"_"+termId+", ";
				}
				report=report.substring(0, report.length()-2);    //remove final ", "
				report+="<br>";
				cal.add(Calendar.DAY_OF_YEAR, 1);
			}

			/* Term */
			report+="<U><h3>Term</h3></U><br>";
			query = em.createQuery("SELECT DISTINCT c.subject, c.catalogNumber, c.section FROM Appointment a, TCSClass c, Exam e, CourseExam ce WHERE a.termId = ?1 " +
					"AND a.examRefinedId=e.refinedId AND e.refinedId=ce.id.examRefinedId AND ce.id.TCSClassRefinedId =c.refinedId " +
					"AND (a.appointmentStatus='CHECKED_IN' OR a.appointmentStatus='APPROVED') ORDER BY c.id ASC");
			query.setParameter(1, termId);
			query.getResultList();
			report+="Courses: ";
			List<Object[]> courseInfos = query.getResultList();
			for(Object[] courseInfo : courseInfos) {
				report+=(String) courseInfo[0]+courseInfo[1]+courseInfo[2]+"_"+termId+", ";
			}
			report=report.substring(0, report.length()-2);    //remove final ", "
			report+="<br>";
			return report;
		}catch(Exception ex){
			return ex.toString();
		}
	}
	public String getReportBetweenTerms(int termId1, int termId2){
		String report="";
		Date startDate1=null;
		Date startDate2=null;
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
		Date d=null;
		try{
			query = em.createQuery("SELECT t.startDate FROM Term t WHERE t.id = ?1");
			query.setParameter(1, termId1);
			startDate1 = (Date) query.getSingleResult();
			query = em.createQuery("SELECT t.startDate FROM Term t WHERE t.id = ?1");
			query.setParameter(1, termId2);
			startDate2 = (Date) query.getSingleResult();
			if((startDate1.after(startDate2))){  //swap end and start if needed
				d = startDate1;
				startDate1 = startDate2;
				startDate2 = d;
			}
			query = em.createQuery("SELECT t.id FROM Term t WHERE t.startDate >= ?1 AND t.startDate <= ?2 ORDER BY t.id ASC");  //get termIds of all terms in range
			query.setParameter(1, startDate1);
			query.setParameter(2, startDate2);
			List<Integer> termIds = query.getResultList();
			for(Integer id : termIds){
				query = em.createQuery("SELECT COUNT(a.id) FROM Appointment a WHERE a.termId = ?1 AND (a.appointmentStatus='CHECKED_IN' OR a.appointmentStatus='APPROVED')");
				query.setParameter(1, id);
				long count = (long) query.getSingleResult();
				if(count==1)
					report+="Term "+ id+": "+count+" Appointments<br>";
				else
					report+="Term "+ id+": "+count+" Appointments<br>";
			}
			return report;

		}catch(Exception ex){
			return ex.toString();
		}
	}
	public List<Term> getTerms() {
		try {
			query = em.createQuery("SELECT t FROM Term t");
			return query.getResultList();
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}


