<% String title = "Reports"; %>
<%@include file="adminHeader.html"%>
<body>
	<div class="container">
      <div class="row">
        <div class="left">
          <h4>Term:</h4>
        </div>  
        <ul class="nav nav-pills">
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
      <button>Generate Report</button>
      <div class="textbox">
      </div>
    </div>  

</body>

</html>
