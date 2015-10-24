<%@ page import="jpaentities.TCSUser" %>
<%@ page import="application.*" %>
<%@ page import="utils.Constants" %>
<%
	String netId = request.getParameter("netid");
	String password = request.getParameter("password");
	TCSUser user = Retriever.validate(netId, password);
	System.out.println("netId is "+netId+" and password is "+password);
	if (user != null) {
		switch (user.getUserType()) {
			case ADMINISTRATOR:
				Administrator admin = new Administrator(user);
				session.setAttribute("user", admin);
				response.sendRedirect("admin/testingCenterInformation.jsp");
				break;
			
			case INSTRUCTOR:
				Instructor instructor = new Instructor(user);
				session.setAttribute("user", instructor);
				response.sendRedirect("instructor/pendingRequests.jsp");
				break;

			case STUDENT:
				Student student = new Student(user);
				session.setAttribute("user", student);
				response.sendRedirect("student/appointments.jsp");
				break;

			default:
				session.invalidate();
				System.out.println("error matching user type");
				response.sendRedirect("error.jsp");
				break;
		}
	}
	else {
	System.out.println("user is null, error retrieving");
	response.sendRedirect("error.jsp");
	}
%>