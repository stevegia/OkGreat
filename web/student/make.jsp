<% String title = "Make Appointment";%>
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
<%@include file="studentHeader.jsp" %>

<body>

<%
    logger.info("Now at the make.jsp file");
%>

<div class="generalContent">

    <div class="generalTitle" > <h1>Select Test Information</h1></div>


    <div class="container">


        <div class="container-fluid">
            <div class="col-md-5">
                <div class="row">
                    <div class="col-md-5">Course Identifier:</div>
                    <div class="col-md-4" id="courseIdentifier">
                        <div class="input-group">
                            <input type="text" class="form-control"
                                   placeholder="Course Identifier" name="courseIdentifer"
                                   aria-describedby="basic-addon2">
                        </div>
                </div>
                </div>

                <div class="row">
                    <div class="col-md-5">Section:</div>
                    <div class="col-md-4" id="section">
                        <div class="input-group">
                            <input type="text" class="form-control"
                                   placeholder="Section" name="section"
                                   aria-describedby="basic-addon2">
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-5">Term:</div>
                    <div class="col-md-4" id="term">
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                Dropdown
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </div>
                    </div>
                </div>



            </div>
            <div class="col-md-5">
            </div>
        </div>
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
</div>

</body>


