<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width" charset="UTF-8">

  <title>Reports</title>

  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="../css/admin/admin.css">




</head>

<div class="reportsHeader">Reports</div>

<%@include file="adminHeader.html"%>
<body>
	<div class="container">
      <div class="row">
          Term:
        <ul class="nav nav-pills left">
          <li class="dropdown active span8">
              <a class="dropdown-toggle" id="inp_impact" data-toggle="dropdown">
                  <i class="icon icon-envelope icon-white"></i>&nbsp;<span id="dropdown_title">Fall 2015</span><span class="caret"></span></a>
              <ul ID="divNewNotifications" class="dropdown-menu">
                <li><a>Fall 2014</a></li> 
                <li><a>Spring 2014</a></li>       
              </ul>
          </li>
        </ul>
      </div>
      <img src="http://farm4.static.flickr.com/3554/3480778622_13391fdfc0.jpg">
              Start Date and Time
        <input name="startdatetime" type="password" class="form-control" placeholder="" required>
        <br>
                End Date and Time
        <input name="enddatetime" type="password" class="form-control" placeholder="" required>
        <br>
        <a href="reports.jsp">
        <button>Generate Report</button>
        </a>
        <a href="importData.jsp">
        <button>Import Data</button>
        </a>
        <img src="http://i.stack.imgur.com/TBxuO.jpg">
        Utilization
    </div>  

</body>

</html>
