<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>Calendar</title>

  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="../js/underscore.js"></script>
  <script type="text/javascript" src="../js/calendar.min.js"></script>
  <link rel="stylesheet" href="../css/calendar.min.css">
  <link rel="stylesheet" href="../css/student/student.css">
  <link rel="stylesheet" href="../css/admin/admin.css">




</head>

<div class="calendarHeader">Calendar</div>

<%@include file="adminHeader.html"%>
<body>

<div id ="calendarChart"></div>
<script type="text/javascript">
  var calendar = $("#calenderChart").calendar(
          {
            tmpl_path: "../tmpls/",
            events_source: function () { return []; }
          });
</script>

</body>

</html>
