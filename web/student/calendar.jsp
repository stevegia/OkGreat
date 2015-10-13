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
  <link rel="stylesheet" href="../css/calendar.min.css">
  <link rel="stylesheet" href="../css/student/student.css">




</head>

<div class="calendarHeader">Calendar</div>
<%@include file="studentHeader.html"%>
<body>


<div class="appointmnetContent">


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
</div>

<div id="calenderChart">



<script type="text/javascript">
  var calendar = $("#calenderChart").calendar(
          {
            tmpl_path: "../tmpls/",
            events_source: function () { return []; }
          });
</script>


</div>s


</body>

</html>
