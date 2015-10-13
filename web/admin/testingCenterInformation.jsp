<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>Testing Center Information</title>

  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../css/admin/admin.css">



</head>

<div class="testingCenterInformationHeader">Testing Center Information</div>

<%@include file="adminHeader.html"%>
<body>
  <div class="container">
    <div class="row">
        Term:
      <ul class="nav nav-pills left">
        <li class="dropdown active span8">
            <a class="dropdown-toggle" id="inp_impact" data-toggle="dropdown">
                <i class="icon icon-envelope icon-white"></i>&nbsp;<span id="dropdown_title">Select</span><span class="caret"></span></a>
            <ul ID="divNewNotifications" class="dropdown-menu">
              <li><a>One</a></li> 
              <li><a>Two</a></li>       
              <li><a>Three</a></li>                         
            </ul>
        </li>
      </ul>
    </div>
    <form name="frm" method="post" action="editTestingCenterInformation.jsp" onclick="log.trace('I was traced!');return false;">
      Number of Seats: 
      <input name="numberofseats" type="password" class="form-control" placeholder="" required>
      <br>
      Number of Set-aside Seats:
      <input name="numberofsetasideseats" type="password" class="form-control" placeholder="" required>
      <br>
      Gap Time:
      <input name="gaptime" type="password" class="form-control" placeholder="" required>
      <br>
      Reminder Interval: 
      <input name="reminderinterval" type="password" class="form-control" placeholder="" required>
      <br>
      <center>
        <input type="submit" value="Submit"/>
      </center>    
    </form>
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
