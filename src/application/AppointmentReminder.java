package application;

import jpaentities.Appointment;
import jpaentities.Message;

import java.util.Date;
import java.util.List;

/**
 * Created by Haseeb on 11/30/2015.
 */
public class AppointmentReminder implements Runnable {

    private List<Appointment> pendingAppointments;
    private Retriever retriever;

    public AppointmentReminder() {
        retriever = Retriever.getInstance();
    }

    public void run() {
        while (true) {
            pendingAppointments = retriever.getPendingAppointmentsInTerm();
            if (pendingAppointments != null) {
                for (Appointment appointment : pendingAppointments) {
                    if (appointment.getStartDate().getTime() - (new Date()).getTime() <= 30 * 60 * 1000) {
                        Message reminder = new Message("You have an appointment for Exam " + appointment.getExamRefinedId() +
                                " in 30 minutes", new Date(), "Appointment Reminder", appointment.getStudentNetId());
                        retriever.persist(reminder);
                    }
                }
            }
            try {
                Thread.sleep(60 * 1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public void start() {
        Thread thread = new Thread(this);
        thread.start();
    }
}
