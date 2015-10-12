<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">

    <title>Appointments</title>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="../css/student/student.css">
  <link rel="stylesheet" href="../css/student/appointments.css">



</head>

<div class="appointmentsHeader">Appointments</div>
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
        <li id ="appointments"><a href="appointments.jsp">Appointments <span class="sr-only">(current)</span></a></li>
        <li id="makeAppointment"><a href="make.jsp">Make an Appointment</a></li>
        <li id="calendar"><a href="calendar.jsp">Calendar</a></li>


      </ul>


    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
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


<div class="col-md-2"><ul class="list-group">
  <li class="list-group-item">Biology Final Makeup</li>
  <li class="list-group-item">Dapibus ac facilisis in</li>
  <li class="list-group-item">Morbi leo risus</li>
  <li class="list-group-item">Porta ac consectetur ac</li>
  <li class="list-group-item">Vestibulum at eros</li>
</ul></div>
<div class="col-md-8"><ul class="list-group">
  <div id="TestTitle">Biology Final Makeups</div>
<div class="row">

  <div class="col-md-1" id ="classLabel">Class:</div>
  <div class="col-md-2" id ="class">CHE-131</div>

</div>


  <div class="row">
    <div class="col-md-1" id ="sectionLabel">Section:</div>



  </div>
  <div class="row">
    <div class="" id=""></div>


  </div>


  <div id ="section">CHE-131</div>
  <button type="button" class="btn btn-default">Cancel Appointment</button>
</ul></div>






</body>

</html>
