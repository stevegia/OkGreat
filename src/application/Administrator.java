/**
 *
 */
package application;

import jpaentities.Appointment;
import jpaentities.Exam;
import jpaentities.TCSUser;
import jpaentities.TestingCenter;
import utils.Constants;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

/**
 * @author Haseeb Shahid
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
        TestingCenter testingCenter = Retriever.getTestingCenter();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime startLdt = LocalDateTime.parse(apptDatetime, formatter);
        LocalDateTime endLdt = startLdt.plusMinutes(exam.getDuration() + testingCenter.getGapTime());
        Date apptStartDate = Date.from(startLdt.atZone(ZoneId.systemDefault()).toInstant());
        Date apptEndDate = Date.from(endLdt.atZone(ZoneId.systemDefault()).toInstant());

        long seatsAvailable = retriever.seatsAvailable(apptStartDate);
        int seatNumber = 1;

        if (typeOfSeat.equals("Regular")) {
            // There are no available regular seats to satisfy the appointment
            if (seatsAvailable >= testingCenter.getNumberOfSeats() - testingCenter.getNumberOfSetAsideSeats())
                return false;

            // create seat number that is available and is not next to a seat of the same exam
            if (seatsAvailable > 0) {
                List<Appointment> appointments = retriever.getAppointmentsBetweenDates(apptStartDate, apptEndDate);
                for (Appointment appointment : appointments) {
                    if (appointment.getSeatNumber() != seatNumber) {
                        if (appointment.getExamRefinedId().equals(examRefinedId) && (appointment.getSeatNumber() != seatNumber + 1 || appointment.getSeatNumber() != seatNumber - 1))
                            break;
                    }
                    seatNumber++;
                }

                if (seatNumber > testingCenter.getNumberOfSeats()) {
                    seatNumber = 1;
                    for (Appointment appointment : appointments) {
                        if (appointment.getSeatNumber() != seatNumber)
                            break;
                        seatNumber++;
                    }
                }
            }
        } else {
            // There are no available set-aside seats to satisfy the appointment
            if (seatsAvailable >= testingCenter.getNumberOfSetAsideSeats()) return false;

            // create seat number that is available and is not next to a seat of the same exam
            if (seatsAvailable > 0) {
                List<Appointment> appointments = retriever.getAppointmentsBetweenDates(apptStartDate, apptEndDate);
                for (Appointment appointment : appointments) {
                    if (appointment.getSeatNumber() != seatNumber) {
                        if (appointment.getExamRefinedId().equals(examRefinedId) && (appointment.getSeatNumber() != seatNumber + 1 || appointment.getSeatNumber() != seatNumber - 1))
                            break;
                    }
                    seatNumber++;
                }

                if (seatNumber > testingCenter.getNumberOfSeats()) {
                    seatNumber = 1;
                    for (Appointment appointment : appointments) {
                        if (appointment.getSeatNumber() != seatNumber)
                            break;
                        seatNumber++;
                    }
                }
            }
        }

        // create appointment in database since it has passed all checks
        Appointment appointment =
                new Appointment("PENDING", apptEndDate, examRefinedId, seatNumber, apptStartDate, netId, testingCenter.getCurrentTerm(), testingCenter.getId());
        retriever.persist(appointment);
        // increment number of appointments made for exam
        exam.setNumberOfAppointments(1 + exam.getNumberOfAppointments());
        retriever.persist(exam);
        return true;

    }

    public void checkInStudent(int appointmentId) {
        Retriever retriever = Retriever.getInstance();
        Appointment appointment = retriever.getAppointmentByID(appointmentId);
        System.out.println("Before: " + appointment);
        appointment.checkInStudent();
        System.out.println("After: " + appointment);

        retriever.persist(appointment);
    }
}
