<%@ page import="jpaentities.TCSUser" %>
<%@ page import="application.*" %>
<%@ page import="utils.Constants" %>
<% String title = "Testing Center Information";%>
<%@include file="adminHeader.html"%>
<%TestingCenter testingCenter = Retriever.getTestingCenter(); %>

  <div class="container">
    <div class="row">
      <div class="left">
        <h4>Term:</h4>
      </div>  
      <ul class="nav nav-pills">
        <li class="dropdown active span8">
            <a class="dropdown-toggle" id="inp_impact" data-toggle="dropdown">
                <i class="icon icon-envelope icon-white"></i>&nbsp;<span id="dropdown_title">Select</span><span class="caret"></span></a>
            <ul ID="divNewNotifications" class="dropdown-menu">
              <li><a>Current</a></li> 
              <li><a>Next</a></li>       
            </ul>
        </li>
      </ul>
    </div>
    <div id="calenderChart"></div>
    <div class="textbox">
      <div>
      Hours: 
      <input type="text" editable="false" value="5">-<input type="text" editable="false" value="7">
      </div>
      <% %>
        <p>Reserved for __ during __-__</p>
       <% %> 
      <button>Submit</button>
    </div>
    <form name="frm" method="post" action="editTestingCenterInformation.jsp" onclick="log.trace('I was traced!');return false;">
      Number of Seats:
      <input name="numberofseats" type="text" class="form-control" placeholder="<%=testingCenter.getNumberOfSeats();%>" value="<%=testingCenter.getNumberOfSeats();%>" required>
      <br>
      Number of Set-aside Seats:
      <input name="numberofsetasideseats" type="text" class="form-control" placeholder="<%=testingCenter.getNumberOfSetAsideSeats();%>" value="<%=testingCenter.getNumberOfSetAsideSeats();%>" required>
      <br>
      Gap Time:
      <input name="gaptime" type="text" class="form-control" placeholder="<%=testingCenter.getGapTime();%>" value="<%=testingCenter.getGapTime();%>" required>
      <br>
      Reminder Interval:
      <input name="reminderinterval" type="text" class="form-control" placeholder="<%=testingCenter.getReminderInterval();%>" value="<%=testingCenter.getReminderInterval();%>" required>
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
      var calendar = $("#calenderChart").calendar(
        {tmpl_path: "../tmpls/",
          events_source: function () { return []; }
        });  
    });
</script>    

</html>
