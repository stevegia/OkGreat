<% String title = "Make Appointment";%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">

    <title>Make an Appointment</title>
    <link rel="stylesheet"
          href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script
            src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="../css/student/student.css">


</head>

<div class="makeHeader">Make an Appointment</div>
<%@include file="studentHeader.jsp" %>

<body>

<%
    logger.info("Now at the make.jsp file");
%>

<div class="makeAppointmentContent">

    <form action="submitAppointment.jsp">

        <div class="col-md-5">
            <div class="row">Exam Identifier</div>
            <div class="row">
                <div class="input-group">
                    <input type="text" class="form-control"
                           placeholder="Enter Identifier" name="examRefinedId"
                           aria-describedby="basic-addon2">
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <div class="row">Appointment Date and Time</div>
            <div class="row">
                <div class="input-group">
                    <input type="text" class="form-control"
                           placeholder="Enter Date and Time" name="appointmentDatetime"
                           aria-describedby="basic-addon2">
                </div>
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
        <div class="row makeAppointmentButton">
            <input type="submit" value="Submit Request">
        </div>


    </form>


</div>


</body>

</html>
