<%@ page import="java.io.File" %>
<%@ page import="application.*" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.SimpleFormatter" %>
<%@ page import="java.util.logging.FileHandler" %>
<%@ page import="jpaentities.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    Logger logger=Logger.getLogger(this.getClass().getName());
    FileHandler fileHandler = new FileHandler("okgreatlogs/"+this.getClass().getName()+" .xml");
    SimpleFormatter formatter = new SimpleFormatter();
    fileHandler.setFormatter(formatter);
    logger.addHandler(fileHandler);
    Retriever retriever = Retriever.getInstance();
    Student student=null;
    try {
        student = new Student(retriever.getUser(request.getRemoteUser()));
    }catch(Exception e){
    session.setAttribute("message", "date "+request.getParameter("date")+" not found in DB");
    session.setAttribute("url", "admin/testingCenterInformation.jsp");
    response.sendRedirect("../error.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">

    <title><%=title%></title>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/underscore.js"></script>
    <script type="text/javascript" src="../js/calendar.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap-datepicker.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-datepicker.standalone.min.css">
    <link rel="stylesheet" href="../css/calendar.min.css">
    <link rel="stylesheet" href="../css/student/student.css">
    <link rel="stylesheet" href="../css/main.css">
</head>
<body>
<div class="header" id="header"><%=title%></div>
<script>

    window.onload = function(){
        var header = $("#header");
        if(header.html() == "Make Appointment"){
            header.attr("class","makeAppointmentHeader");
        }
        if(header.html() == "Appointments"){
            header.attr("class","appointmentsHeader");
        }
        if(header.html() == "Calendar") {
            header.attr("class", "calendarHeader");
        }
        if(header.html() == "Inbox") {
            header.attr("class", "inboxHeader");
        }
        if(header.html() == "Select Timeslot") {
            header.attr("class", "basicHeader");
        }
    }

</script>


<nav role="navigation" class="navbar navbar-default">
    <div class="container-fluid">


        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li id="appointments"><a href="appointments.jsp">Appointments</a></li>
                <li id="makeAppointment"><a href="make.jsp">Make Appointment<span class="sr-only">(current)</span>
                </a></li>
                <li id="calendar"><a href="calendar.jsp">Calendar</a></li>
                <li id="inbox"><a href="inbox.jsp">Inbox</a></li>
            </ul>
            <ul class="nav navbar-right logout">
                <li><a class="logout" href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>


        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>
