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

		<link rel="stylesheet" href="../css/login.css">
		<link rel="stylesheet" href="../css/main.css">
		<script type="text/javascript"></script>
	</head>
	<body>
		<div class="loginHeader">Testing Center</div>

		<div class="container">
  			<div class="row">
    			<div class="col-sm-6 col-md-4 col-md-offset-4 login-offset">
      				<h1 class="text-center login-title">Welcome to the Testing Center</h1>
					<div style="padding-top:20px" ></div>
        			<form action="j_security_check" method="post">
        				<input type="text" class="form-control netid" placeholder="NetID" name="j_username" required autofocus>
						<div class="buffer"></div>
          					<input type="password" class="form-control password" placeholder="password" name="j_password" required>
        				<div class="buffer"></div>
						<button class="btn btn-lg btn-primary btn-block login-button" type="submit">Log In</button>
        			</form>

    			</div>
  			</div>
		</div>
	<script>setInterval(function(){
		location.reload(true);
	},5*60*1000);</script>
	</body>
</html>