<% String title = "Make Appointment";%>
<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Appointment" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@include file="studentHeader.jsp" %>
<%
    logger.info("At the cancelAppointment.jsp page");
    // use this apptId to link back to the appointment in the database
    int apptId = Integer.parseInt(request.getParameter("AppointmentId"));
    Appointment appointment;
    String url = "appointments.jsp";
    System.out.println("Appointment ID is " + apptId);
    System.out.println("cancel button clicked");
    retriever = Retriever.getInstance();
    Date todayDate = new Date(); //todays datetime
    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date appointmentDate;
    long diffHours = 0;
    try {
        appointment = retriever.getAppointment(apptId);
        appointmentDate = appointment.getStartDate();
        diffHours = (appointmentDate.getTime() - todayDate.getTime()) / (60 * 60 * 1000);
        if (diffHours >= 24) {
            logger.info("Appointment can be successfully canceled");
            appointment.cancel();
            retriever.persist(appointment);
        } else {
            logger.info("Appointment is trying to be canceled within 24 hours");
            url = "../error.jsp";
            session.setAttribute("message", "appointments can only be cancelled prior to 24hours before the appointment ");
            session.setAttribute("url", "student/appointments.jsp");
        }
    } catch (Exception E) {
        logger.info("Error trying to cancel appointment");
        url = "../error.jsp";
        session.setAttribute("message", "error cancelling appointment");
        session.setAttribute("url", "student/appointments.jsp");
    }
    response.sendRedirect(url);
%>