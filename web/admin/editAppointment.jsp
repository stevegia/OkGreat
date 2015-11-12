<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.persistence.TemporalType" %>
<% String title = "Edit Appointment";%>
<%@include file="adminHeader.jsp"%>
<%
  // use this apptId to link back to the appointment in the database
  int apptId = Integer.parseInt(request.getParameter("AppointmentId"));
  SimpleDateFormat datetimeFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  Appointment appointment=null;
  String message;
  String url;
  System.out.println("Appointment ID is " + apptId);
  System.out.println("edit button clicked");
  try {
    appointment = retriever.getAppointment(apptId);
  }catch(Exception e) {
    logger.info("unable to get appointment");
    session.setAttribute("message", "unable to get appointment");
    session.setAttribute("url", "admin/appointments.jsp");
    url = "../error.jsp";
    response.sendRedirect(url);
  }
  %>
  <form name="frm" action="editAppointmentProcess.jsp" method="post">
    <input name="AppointmentId" type="text" class="form-control" placeholder="<%=apptId%>" value="<%=apptId%>" required readonly>
    <input name="StudentNetId" type="text" class="form-control" placeholder="<%=appointment.getStudentNetId()%> "
             value="<%=appointment.getStudentNetId()%> " required>
    <input name="StartDate" type="text" class="form-control" placeholder="<%=datetimeFormatter.format(appointment.getStartDate())%>"
             value="<%=datetimeFormatter.format(appointment.getStartDate())%>" required>
    <input name="EndDate" type="text" class="form-control" placeholder="<%=datetimeFormatter.format(appointment.getEndDate())%>"
           value="<%=datetimeFormatter.format(appointment.getEndDate())%>" required>
    <input name="ExamRefinedId" type="text" class="form-control" placeholder="<%=appointment.getExamRefinedId()%>"
           value="<%=appointment.getExamRefinedId()%>" required>
    <input name="TestingCenterId" type="text" class="form-control" placeholder="<%=appointment.getTestingCenterId()%>"
           value="<%=appointment.getTestingCenterId()%>" required>
    <input name="AppointmentStatus" type="text" class="form-control" placeholder="<%=appointment.getAppointmentStatus()%>"
           value="<%=appointment.getAppointmentStatus()%>" required>
    <input name="TermId" type="text" class="form-control" placeholder="<%=appointment.getTermId()%>"
           value="<%=appointment.getTermId()%>" required>
    <input name="SeatNumber" type="text" class="form-control" placeholder="<%=appointment.getSeatNumber()%>"
           value="<%=appointment.getSeatNumber()%>" required>
    <input type="submit" value="Submit"/>
  </form>

