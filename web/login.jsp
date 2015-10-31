<%@ page import="jpaentities.TCSUser" %>
<%@ page import="application.*" %>
<%
	String netId = request.getParameter("netid");
	String password = request.getParameter("password");
	Retriever loginValidator = Retriever.getInstance();
	TCSUser user = loginValidator.getUser(netId, password);

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
				response.sendRedirect("error.jsp");
				break;
		}
	}
	else response.sendRedirect("error.jsp");
%>