<% String title = "Submit Appointment";%>
<%@ page import="application.Administrator" %>
<%@include file="adminHeader.jsp" %>
<%
    Administrator admin = new Administrator(retriever.getUser(request.getRemoteUser()));

    String studentNetId = (String) session.getAttribute("studentNetId");
    String examRefinedId = (String) session.getAttribute("examRefinedId");
    String typeOfSeat = (String) session.getAttribute("typeOfSeat");
    String formattedDate = request.getParameter("apptDate");

    boolean apptSuccessful = admin.makeAppointment(studentNetId, examRefinedId, formattedDate, typeOfSeat);

    if (apptSuccessful) {
        logger.info("Making appointment was a success, returning to appointments.jsp...");
        response.sendRedirect("appointments.jsp");
    } else {
        logger.info("There was an error making the appointment. Make sure the inputs are correct. Going to error.jsp...");
        response.sendRedirect("../error.jsp");
    }
%>