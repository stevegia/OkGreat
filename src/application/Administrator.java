/**
 * 
 */
package application;

import jpaentities.Appointment;
import jpaentities.Exam;
import jpaentities.TCSUser;
import jpaentities.TestingCenter;
import utils.Constants;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author Haseeb Shahid
 *
 */
@SuppressWarnings("serial")
public class Administrator extends TCSUser {

	/**
	 * Default constructor
	 */
	public Administrator() {
		this.setUserType(Constants.UserType.ADMINISTRATOR);
	}

	/**
	 * @param netId
	 * @param email
	 * @param password
	 * @param firstName
	 * @param lastName
	 */
	public Administrator(String netId, String email, String password, String firstName, String lastName) {
		super(netId, email, password, firstName, lastName, "ADMINISTRATOR");
	}
	
	/**
	 * @param user
	 */
	public Administrator(TCSUser user) {
		this.setNetId(user.getNetId());
		this.setEmail(user.getEmail());
		this.setPassword(user.getPassword());
		this.setFirstName(user.getFirstName());
		this.setLastName(user.getLastName());
		this.setUserType(Constants.UserType.ADMINISTRATOR);
	}

	public boolean makeAppointment(String netId, String examRefinedId, String apptDatetime, String typeOfSeat) {
		Retriever retriever = Retriever.getInstance();
		Exam exam = retriever.getExam(examRefinedId);
		// Requested exam not found
		if (exam == null) return false;

		EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
		EntityManager em = emf.createEntityManager();
		Query query;
		long count;
		int seatNumber = 1;

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
				if (count == 0) return false;
			}

			query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.examRefinedId = ?1");
			query.setParameter(1, examRefinedId);
			count = (long) query.getSingleResult();
			// Student already has an appointment for the exam
			if (count > 0) return false;

			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date apptStartDate = dateFormatter.parse(apptDatetime);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(apptStartDate);
			TestingCenter testingCenter = Retriever.getTestingCenter();
			calendar.add(Calendar.MINUTE, exam.getDuration() + testingCenter.getGapTime());
			Date apptEndDate = calendar.getTime();

			query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.studentNetId = ?1 AND ?2 BETWEEN a.startDate AND a.endDate");
			query.setParameter(1, netId);
			query.setParameter(2, apptStartDate, TemporalType.TIMESTAMP);
			count = (long) query.getSingleResult();
			// user has an overlapping appointment for another exam
			if (count > 0) return false;

			// appointment timeslot is out of bounds of exam date range
			if (apptStartDate.before(exam.getStartDate()) || apptEndDate.after(exam.getEndDate())) return false;

			query = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE ?1 BETWEEN a.startDate AND a.endDate");
			query.setParameter(1, apptStartDate, TemporalType.TIMESTAMP);
			count = (long) query.getSingleResult();

			if (typeOfSeat.equals("Regular")) {
				// There are no available regular seats to satisfy the appointment
				if (count >= testingCenter.getNumberOfSeats() - testingCenter.getNumberOfSetAsideSeats()) return false;

				// create seat number that is available and is not next to a seat of the same exam
				if (count > 0) {
					List<Appointment> appointments = retriever.getAppointmentsBetweenDates(apptStartDate, apptEndDate);
					for (Appointment appointment : appointments) {
						if (appointment.getSeatNumber() != seatNumber) {
							if (appointment.getExamRefinedId().equals(examRefinedId) && (appointment.getSeatNumber() != seatNumber + 1 || appointment.getSeatNumber() != seatNumber - 1))
								break;
						}
						seatNumber++;
					}
				}
			}
			else {
				// There are no available set-aside seats to satisfy the appointment
				if (count >= testingCenter.getNumberOfSetAsideSeats()) return false;

				// create seat number that is available and is not next to a seat of the same exam
				if (count > 0) {
					List<Appointment> appointments = retriever.getAppointmentsBetweenDates(apptStartDate, apptEndDate);
					for (Appointment appointment : appointments) {
						if (appointment.getSeatNumber() != seatNumber) {
							if (appointment.getExamRefinedId().equals(examRefinedId) && (appointment.getSeatNumber() != seatNumber + 1 || appointment.getSeatNumber() != seatNumber - 1))
								break;
						}
						seatNumber++;
					}
				}
			}

			// create appointment in database since it has passed all checks
			Appointment appointment =
					new Appointment("PENDING", apptEndDate, examRefinedId, seatNumber, apptStartDate, netId, testingCenter.getCurrentTerm(), testingCenter.getId());
			em.getTransaction().begin();
			em.persist(appointment);
			em.getTransaction().commit();

			return true;
		} catch (Exception e) {
			return false;
		}
	}
	public void checkInStudent(int appointmentId){
		Retriever retriever = Retriever.getInstance();
		Appointment appointment = retriever.getAppointmentByID(appointmentId);
		System.out.println("Before: " + appointment);
		appointment.checkInStudent();
		System.out.println("After: " + appointment);

		retriever.persist(appointment);
	}
}
