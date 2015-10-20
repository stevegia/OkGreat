<% String title = "Exams And Appointments"; %>
<%@include file="adminHeader.html"%>
    <div class="container">
      <div class="row">
        <div class="col-md-1">
          Pending:
        </div>
        <div class="col-md-11">      
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th> ExamId </th>
                  <th>Student NetId </th>
                  <th> Date </th>   
                  <th> Exam Id </th>
                  <th> Duration </th>                           
                  <th> Gap Time </th>
                  <th> Status </th>
                </tr>
              </thead>
              <tbody>
          <%   /*   while(rs.next())
                  {
                     %>
                    <tr>
                       <td > <% out.print(rs.getString(1)); %> </td>                              
                    </tr>
                     <%         
                  }  */                                          
            %> 
              </tbody>
            </table>
          </div> 
        </div>  
      </div>  
      <div class="row">
        <div class="left">      
          <h4>Term:</h4>
        </div>
        <ul class="nav nav-pills left">
          <li class="dropdown active span8">
              <a class="dropdown-toggle" id="inp_impact" data-toggle="dropdown">
                  <i class="icon icon-envelope icon-white"></i>&nbsp;<span id="dropdown_title">Select</span><span class="caret"></span></a>
              <ul ID="divNewNotifications" class="dropdown-menu">
                <li><a>Current</a></li> 
                <li><a>Next</a></li>       
              </ul>
          </li>
        </ul>
        <div class="left">
          <h4>Month:</h4>
        </div>
        <ul class="nav nav-pills left">
          <li class="dropdown active span8">
              <a class="dropdown-toggle" id="inp_impact" data-toggle="dropdown">
                  <i class="icon icon-envelope icon-white"></i>&nbsp;<span id="dropdown_title">Select</span><span class="caret"></span></a>
              <ul ID="divNewNotifications" class="dropdown-menu">
                <li><a>January</a></li> 
                <li><a>February</a></li>       
              </ul>
          </li>
        </ul>        
      </div>
      <div class="row">
        <div id="calenderChart">
        </div>  
      </div>
      <div class="row">
        <div class="textbox">
          <div class="row">
            <div class="col-md-1">
              Exams:
            </div>
            <div class="col-md-11">
                            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th> Id </th>
                      <th>Student NetId </th>
                      <th> Student Name </th>   
                      <th> Exam Id </th>
                      <th> Status </th>
                      <th> Check In </th>
                      <th> Edit </th>
                    </tr>
                  </thead>
                  <tbody>
              <%   /*   while(rs.next())
                      {
                         %>
                        <tr>
                           <td > <% out.print(rs.getString(1)); %> </td>                                   
                        </tr>
                         <%         
                      }  */                                          
                %> 
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="row">
            Utilization:
                    <img src="http://i.stack.imgur.com/TBxuO.jpg">
          </div>
          <div class="row">
            <div class="col-md-2">
              Appointments:
            </div>
            <div class="col-md-10">
              <div class="table-responsive">
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th> Id </th>
                      <th>Student NetId </th>
                      <th> Student Name </th>   
                      <th> Exam Id </th>
                      <th> Status </th>
                      <th> Check In </th>
                      <th> Edit </th>
                    </tr>
                  </thead>
                  <tbody>
              <%   /*   while(rs.next())
                      {
                         %>
                        <tr>
                           <td > <% out.print(rs.getString(1)); %> </td>                                   
                        </tr>
                         <%         
                      }  */                                          
                %> 
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <p>Number of available seats: </p>
          <a href="makeAppointment.jsp">
            <button>Make Appointment</button>
          </a>
        </div>
      </div>
      <div class="row">
        <div class="col-md-1">
          Approved:
        </div>
        <div class="col-md-11">
                        <div class="table-responsive">
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th> Id </th>
                      <th>Student NetId </th>
                      <th> Student Name </th>   
                      <th> Exam Id </th>
                      <th> Status </th>
                      <th> Check In </th>
                      <th> Edit </th>
                    </tr>
                  </thead>
                  <tbody>
              <%   /*   while(rs.next())
                      {
                         %>
                        <tr>
                           <td > <% out.print(rs.getString(1)); %> </td>                                   
                        </tr>
                         <%         
                      }  */                                          
                %> 
                  </tbody>
                </table>
              </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-1">
          Denied:
        </div>
        <div class="col-md-11">
                        <div class="table-responsive">
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th> Id </th>
                      <th>Student NetId </th>
                      <th> Student Name </th>   
                      <th> Exam Id </th>
                      <th> Status </th>
                      <th> Check In </th>
                      <th> Edit </th>
                    </tr>
                  </thead>
                  <tbody>
              <%   /*   while(rs.next())
                      {
                         %>
                        <tr>
                           <td > <% out.print(rs.getString(1)); %> </td>                                   
                        </tr>
                         <%         
                      }  */                                          
                %> 
                  </tbody>
                </table>
              </div>
        </div>
      </div>      
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
