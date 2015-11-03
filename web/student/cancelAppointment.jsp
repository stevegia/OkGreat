<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Appointment" %><%
    // use this apptId to link back to the appointment in the database
    int apptId = Integer.parseInt(request.getParameter("AppointmentId"));
    Appointment appointment;
    String url = "appointments.jsp";
    System.out.println("Appointment ID is " + apptId);
    System.out.println("cancel button clicked");
    Retriever retriever = Retriever.getInstance();
    try {
        appointment = retriever.getAppointment(apptId);
        appointment.delete();
    } catch(Exception E){
        url="../error.jsp";
        session.setAttribute("message", "error deleting appointment");
        session.setAttribute("url", "student/appointments.jsp");
    }
    response.sendRedirect(url);
%>