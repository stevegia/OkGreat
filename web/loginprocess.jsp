<%@page import="DBWorks.DBConnection"%>
<%@page import="java.util.logging.Logger"%>
<%@ page import="java.util.logging.FileHandler" %>
<%@ page import="java.io.File" %>

<% Logger logger=Logger.getLogger("loginprocess.jsp");%>
<%
    File dir = new File("./logs");

    System.out.println( dir.getAbsolutePath());



    // Tests whether the directory denoted by this abstract pathname exists.
    String current = new java.io.File( "." ).getCanonicalPath();
    boolean exists = dir.exists();
    System.out.println(current);
    if(exists == false){
        File root = new File(current);
        File newfolder = new File(root, "/logs");
        newfolder.mkdir();
    }






    FileHandler fileHandler = new FileHandler("logs/login.txt");
    logger.addHandler(fileHandler);;%>

<%
    if ((request.getParameter("action") != null) && (request.getParameter("action").trim().equals("logout"))) {
        logger.info("logging out");
        session.setAttribute("login", "");
        response.sendRedirect("/");
        return;
    }
    String id = request.getParameter("netid");
    String userpasswd = request.getParameter("password");
    String query = null;
    System.out.println("Login Processing");
    logger.info("Login Processing, reading in values");
    session.setAttribute("login", "");
    if (id != null && userpasswd != null) {
        if (id.trim().equals("") || userpasswd.trim().equals("")) {
            logger.info("One of more fields empty/whitespace, redirecting back");
            response.sendRedirect("index.jsp");
        } else {
            query = "SELECT * FROM TCSUser WHERE NetId = '"
                    + id + "' AND Password = '" + userpasswd + "' AND UserType = 'Administrator'";
            java.sql.ResultSet rs = DBConnection.ExecQuery(query);
            System.out.println(rs);
            logger.info("rs is "+rs);
            if (rs.next()) {
                logger.info("logged onto admin");
                session.setAttribute("login", "" + id);
                response.sendRedirect("admin/testingCenterInformation.jsp");
            } else {
                query = "SELECT * FROM TCSUser WHERE NetId = '"
                        + id + "' AND Password = '" + userpasswd + "' AND UserType = 'Instructor'";
                rs = DBConnection.ExecQuery(query);
                System.out.println(rs);
                if (rs.next()) {
                    logger.info("logged onto instructor");
                    session.setAttribute("login", "" + id);
                    response.sendRedirect("instructor/pendingRequests.jsp");

                } else {
                    query = "SELECT * FROM TCSUser WHERE NetId = '"
                            + id + "' AND Password = '" + userpasswd + "' AND UserType = 'Student'";
                    rs = DBConnection.ExecQuery(query);
                    if (rs.next()) {
                        logger.info("logged onto student");
                        session.setAttribute("login", "" + id);
                        response.sendRedirect("student/appointments.jsp");
                    }
                    // username or password mistake//
                    logger.info("incorrect login");
                    logger.info("Username or Password is not Correct!!!");
%>
<br>
<a href="index.jsp"> Back to login page </a>
<%
                }
            }

        }
    } else
        {
            logger.info("id and/or pass is null, redirecting back");
        response.sendRedirect("index.jsp");}
%>