<%@ page import="java.util.List" %>
<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Exam" %>
<%@ page import="jpaentities.TCSUser" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">

    <title>Exams</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="../css/instructor/instructor.css">


</head>


<div class="pendingRequestsHeader">Exams</div>
<%@include file="instructorHeader.html" %>
<body>


<%

    TCSUser user = (TCSUser) session.getAttribute("user");
    Retriever ListGetter = Retriever.getInstance();
    List<Exam> eList = ListGetter.getExamsInTerm(user.getNetId(), 1158);
    request.setAttribute("eList", eList);
    request.setAttribute("termId", 1158);
    request.setAttribute("termName", "Fall 2015");
%>


<%

%>
<div class="pendingRequestsContent">


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
            eList = ListGetter.getExamsInTerm(user.getNetId(), term);
            request.setAttribute("eList", eList);

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
                        int index = 0;
                        for (Exam element : eList) {
                    %>

                    <a href="#" onclick="
                            javascript:
                            $(this).addClass('active').siblings().removeClass('active');


                            switchView(
                            {
                            'examName' : '<%= element.getExamName() %>',
                            'dateLabel': '<%= element.getStartDate() %>',
                            'startDate': '<%= element.getStartDate() %>',
                            'endDate': '<%= element.getEndDate() %>',
                            'duration': '<%= element.getDuration() %>'


                            })" class="list-group-item"><%= element.getExamName() %>
                    </a>


                    <% } %>


                </div>
            </div>


            <div class="col-md-8 examInfo">
                <div id="TestTitle">Default</div>


                <div class="">
                    <div class="col-md-5">

                        <div class="row ">

                            <div class="col-md-3" id="classLabel">Class:</div>
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


            <div class="row makeAppointmentButton">
                <button type="button" class="btn-block ">Make Request</button>
            </div>

        </div>


    </div>

    <SCRIPT LANGUAGE="JavaScript">
        <!--
        function switchView(x) {
            console.log(x);
            $("#TestTitle").html(x.examName);


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
