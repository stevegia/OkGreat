<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">

    <title>Pending Requests</title>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="../css/instructor/instructor.css">
  <link rel="stylesheet" href="../css/instructor/pendingRequests.css">



</head>

<div class="pendingRequestsHeader"> Requests</div>
<%@include file="instructorHeader.html"%>
<body>


<div class="pendingRequestsContent">


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

  <div class="container-fluid">
    <div class="row">
      <div class="col-md-2">
        <div class="list-group">
          <a href="#" class="list-group-item active">Biology Final Makeup  </a>
          <a href="#" class="list-group-item">Dapibus ac faciasis in</a>
          <a href="#" class="list-group-item">Morbi leo risus</a>
          <a href="#" class="list-group-item">Porta ac consectetur ac</a>
          <a href="#" class="list-group-item" onclick="">Vestibulum at eros</a>
        </div>
      </div>

      <div class="col-md-8 examInfo">
        <div id="TestTitle">Biology Final Makeups</div>


        <div class="">
          <div class="col-md-5">

            <div class="row ">

              <div class="col-md-3" id ="classLabel">Class:</div>
              <div class="col-md-4" id ="class">CHE-131</div>

            </div>

            <div class="row">
              <div class="col-md-3" id ="dateLabel">Date:</div>
              <div class="col-md-4" id ="date">December 1st</div>
            </div>




            <div class="row">
              <div class="col-md-3" id ="sectionLabel">Section:</div>
              <div class="col-md-4" id ="section">2</div>
            </div>

            <div class="row">
              <div class="col-md-3" id ="studentsSignedUpLabel">Students Signed Up:</div>
            <div class="row">
              <div class="col-md-4" id ="studentsSignedUp">300</div>
            </div>

            </div>



            <div class="row">
              <div class="" id=""></div>

            </div>


          </div>

          <div class="col-md-5">

            <div class="row">

              <div class="col-md-3" id ="statusLavel">Status</div>
              <div class="col-md-4" id ="status">pending</div>

            </div>

            <div class="row">

              <div class="col-md-3" id ="startLabel">Start:</div>
              <div class="col-md-4" id ="start">now</div>

            </div>

            <div class="row">
              <div class="col-md-3" id ="endTimeLabel">End Time:</div>
              <div class="col-md-4" id ="endTime">December 2st</div>
            </div>




            <div class="row ">
              <div class="col-md-3" id ="examTimeLabel">Exam Time: </div>
              <div class="col-md-4" id ="examTime">alot</div>


            </div>

            <div class="row paddingBox">Additional Info</div>
            <div class="row paddingBox"></div>
            asdasda


          </div>
          <div class="row paddingBox">
            <button type="button" class="btn-block ">Cancel Request</button>
          </div>
        </div>


      </div>


      <div class="row makeAppointmentButton">
        <button type="button" class="btn-block ">Make Request</button>
      </div>

    </div>


  </div>







</div>







</body>

</html>
