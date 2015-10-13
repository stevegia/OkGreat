<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>Make Appointments</title>

  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="../css/admin/admin.css">



</head>

<div class="makeAppointmentsHeader">Make Appointments</div>

<%@include file="adminHeader.html"%>
<body>
    <div class="container">
      <div class="row">
          Type:
        <ul class="nav nav-pills left">
          <li class="dropdown active span8">
              <a class="dropdown-toggle" id="inp_impact" data-toggle="dropdown">
                  <i class="icon icon-envelope icon-white"></i>&nbsp;<span id="dropdown_title">Select</span><span class="caret"></span></a>
              <ul ID="divNewNotifications" class="dropdown-menu">
                <li><a>Course</a></li> 
                <li><a>Ad Hoc</a></li>       
              </ul>
          </li>
        </ul>
      </div>
      Seat Type:
      <div class="radio">
        <label><input type="radio" name="optradio">Regular</label>
      </div>
      <div class="radio">
        <label><input type="radio" name="optradio">Set-Aside</label>
      </div>
      <form name="frm" method="post" action="makeAppointments.jsp" onclick="log.trace('I was traced!');return false;">
        Student NetId:
        <input name="studentnetid" type="password" class="form-control" placeholder="" required>
        <br>
        Exam Id
        <input name="examid" type="password" class="form-control" placeholder="" required>
        <br>
        Start Date and Time
        <input name="startdatetime" type="password" class="form-control" placeholder="" required>
        <br>
        Duration
        <input name="duration" type="password" class="form-control" placeholder="" required>
        <br>
        <center>
          <input type="submit" value="Make Appointment"/>
        </center>    
      </form>
          <div class="container">
      <h2>Available Tests</h2>

      <table class="table table-bordered">
        <thead>
        <tr>
          <th>Date</th>
          <th>Start</th>
          <th>Regular Seats</th>
          <th>Select</th>

        </tr>
        </thead>
        <tbody>
        <tr>
          <td>11/15/12</td>
          <td>11:00pm</td>
          <td>3</td>

        </tr>

        </tbody>
      </table>
    </div>
    </div>

</body>
<script>
    $(document).ready(function () {
      $('.dropdown-toggle').dropdown();
      $('#divNewNotifications li').on('click', function() {
    $('#dropdown_title').html($(this).find('a').html());
    });
});
</script>

</html>
