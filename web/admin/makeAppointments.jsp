<% String title = "Make Appointment";%>
<%@include file="adminHeader.jsp" %>
<%
    logger.info("Now at the makeAppointments.jsp file");
%>
<div class="makeAppointmentContent">
    <form action="selectTimeslot.jsp">
        <div class="col-md-5">
            <div class="row">Student NetId</div>
            <div class="row">
                <div class="input-group">
                    <input type="text" class="form-control"
                           placeholder="Enter NetId" name="studentNetId"
                           aria-describedby="basic-addon2">
                </div>
            </div>
            <div class="row">Exam Identifier</div>
            <div class="row">
                <div class="input-group">
                    <input type="text" class="form-control"
                           placeholder="Enter Identifier" name="examRefinedId"
                           aria-describedby="basic-addon2">
                </div>
            </div>
            Seat Type:
            <div class="radio">
                <label><input type="radio" name="seatRadio" value="Regular">Regular</label>
            </div>
            <div class="radio">
                <label><input type="radio" name="seatRadio" value="SetAside">Set-Aside</label>
            </div>
            <div class="row">
                <input type="submit" value="Submit Request">
            </div>
        </div>
    </form>
</div>
</body>
</html>
