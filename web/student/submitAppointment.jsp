<% String title = "Submit Appointment";%>
<%@ page import="application.*"%>
<%@include file="studentHeader.jsp" %>
<%
	logger.info("Now at the aubmitAppointments.jsp file from the make.jsp file");

	Student student = (Student) session.getAttribute("user");
	String examRefinedId = request.getParameter("examRefinedId");
	String apptDatetime = request.getParameter("appointmentDatetime");
	boolean apptSuccessful = student.makeAppointment(student.getNetId(), examRefinedId, apptDatetime);

	if (apptSuccessful) {
        logger.info("Making appointment was a success, returning to appointments.jsp...");
        response.sendRedirect("appointments.jsp");
    }
	else {
        logger.info("There was an error making the appointment. Make sure the inputs are correct. Going to error.jsp...");
		response.sendRedirect("../error.jsp");
	}
%>