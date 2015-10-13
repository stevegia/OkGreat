<%@page import="java.util.logging.Logger"%>
<%@ page import="java.util.logging.FileHandler" %>

<% Logger logger=Logger.getLogger("loginprocess.jsp");%>
<% FileHandler fileHandler = new FileHandler("logs/loginPage.txt");
    logger.addHandler(fileHandler);;%>

<html lang="en">
<head>
    <meta name="viewport" content="width=device-width" charset="UTF-8">

    <title>Login</title>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="css/login.css">
  <script type="text/javascript" src="log4javascript.js"></script>
  <script type="text/javascript">

  </script>
</head>
<body>
<div class="loginHeader">Testing Center</div>

<div class="container">
  <div class="row">
    <div class="col-sm-6 col-md-4 col-md-offset-4 login-offset">
      <h1 class="text-center login-title">Welcome to the Testing Center</h1>
<%            logger.info("Login Processing, reading in values");
%>

        <form action="loginprocess.jsp" method="post">
        <input  type="text" class="form-control" placeholder="NetID" name="netid" required autofocus>
          <input type="password" class="form-control" placeholder="password" name="password" required>

        <button class="btn btn-lg btn-primary btn-block" type="submit">
            Log In</button>

        </form>

    </div>
  </div>
</div>


</body>

</html>
