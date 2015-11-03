<%@ page import="application.*"%>
<%
	Student student = (Student) session.getAttribute("user");
	String examRefinedId = request.getParameter("examRefinedId");
	String apptDatetime = request.getParameter("appointmentDatetime");
	boolean apptSuccessful = student.makeAppointment(student.getNetId(), examRefinedId, apptDatetime);

	if (apptSuccessful)
		response.sendRedirect("appointments.jsp");
	else {
		System.out.println("There was an error making your appointment. Make sure your inputs are correct.");
		response.sendRedirect("error.jsp");
	}
%>