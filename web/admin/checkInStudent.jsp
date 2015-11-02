<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Appointment" %>
<%@ page import="application.Administrator" %><%
  // use this apptId to link back to the appointment in the database
  int apptId = Integer.parseInt(request.getParameter("AppointmentId"));
  System.out.println("Appointment ID is " + apptId);

  Administrator user = (Administrator) session.getAttribute("user");
  user.checkInStudent(apptId);

  System.out.println("check-in button clicked");
  response.sendRedirect("appointments.jsp");
%>