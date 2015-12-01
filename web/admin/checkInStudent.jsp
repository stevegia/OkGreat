<% String title = "Check in Student";%>
<%@include file="adminHeader.jsp"%>
<%
  // use this apptId to link back to the appointment in the database
  int apptId = Integer.parseInt(request.getParameter("AppointmentId"));
  logger.info("at admin's checkInStudent");

  Administrator admin = new Administrator(retriever.getUser(request.getRemoteUser()));

  admin.checkInStudent(apptId);

  logger.info("admin ");
  response.sendRedirect("appointments.jsp");
%>