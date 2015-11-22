<%@ page import="application.Student" %>
<% String title = "Calendar";%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>calendar</title>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="../js/underscore.js"></script>
  <script type="text/javascript" src="../js/calendar.min.js"></script>
  <script type="text/javascript" src="../js/student/calendarControl.js"></script>
  <link rel="stylesheet" href="../css/calendar.min.css">
  <link rel="stylesheet" href="../css/student/student.css">




</head>
<%@include file="studentHeader.jsp"%>


<%


  Student student = (Student) session.getAttribute("user");

  String calenderEvents = retriever.getExamsForCalender(student.getNetId(), 1158);

    logger.info("On the calendar.jsp page");
%>
<body onload='initiate(<%=calenderEvents%>)'>

<div class="generalContent" >


  <div class="dropdown">
    Term:
    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
      Fall 2015
      <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
      <li><a href="#">Spring 2016</a></li>
      <li><a href="#">Spring 2015</a></li>
      <li><a href="#">Fall 2014</a></li>

    </ul>
  </div>


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
          <h3>Event</h3>
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


<script>
  function test(){
    var calendar = $('#calendarChart').calendar({
      tmpl_path: "../tmpls/",
      events_source: [
        {
          "id": 293,
          "title": "Event 1",
          "url": "http://example.com",
          "class": "event-important",
          "start": 1447113600000, // Milliseconds
          "end": 1447113600000 // Milliseconds
        }

      ]});

    $("#cal-slide-content").append("<button type='button' class='btn-block'>Submit New Request</button>");
    $("#cal-slide-content").append("DERKS");
    $("#cal-slide-content").remove();
  }
</script>


</body>

</html>
