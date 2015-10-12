
<%@page import="javax.swing.JOptionPane"%>
<%@page import="DBWorks.DBConnection"%>
<%
    if ((request.getParameter("action") != null) && (request.getParameter("action").trim().equals("logout"))) {
        //session.putValue("login", "");
        session.setAttribute("login", "");
        response.sendRedirect("/");
        return;
    }
    String id = request.getParameter("netId");
    String userpasswd = request.getParameter("password");
    String query = null;
    session.setAttribute("login", "");
    if (id != null && userpasswd != null) {
        if (id.trim().equals("") || userpasswd.trim().equals("")) {
            response.sendRedirect("index.htm");
        } else {

            query = "SELECT * FROM User WHERE NetId = '"
                    + id + "' AND Password = '" + userpasswd + "' AND Type = 'Administrator'";
            java.sql.ResultSet rs = DBConnection.ExecQuery(query);
            if (rs.next()) {
                // login success
                session.setAttribute("login", "" + id);
                response.sendRedirect("admin/testingCenterInformation.jsp");
            } else {
                query = "SELECT * FROM User WHERE NetId = '"
                        + id + "' AND Password = '" + userpasswd + "' AND Type = 'Instructor'";
                rs = DBConnection.ExecQuery(query);
                if (rs.next()) {
                    // login success
					session.setAttribute("login", "" + id);
					response.sendRedirect("instructor/pendingRequests.jsp");
                    
                } else {
					query = "SELECT * FROM User WHERE NetId = '"
                        + id + "' AND Password = '" + userpasswd + "' AND Type = 'Student'";
					rs = DBConnection.ExecQuery(query);
					if (rs.next()) {
                    // login success
						session.setAttribute("login", "" + id);
						response.sendRedirect("student/appointments.jsp");
					}
                                // username or password mistake

                    out.print("Username or Password is not Correct!!!");
%>
<br>
<a href="index.htm"> Back to login page </a>
<%
                }
            }

            

        }
    } else
        response.sendRedirect("index.htm");

%>