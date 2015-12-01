<%@ page import="application.Retriever" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Retriever retriever = Retriever.getInstance();
    String x = (String) request.getParameter("id");
    System.out.println(x);
    String examInfo = retriever.getExamByIdString(x);


%>
<html>
<body>
    <div class="container-fluid">
        <div style="margin-left:20px"></div>
            <div class="row">
                <div class="col-lg-10 modalAppointmentInfo">
                    <div id="row">
                        <div class="toprow" id="appointmentTitle">No Exam Selected</div>
                        <div class="container-fluid">
                            <div class="col-md-5">
                                <!--Left column -->
                                <div class="row ">
                                    <div class="col-md-3" id="classLabel">Class:</div>
                                    <div class="col-md-4" id="class"></div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-3" id="netIdLabel">Instructor Netid:</div>
                                    <div class="col-md-4" id="netId"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3" id="sectionLabel">Section:</div>
                                    <div class="col-md-4" id="section"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3" id="seatNumberLabel">SeatNumber:</div>

                                    <div class="col-md-4" id="seatNumber"></div>

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
                        <div class="row">

                            <div class="container-fluid">
                                <div style="padding-top: 20px"></div>
                                <div class="row"><div id="cancel"></div></div>
                                <div style="padding-bottom: 20px"></div>
                          <!--
                                <div style="padding-top: 20px"></div>
                                <div class="row"><div id="edit"></div></div>
                                <div style="padding-top: 20px"></div>
                                <div class="row"><div id="checkin"></div></div>
                                <div style="padding-top: 20px"></div>
                            </div>
        -->



                    </div>

                    </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<script>

    loadResults('<%=examInfo%>');

    function loadResults(examInfo) {

        var exam = JSON.parse(decodeURI(examInfo));
        console.log(exam);
        console.log("exam");



        $("#appointmentTitle").html(exam.examName);
        $("#class").html(exam.subject + " " + exam.catalogNumber);
        $("#section").html(exam.section);
        $("#status").html(exam.appointmentStatus);
        $("#start").html(exam.startDate);
        $("#end").html(exam.endDate);
        $("#examTime").html(exam.duration);
        $("#seatNumber").html(exam.seatNumber);
        $("#netId").html(exam.instructorNetId);
        console.log(exam.id);

        var cancelButtonToAdd = "<input value='Cancel Appointment' class='cancelButton btn-primary' type='button' onclick='javascript: window.open(\x22cancelAppointment.jsp?AppointmentId="+exam.id+"\x22, \x22_self\x22);'>";
    //    var editButtonToAdd = "<input value='Edit Appointment' class='cancelButton btn-primary' type='button' onclick='javascript: window.open(\x22editAppointment.jsp?AppointmentId="+exam.id+"\x22, \x22_self\x22);'>";
    //    var checkinButtonToAdd = "<input value='Check In' class='cancelButton btn-primary' type='button' onclick='javascript: window.open(\x22checkInStudent.jsp?AppointmentId="+exam.id+"\x22, \x22_self\x22);'>";



        $("#cancel").html(cancelButtonToAdd);
    //    $("#edit").html(editButtonToAdd);
     //   $("#checkin").html(checkinButtonToAdd);


    }
    </script>
</html>
