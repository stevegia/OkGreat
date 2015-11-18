<%@page import="java.util.logging.Logger"%>
<%@ page import="java.util.logging.FileHandler" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.logging.SimpleFormatter" %>

<% Logger logger=Logger.getLogger("logon.jsp");%>
<%
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
    FileHandler fileHandler = new FileHandler("okgreatlogs/log.xml");
    SimpleFormatter formatter = new SimpleFormatter();
    fileHandler.setFormatter(formatter);
    logger.addHandler(fileHandler);

    logger.info("info reached index page ");
    fileHandler.close();

%>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/main.css">
    <script type="text/javascript"></script>
</head>
<body>
<div class="loginHeader">Testing Center</div>

<div class="container">
    <div class="row">
        <a class="btn btn-lg btn-primary btn-block login-button" href="admin/appointments.jsp" >Admin</a>
        <a class="btn btn-lg btn-primary btn-block login-button" href="instructor/pendingRequests.jsp">Instructor</a>
        <a class="btn btn-lg btn-primary btn-block login-button" href="student/appointments.jsp">Student</a>


        </div>
    </div>
</div>
</body>
</html>