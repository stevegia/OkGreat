<% String title = "Submit Appointment";%>
<%@ page import="application.Student" %>
<%@include file="studentHeader.jsp" %>
<%
	Student student = new Student(retriever.getUser(request.getRemoteUser()));
	String examRefinedId = (String) session.getAttribute("examRefinedId");
	String formattedDate = request.getParameter("apptDate");

	boolean apptSuccessful = student.makeAppointment(student.getNetId(), examRefinedId, formattedDate);

	if (apptSuccessful) {
		logger.info("Making appointment was a success, returning to appointments.jsp...");
		response.sendRedirect("appointments.jsp");
	} else {
		logger.info("There was an error making the appointment. Make sure the inputs are correct. Going to error.jsp...");
		response.sendRedirect("../error.jsp");
	}
%>