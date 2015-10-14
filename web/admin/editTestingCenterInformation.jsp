<%@page import="javax.swing.JOptionPane"%>
<%@page import="DBWorks.DBConnection"%>
<%
	if ((request.getParameter("action") != null) && (request.getParameter("action").trim().equals("logout"))) {
		//session.putValue("login", "");
                session.setAttribute("login", "");
		response.sendRedirect("/");
		return;
	}
	String numberofseats = request.getParameter("numberofseats");
    String numberofsetasideseats = request.getParameter("numberofsetasideseats");
    String gaptime = request.getParameter("gaptime");
    String remainderinterval = request.getParameter("remainderinterval");
    String remaindertime = request.getParameter("remaindertime");
    String query=null;
    /*session netid is admin */

    java.sql.ResultSet rs = DBConnection.ExecQuery(query);
	if ((numberofseats!=null) && (numberofsetasideseats!=null) && (gaptime!=null) && (remaindertime!=null))   /*Fields entered */ {
        if (numberofseats.trim().equals("") || numberofsetasideseats.trim().equals("") || gaptime.trim().equals("") || remaindertime.trim().equals(""))   /*If just whitespace */ {
            response.sendRedirect("testingCenterInformation.html");
        } else {
            query = "UPDATE TestingCenter SET NumberOfSeats=" + numberofseats + " AND NumberOfSetAsideSeats=" + numberofsetasideseats + " AND GapTime = " + gaptime + " AND ReminderInterval=" + remainderinterval;
            System.out.println(query);
            rs = DBConnection.ExecQuery(query);

            response.sendRedirect("testingCenterInformation.jsp");

        }
    }
%>