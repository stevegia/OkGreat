<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Appointment" %>
<%@ page import="application.Administrator" %>
<%@ page import="java.util.logging.Logger" %><%
  Logger logger= Logger.getLogger("login.jsp");
  // use this apptId to link back to the appointment in the database
  int apptId = Integer.parseInt(request.getParameter("AppointmentId"));
  logger.info("at admin's checkInStudent");
  Retriever retriever = Retriever.getInstance();

  Administrator admin = new Administrator(retriever.getUser(request.getRemoteUser()));

  admin.checkInStudent(apptId);

  logger.info("admin ");
  response.sendRedirect("appointments.jsp");
%>