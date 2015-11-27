<% String title = "Submit Appointment";%>
<%@ page import="application.*"%>
<%@include file="adminHeader.jsp" %>
<%
    logger.info("Now at the aubmitAppointments.jsp file from the makeAppointments.jsp file");

    Administrator admin = new Administrator(retriever.getUser(request.getRemoteUser()));
    String studentNetId = request.getParameter("studentNetId");
    String examRefinedId = request.getParameter("examRefinedId");
    String typeOfSeat = request.getParameter("seatRadio");
    String apptDatetime = request.getParameter("appointmentDatetime");
    boolean apptSuccessful = admin.makeAppointment(studentNetId, examRefinedId, apptDatetime, typeOfSeat);

    if (apptSuccessful) {
        logger.info("Making appointment was a success, returning to appointments.jsp...");
        response.sendRedirect("appointments.jsp");
    } else {
        logger.info("There was an error making the appointment. Make sure the inputs are correct. Going to error.jsp...");
        response.sendRedirect("../error.jsp");
    }
%>