<%@ page import="jpaentities.*" %>
<%@ page import="application.*" %>
<%@ page import="utils.Constants" %>
<%@ page import="java.util.*"%>
<%@ page import="java.util.logging.Logger"%>
<%@ page import="java.util.logging.FileHandler" %>
<%@ page import="java.io.File" %>
<%  Retriever retriever = Retriever.getInstance();
    Logger logger=Logger.getLogger(this.getClass().getName());
    //File dir = new File("./okgreatlogs",true); //true specify append mode
    File dir = new File("./okgreatlogs");
    System.out.println( dir.getAbsolutePath());
    // Tests whether the directory denoted by this abstract pathname exists.
    String current = new java.io.File( "." ).getCanonicalPath();
    boolean exists = dir.exists();
    System.out.println(current);
    if(exists == false){
    File root = new File(current);
    File newfolder = new File(root, "/okgreatlogs");
    newfolder.mkdir();
    }
    //FileHandler fileHandler = new FileHandler("okgreatlogs/"+(this.getClass().getName()));
    //logger.addHandler(fileHandler);
    // fh.close() seems to be needed if it keeps writing to new file
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
    <link rel="stylesheet" href="../css/calendar.min.css">
    <link rel="stylesheet" href="../css/admin/admin.css">
</head>
<body>
<div class="header"><%=title%></div>

<nav role="navigation" class="navbar navbar-default">
    <div class="container-fluid">

        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">


                <li id ="testingCenterInformation"><a href="testingCenterInformation.jsp">Testing Center Information</a></li>
               <!-- <li id="examsAndAppointments"><a href="examsAndAppointments.jsp">Exams and Appointments </a></li> -->
                <li id="appointments"><a href="appointments.jsp">Appointments </a></li>
                <li id="makeappointments"><a href="makeAppointments.jsp">Make Appointment </a></li>
                <li id="reports"><a href="reports.jsp">Reports <span class="sr-only">(current)</span> </a></li>
                <li id="importData"><a href="importData.jsp">Import Data</a></li>
                <li class="logout"><a href="../index.jsp">Logout<span class="sr-only">(current)</span></a></li>

            </ul>


        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>