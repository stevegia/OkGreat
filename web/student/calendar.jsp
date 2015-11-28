<%@ page import="application.Student" %>
<% String title = "Calendar";%>
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>calendar</title>

</head>
<%@include file="studentHeader.jsp"%>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script type="text/javascript" src="../js/underscore.js"></script>
<script type="text/javascript" src="../js/calendar.min.js"></script>
<script type="text/javascript" src="../js/student/calendarControl.js"></script>
<link rel="stylesheet" href="../css/calendar.min.css">
<link rel="stylesheet" href="../css/student/student.css">

<%
  String calenderEvents = retriever.getExamsForCalender(request.getRemoteUser(), 1158);
  if (request.getParameter("termId") == null) {
    request.setAttribute("termId", 1158);
    request.setAttribute("termName", "Fall 2015");
  }
    logger.info("On the calendar.jsp page");
%>
<body onload='initiate(<%=calenderEvents%>)'>
<div class="generalContent" >
  <!--This is a hidden form that enables term changing -->
  <form NAME="form1">
    <INPUT TYPE="HIDDEN" NAME="termId">
    <INPUT TYPE="HIDDEN" NAME="termName">
  </form>
<div style="margin-top: 20px"></div>
  <div class="pull-right form-inline">
    <div class="btn-group">
      <button class="btn btn-primary" data-calendar-nav="prev"><< Prev</button>
      <button class="btn btn-default" data-calendar-nav="today">Today</button>
      <button class="btn btn-primary" data-calendar-nav="next">Next >></button>
    </div>
    <div class="btn-group">
      <button class="btn btn-warning" data-calendar-view="year">Year</button>
      <button class="btn btn-warning active" data-calendar-view="month">Month</button>
      <button class="btn btn-warning" data-calendar-view="week">Week</button>
      <button class="btn btn-warning" data-calendar-view="day">Day</button>
    </div>
  </div>
  <div style="padding-top: 20px"></div>
  <div id="calendarChart"></div>
  <div class="modal fade" id="events-modal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3>Appointment</h3>
        </div>
        <div class="modal-body" style="height: 400px">
        </div>
        <div class="modal-footer">
          <a href="#" data-dismiss="modal" class="btn">Close</a>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
