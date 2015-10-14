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
    <a href="reports.jsp">  
      <button>Back</button>
    </a>  
    <div class="col-5">
      Select Term:
      <br>
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
      <p>Browse for folder containing data files</p>
      <p>user.csv, class.csv, and roster.csv</p>
      <button>Browse</button>
  </div>  

</body>

</html>
