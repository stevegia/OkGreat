<% String title = "Import Data"; %>
<%@include file="adminHeader.html"%>
<body>
	<div class="container"> 
    <div class="col-5">
      <div class="left">
      <h4>Select Term:</h4>
      </div>
      <ul class="nav nav-pills">
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
      <br>
      <button>Browse</button>
      <p>Browse for folder containing data files</p>
      <p>user.csv, class.csv, and roster.csv</p>
      Number of superfluous appointments detected: 
  </div>  

</body>

</html>
