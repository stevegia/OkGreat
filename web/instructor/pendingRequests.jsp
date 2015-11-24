<%@ page import="jpaentities.TCSUser" %>
<%@ page import="jpaentities.Exam" %>
<%@ page import="java.util.List" %>
<% String title = "Exams";%>
<%@include file="instructorHeader.jsp"%>

<%
    logger.addHandler(fileHandler);
    logger.info("at instr pending requests page");
    //Get all the neccisary information to fill out page


    String examList = retriever.getExamsInTermString(request.getRemoteUser(), 1158);
    request.setAttribute("examList", examList);
    if (request.getParameter("termId") == null) {
        request.setAttribute("termId", 1158);
        request.setAttribute("termName", "Fall 2015");
    }
%>

<%
    //This code runs to switch info depeding on term
    if (request.getParameterNames() != null && request.getParameter("termId") != null) {
        int term = Integer.parseInt(request.getParameter("termId"));
        examList = retriever.getExamsInTermString(user.getNetId(), term);
        request.setAttribute("examList", examList);
    }
%>
<!-- On load make sure the list of exams is updated-->
<body onload='createList(<%=examList%>)'>


<div class="TermButton">
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
</div>


<div class="generalBorderedContent">

    <!--This is a hidden form that enables term changing -->
    <form NAME="form1">
        <INPUT TYPE="HIDDEN" NAME="termId">
        <INPUT TYPE="HIDDEN" NAME="termName">
    </form>

    <div class="container-fluid">
        <div class="row">

            <div class="col-md-2">
                <div class="list-group" id="examList">
                    <!--Exams go here and are generated by javascript function createList() -->
                </div>
            </div>

            <div class="col-lg-8 examInfo">
                <div id="row">
                <div class="toprow" id="TestTitle">No Exam Selected</div>
                <div class="container-fluid">
                    <div class="col-md-5">
                        <!--Left column -->
                        <div class="row ">
                            <div class="col-md-3" id="classLabel">Class:</div>
                            <div class="col-md-4" id="class"></div>
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
                    </div>
                    <div class="col-md-5">
                        <!--Right column -->
                        <div class="row">
                            <div class="col-md-3" id="statusLavel">Status</div>
                            <div class="col-md-4" id="status"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-3" id="startLabel">Start Date:</div>
                            <div class="col-md-7" id="start"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-3" id="endTimeLabel">End Date:</div>
                            <div class="col-md-7" id="end"></div>
                        </div>
                        <div class="row ">
                            <div class="col-md-4" id="examTimeLabel">Exam Duration:</div>
                            <div class="col-md-4" id="examTime"></div>
                        </div>
                    </div>
                </div>
                </div>
                <div class="row">
                    <div class ="studentAppointmentsTitle">Student Appointments</div>

                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Net Id</th>
                            <th>Date</th>
                            <th>Seat</th>
                            <th>Status</th>

                        </tr>
                        </thead>
                        <tbody id="studentAppointments">

                        </tbody>
                    </table>
                </div>

                <div id="cancel" class="row bottomrow">

                </div>
            </div>
        </div>
    </div>

    <SCRIPT LANGUAGE="JavaScript">
        <!--
        function switchView(obj, x) {

            $(obj).addClass('active').siblings().removeClass('active');

            var dataToUpdate = JSON.parse(decodeURI(x));

            $("#TestTitle").html(dataToUpdate.examName);
            $("#class").html(dataToUpdate.subject + " " + dataToUpdate.catalogNumber);
            $("#section").html(dataToUpdate.section);
            $("#status").html(dataToUpdate.examStatus);
            $("#start").html(dataToUpdate.startDate);
            $("#end").html(dataToUpdate.endDate);
            $("#examTime").html(dataToUpdate.duration);

            var buttonToAdd = "<input value='Cancel Request' class='cancelButton btn-primary' type='button' onclick='javascript:window.open(\x22 cancelExam.jsp?ExamRefinedId=" +dataToUpdate.refinedId+" \x22, \x22_self\x22); return;' ></input>";

            $("#cancel").html(buttonToAdd);

           for(var i = 0; i<dataToUpdate.appointments.length; i++){

               var trOpen = "<tr>",trclose ="</tr>",thopen="<th>",thclose="</th>";
               var netid = thopen + dataToUpdate.appointments[i].netId + thclose;
               var date = thopen + dataToUpdate.appointments[i].appointmentDate + thclose;
               var status = thopen +  dataToUpdate.appointments[i].appointmentStatus + thclose;
               var seatnum = thopen + dataToUpdate.appointments[i].seatNumber + thclose;
               var tableRowToAppend = trOpen + netid + date + seatnum +status +  trclose;
               $("#studentAppointments").append(tableRowToAppend);
           }
        }

        function createList(x) {
            console.log("Create List");
            console.log(x);

            for (var i = 0; i < x.length; i++) {
                var examObject = x[i];
                var test = "<a  class='list-group-item' onclick='switchView(this, \x22 " + encodeURI(JSON.stringify(examObject)) + "\x22 ) ' > " + examObject.examName + "</a>";
                $("#examList").append(test);
            }
        }

        function submitTerm(termId, termName) {
            document.form1.termId.value = termId;
            document.form1.termName.value = termName;
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

