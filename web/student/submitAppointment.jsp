<%@ page import="application.*"%>
<%
	Student student = (Student) session.getAttribute("user");

	int termId = Integer.parseInt(request.getParameter("termId"));
	String examRefinedId = request.getParameter("examRefinedId");
	String apptDatetime = request.getParameter("appointmentDatetime");
	boolean apptSuccessful = student.makeAppointment(student.getNetId(), termId, examRefinedId, apptDatetime);

	if (apptSuccessful)
		response.sendRedirect("appointments.jsp");
	else
		System.out.println("There was an error making your appointment. Make sure your inputs are correct.");
%>