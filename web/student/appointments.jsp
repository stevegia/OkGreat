<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">

    <title>Appointments</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="../css/student/student.css">


</head>

<div class="appointmentsHeader">Appointments</div>
<%@include file="studentHeader.html" %>
<%@ page import="application.*" %>
<%@ page import="java.util.List" %>
<%@ page import="jpaentities.Appointment" %>
<%
    Student student = (Student) session.getAttribute("user");
    Retriever retriever = Retriever.getInstance();
    List<Appointment> appointments = retriever.getAppointmentsForStudent(student.getNetId(), 1158);
    request.setAttribute("appointments", appointments);
    request.setAttribute("termId", 1158);
    request.setAttribute("termName", "Fall 2015");
%>
<body>


<div class="appointmentContent">


    <div class="dropdown">
        Term:
        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="true">

            <% if (request.getParameter("termName") != null) {
                out.print(request.getParameter("termName"));

            } else {
                out.print("Fall 2015");
            } %>

        </button>
        <ul class="dropdown-menu" id="termDropdown" aria-labelledby="dropdownMenu1">


            <li onclick="submitTerm(1158,'Fall 2015')">Fall 2015</li>
            <li onclick="submitTerm(1161,'Winter 2016')">Winter 2015</li>
            <li onclick="submitTerm(1164,'Spring 2016')">Spring 2016</li>
            <li onclick="submitTerm(1166,'Summer 2016')">Summer 2016</li>
            <li onclick="submitTerm(1168,'Fall 2016')">Fall 2016></li>


        </ul>
    </div>

    <%
        if (request.getParameterNames() != null && request.getParameter("termId") != null) {
            int term = Integer.parseInt(request.getParameter("termId"));
            appointments = retriever.getAppointmentsForStudent(student.getNetId(), term);
            request.setAttribute("appointments", appointments);

        }
    %>

    <form NAME="form1">
        <INPUT TYPE="HIDDEN" NAME="termId">
        <INPUT TYPE="HIDDEN" NAME="termName">
    </form>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
                <div class="list-group">

                    <%
                        for (Appointment appointment : appointments) {
                    %>

                    <a href="#" onclick="
                            javascript:
                            $(this).addClass('active').siblings().removeClass('active');


                            switchView(
                            {
                            'dateLabel': '<%= appointment.getAppointmentDate() %>',
                            'examId': '<%= appointment.getExamRefinedId() %>',
                            'duration': '<%= appointment.getDuration() %>',
                            'status': '<%= appointment.getAppointmentStatus() %>',
                            'termId': '<%= appointment.getTermId() %>',
                            'seatNumber': '<%= appointment.getSeatNumber() %>'


                            })" class="list-group-item"><%= appointment.getExamRefinedId() %>
                    </a>

                    <input type="button" onclick="javascript:
                            window.open('cancelAppointment.jsp?AppointmentId=<%=appointment.getId()%>', '_self');
                            ;
                            return;" value="Cancel">


                    <% } %>


                </div>
            </div>


            <div class="col-md-8">
                <div id="TestTitle">Default</div>


                <div class="">
                    <div class="col-md-5">

                        <div class="row ">

                            <div class="col-md-3" id="studentNetId">Student:</div>
                            <div class="col-md-4" id="class"></div>

                        </div>

                        <div class="row">
                            <div class="col-md-3" id="dateLabel">Date:</div>
                            <div class="col-md-4" id="date"></div>
                        </div>


                        <div class="row">
                            <div class="col-md-3" id="sectionLabel">Section:</div>
                            <div class="col-md-4" id="section"></div>
                        </div>

                        <div class="row">
                            <div class="col-md-3" id="studentsSignedUpLabel">Students Signed Up:</div>
                            <div class="row">
                                <div class="col-md-4" id="studentsSignedUp"></div>
                            </div>

                        </div>


                        <div class="row">
                            <div class="" id=""></div>

                        </div>


                    </div>

                    <div class="col-md-5">

                        <div class="row">

                            <div class="col-md-3" id="statusLavel">Status</div>
                            <div class="col-md-4" id="status"></div>

                        </div>

                        <div class="row">

                            <div class="col-md-3" id="startLabel">Start:</div>
                            <div class="col-md-4" id="start"></div>

                        </div>

                        <div class="row">
                            <div class="col-md-3" id="endTimeLabel">End Time:</div>
                            <div class="col-md-4" id="endTime"></div>
                        </div>


                        <div class="row ">
                            <div class="col-md-3" id="examTimeLabel">Exam Time:</div>
                            <div class="col-md-4" id="examTime"></div>


                        </div>

                        <div class="row paddingBox">Additional Info</div>
                        <div class="row paddingBox"></div>
                        asdasda


                    </div>
                    <div class="row paddingBox">
                        <button type="button" class="btn-block ">Cancel Request</button>
                    </div>
                </div>


            </div>


            <div>
                <button type="button" class="btn-block ">Make Request</button>
            </div>

        </div>


    </div>

    <SCRIPT LANGUAGE="JavaScript">
        <!--
        function switchView(x) {
            console.log(x);
            $("#TestTitle").html(x.examId);


        }


        function submitTerm(termId, termName) {
            document.form1.termId.value = termId;
            document.form1.termName.value = termName;
            console.log("here");
            form1.submit();
        }


        function changeTermName(termName) {
            if (termName != "" && termName != null) {
                $("#dropdownMenu1").html(termName);
            }
        }


        // -->
    </SCRIPT>


</div>


</body>

</html>