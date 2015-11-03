<% String title = "Testing Center Information";%>
<%@include file="adminHeader.html"%>
<%
    logger.info("at admin's testingCenterInformation.jsp");
    TestingCenter testingCenter = retriever.getTestingCenter();
    TestingCenterHour testingCenterHour;
%>
<div class="container">
    <!--
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
    <div class="pull-right form-inline">
        <div class="btn-group">
            <button class="btn btn-primary" data-calendar-nav="prev"><< Prev</button>
            <button class="btn btn-default" data-calendar-nav="today">Today</button>
            <button class="btn btn-primary" data-calendar-nav="next">Next >></button>
        </div>
        <div class="btn-group">
            <button class="btn btn-warning" data-calendar-view="year">Term</button>
            <button class="btn btn-warning active" data-calendar-view="month">Month</button>
            <button class="btn btn-warning" data-calendar-view="week">Week</button>
            <button class="btn btn-warning" data-calendar-view="day">Day</button>
        </div>
    </div>
    <br><br><br>
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
    -->

        <%  List<TestingCenterHour> hours = retriever.getTestingCenterHour();
            int ty =0;
            if (hours != null) {
        %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th> Date</th>
                    <th> StartTime</th>
                    <th> EndTime</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <% for (TestingCenterHour hour : hours) {
                %>
                <tr>
                    <td>
                        <input name="date" type="text" class="form-control" placeholder="<%=hour.getId().getOpenDate() %>"
                               value="<%=hour.getId().getOpenDate() %>" required readonly>
                    </td>
                    <td>
                        <input name="starttime" type="text" class="form-control" placeholder="<%=hour.getStartTime()%> "
                               value="<%=hour.getStartTime()%>" required>
                    </td>
                    <td>
                        <input name="endtime" type="text" class="form-control" placeholder="<%=hour.getEndTime()%>"
                               value="<%=hour.getEndTime()%>" required>
                    </td>
                    <td>
                        <input type="submit" value="Submit"/>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <%
            }
        %>

    <form name="frm" action="editTestingCenterInformation.jsp" method="post">
        Number of Seats:
        <input name="numberofseats" type="text" class="form-control" placeholder="<%=testingCenter.getNumberOfSeats()%>"
               value="<%=testingCenter.getNumberOfSeats()%>" required>
        <br>
        Number of Set-aside Seats:
        <input name="numberofsetasideseats" type="text" class="form-control" placeholder="<%=testingCenter.getNumberOfSetAsideSeats()%>"
               value="<%=testingCenter.getNumberOfSetAsideSeats()%>" required>
        <br>
        Gap Time:
        <input name="gaptime" type="text" class="form-control" placeholder="<%=testingCenter.getGapTime()%>"
               value="<%=testingCenter.getGapTime()%>" required>
        <br>
        Reminder Interval:
        <input name="reminderinterval" type="text" class="form-control" placeholder="<%=testingCenter.getReminderInterval()%>"
               value="<%=testingCenter.getReminderInterval()%>" required>
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
    var calendar = $("#calenderChart").calendar(
            { tmpl_path: "../tmpls/",
                events_source: function () { return [
                    {
                        /*retriever.getExam(date)
                         for each
                         long timestamp = Long.parseLong(unix_timestamp) * 1000;

                         SimpleDateFormat sdf = new SimpleDateFormat("MMM d H:mm", Locale.CANADA);
                         String date = sdf.format(timestamp);

                         return date.toString();
                         */
                        "id": 0,
                        "title": "Event 1",
                        "url": "http://example.com",
                        "class": "event-important",
                        "start": 1445537644,  //date
                        "end": 1945537000     //11:59 of date
                    }
                ]; }
            });

    $('.btn-group button[data-calendar-nav]').each(function() {
        var $this = $(this);
        $this.click(function() {
            calendar.navigate($this.data('calendar-nav'));
        });
    });

    $('.btn-group button[data-calendar-view]').each(function() {
        var $this = $(this);
        $this.click(function() {
            calendar.view($this.data('calendar-view'));
        });});


</script>

</html>
