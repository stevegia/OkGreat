<%@ page import="java.text.SimpleDateFormat" %>
<% String title = "Testing Center Information";%>
<%@include file="adminHeader.jsp"%>
<%
    logger.info("at admin's testingCenterInformation.jsp");
    TestingCenter testingCenter = retriever.getTestingCenter();
    TestingCenterHour testingCenterHour;
    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    String calendarEvents = retriever.getTestingCenterHourForCalender();
    System.out.println(calendarEvents);

%>

<script type="text/javascript" src="../js/underscore.js"></script>
<script type="text/javascript" src="../js/calendar.min.js"></script>
<script type="text/javascript" src="../js/admin/calendarControl.js"></script>

<body onload='initiate(<%=calendarEvents%>)'>
<div class="generalContent container">


    <div class="pull-right form-inline">
        <div class="btn-group">
            <button class="btn btn-primary" data-calendar-nav="prev"><< Prev</button>
            <button class="btn btn-default" data-calendar-nav="today">Today</button>
            <button class="btn btn-primary" data-calendar-nav="next">Next >></button>
        </div>
        <div class="btn-group">
            <button class="btn btn-warning" data-calendar-view="year">Year</button>
            <button class="btn btn-warning active" data-calendar-view="month">Month</button>
            <button class="btn btn-warning" data-calendar-view="week">Week</button>
            <button class="btn btn-warning" data-calendar-view="day">Day</button>
        </div>
    </div>

    <div style="margin-top: 20px"></div>
    <div style="padding-top: 20px"></div>

    <div id="calendarChart"></div>


    <div class="modal fade" id="events-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3>Appointment</h3>
                </div>
                <div class="modal-body" style="height: 400px">
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                </div>
            </div>
        </div>
    </div>
</div>


        <%--<%  List<TestingCenterHour> hours = retriever.getTestingCenterHour();--%>
            <%--int ty =0;--%>
            <%--if (hours != null) {--%>
        <%--%>--%>
        <%--<div class="table-responsive">--%>
            <%--<table class="table table-bordered table-hover">--%>
                <%--<thead>--%>
                <%--<tr>--%>
                    <%--<th> Date</th>--%>
                    <%--<th> StartTime</th>--%>
                    <%--<th> EndTime</th>--%>
                    <%--<th></th>--%>
                <%--</tr>--%>
                <%--</thead>--%>
                <%--<tbody>--%>
                <%--<% for (TestingCenterHour hour : hours) {--%>
                    <%--String date = dateFormatter.format(hour.getId().getOpenDate());--%>
                <%--%>--%>
                    <%--<tr>--%>
                        <%--<form name="frm" action="editTestingCenterHour.jsp" method="post">--%>
                            <%--<td>--%>
                                <%--<input name="date" type="text" class="form-control" placeholder="<%=date%>"--%>
                                       <%--value="<%=date%>" required readonly>--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<input name="starttime" type="text" class="form-control" placeholder="<%=hour.getStartTime()%> "--%>
                                       <%--value="<%=hour.getStartTime()%>" required>--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<input name="endtime" type="text" class="form-control" placeholder="<%=hour.getEndTime()%>"--%>
                                       <%--value="<%=hour.getEndTime()%>" required>--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<input type="submit" value="Submit"/>--%>
                            <%--</td>--%>
                        <%--</form>--%>
                    <%--</tr>--%>
                <%--<%--%>
                    <%--}--%>
                <%--%>--%>
                <%--</tbody>--%>
            <%--</table>--%>
        <%--</div>--%>

        <%--<%--%>
            <%--}--%>
        <%--%>--%>

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

</script>

</html>
