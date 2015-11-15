<%@ page import="java.text.SimpleDateFormat" %>
<% String title = "Edit Appointment";%>
<%@include file="adminHeader.jsp"%>
<%
  int apptId = -1;
  Appointment appointment=null;
  String message = null;
  String url = "appointments.jsp";
  SimpleDateFormat datetimeFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  logger.info("at editAppointmentProcess");
  logger.info("Appointment ID is " + apptId);
  try {
    apptId = Integer.parseInt(request.getParameter("AppointmentId"));
    appointment = retriever.getAppointment(apptId);
  }catch(Exception e) {
    logger.info("unable to get appointment");
    session.setAttribute("message", "unable to get appointment");
    session.setAttribute("url", "admin/appointments.jsp");
    url = "../error.jsp";
    response.sendRedirect(url);
  }
  try{
    appointment.setStudentNetId(request.getParameter("StudentNetId"));
    appointment.setStartDate(datetimeFormatter.parse(request.getParameter("StartDate")));
    appointment.setEndDate(datetimeFormatter.parse(request.getParameter("EndDate")));
    appointment.setExamRefinedId(request.getParameter("ExamRefinedId"));
    appointment.setAppointmentStatus(request.getParameter("AppointmentStatus"));
    appointment.setTermId(Integer.parseInt(request.getParameter("TermId")));
    appointment.setSeatNumber(Integer.parseInt(request.getParameter("SeatNumber")));
    retriever.persist(appointment);
  }catch(Exception e){
    logger.info("error updating appointment "+apptId);
    session.setAttribute("message", "error updating appointment "+apptId);
    session.setAttribute("url", "admin/appointments.jsp");
    url = "../error.jsp";
  }
  response.sendRedirect(url);
%>
