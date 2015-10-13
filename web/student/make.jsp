<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>Make an Appointment</title>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="../css/student/student.css">




</head>

<div class="makeHeader">Make an Appointment</div>
<%@include file="studentHeader.html"%>

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
    <div class="row searchButton">
        <button type="button" class="btn-block ">Search</button>
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
