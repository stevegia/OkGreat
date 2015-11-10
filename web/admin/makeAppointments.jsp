<% String title = "Make Appointment";%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">
</head>

<%@include file="adminHeader.jsp" %>

<body>

<%
    logger.info("Now at the makeAppointments.jsp file");
%>

<div class="makeAppointmentContent">

    <form action="submitAppointment.jsp">

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
            <div class="row">Appointment Date and Time</div>
            <div class="row">
                <div class="input-group">
                    <input type="text" class="form-control"
                           placeholder="Enter Date and Time" name="appointmentDatetime"
                           aria-describedby="basic-addon2">
                </div>
            </div>
            <div class="row">
                <input type="submit" value="Submit Request">
            </div>
        </div>

        <div class="container">
            <h2>Available Tests</h2>

            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Date</th>
                    <th>Start</th>
                    <th>Regular Seats</th>
                    <th>Select</th>

                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>11/15/12</td>
                    <td>11:00pm</td>
                    <td>3</td>

                </tr>

                </tbody>
            </table>
        </div>


    </form>


</div>


</body>

</html>
