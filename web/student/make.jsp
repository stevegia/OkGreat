<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>Make an Appointment</title>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="../css/student/student.css">
  <link rel="stylesheet" href="../css/student/make.css">



</head>

<div class="makeHeader">Make an Appointment</div>
<nav role="navigation" class="navbar navbar-default">
  <div class="container-fluid">



    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li id ="appointments"><a href="appointments.jsp">Appointments</a></li>
        <li id="makeAppointment"><a href="make.jsp">Make an Appointment<span class="sr-only">(current)</span> </a></li>
        <li id="calendar"><a href="calendar.jsp">Calendar</a></li>


      </ul>


    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<body>

<div class="makeAppointmentContent">


  <div class="container-fluid">

    <div class="col-md-6">
      <div class="row">
        <div class="col-md-2">Test Type: </div>
        <div class="col-md-3">
          <div class="checkbox-inline">
            <label><input type="checkbox" value="">Course</label>
          </div>
          <div class="checkbox-inline">
            <label><input type="checkbox" value="">Ad Hoc</label>
          </div>
        </div>
      </div>
        <div class="row">
            <div class="col-md-2">Section:  </div>
            <div class="col-md-3"> 2 </div>
        </div>

        <div class="row">

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

    </div>
    <div class="col-md-5">
        <div class="row">
            Start Time and date
        </div>
        <div class="row">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Start Date" aria-describedby="basic-addon2">
                <input type="text" class="form-control" placeholder="Start Time" aria-describedby="basic-addon2">

            </div>



        </div>
        <div class="row">
            End Time and date
        </div>
        <div class="row">
            <input type="text" class="form-control" placeholder="End Date" aria-describedby="basic-addon2">
            <input type="text" class="form-control" placeholder="End Time" aria-describedby="basic-addon2">
        </div>
        <div class="row">Search</div>
<div class="row">
    <div class="row makeAppointmentButton">
        <button type="button" class="btn-block ">Make Appointment</button>
    </div>

</div>


    </div>

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
      <div class="row makeAppointmentButton">
          <button type="button" class="btn-block ">Make Appointment</button>
      </div>

  </div>





</div>










</body>

</html>
