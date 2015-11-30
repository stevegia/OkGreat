/**
 *
 */
package application;

import jpaentities.Appointment;
import jpaentities.Exam;
import jpaentities.TCSUser;
import jpaentities.TestingCenter;
import utils.Constants;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

    /**
     * Imports data from csv files into the database
     * @param termId
     * @return true if data was successfully imported, false otherwise
     */
    public boolean importData(int termId) {
        String url = "jdbc:mysql://127.0.0.1:3306/testing_center_scheduler";
        String username = "root";
        String password = "admin";
        Connection connection;
        Statement statement;

        // import user.csv
        try {
            connection = DriverManager.getConnection(url, username, password);
            String userImportQuery = "LOAD DATA INFILE 'C:/xampp/tomcat/webapps/okgreat/CSV/user.csv' " +
                    "INTO TABLE TCSUser " +
                    "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' " +
                    "LINES TERMINATED BY '\\n' " +
                    "IGNORE 1 LINES " +
                    "(FirstName, LastName, NetID, Email) " +
                    "SET Password = 's123', UserType = 'STUDENT';";
            statement = connection.createStatement();
            statement.execute(userImportQuery);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        // import class.csv
        try {
            String foreignKeyOff = "SET FOREIGN_KEY_CHECKS= 0 ;";
            statement.execute(foreignKeyOff);
            String classImportQuery = "LOAD DATA INFILE 'C:/xampp/tomcat/webapps/okgreat/CSV/class.csv' " +
                    "INTO TABLE TCSClass " +
                    "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' " +
                    "LINES TERMINATED BY '\\n' " +
                    "IGNORE 1 LINES " +
                    "(UnrefinedId, Subject, CatalogNumber, Section, InstructorNetId) " +
                    "SET RefinedId = CONCAT(Subject, CatalogNumber, '-', Section, '_'," + termId + ");";
            statement.execute(classImportQuery);
            String foreignKeyOn = "SET FOREIGN_KEY_CHECKS= 1 ;";
            statement.execute(foreignKeyOn);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        // import roster.csv
        try {
            String deleteRostersInTermQuery = "DELETE FROM Roster WHERE TermId = " + termId + ";";
            statement.execute(deleteRostersInTermQuery);
            String rosterImportQuery = "LOAD DATA INFILE 'C:/xampp/tomcat/webapps/okgreat/CSV/roster.csv' " +
                    "INTO TABLE Roster " +
                    "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' " +
                    "LINES TERMINATED BY '\\n' " +
                    "IGNORE 1 LINES " +
                    "(NetID, TCSClassUnrefinedId) " +
                    "SET TermId = " + termId + ";";
            statement.execute(rosterImportQuery);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        Retriever retriever = Retriever.getInstance();
        ArrayList<Appointment> superfluousAppointments = retriever.getSuperfluousAppointments(termId);
        // TODO: message student, instructor, and admin of superfluous appointment

        return true;
    }
}
