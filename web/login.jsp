<%@ page import="jpaentities.TCSUser" %>
<%@ page import="application.*" %>
<%@ page import="java.util.logging.Logger" %>
<%
	String netId = request.getParameter("netid");
	String password = request.getParameter("password");
	Retriever loginValidator = Retriever.getInstance();
	TCSUser user = loginValidator.getUser(netId, password);
	Logger logger= Logger.getLogger(this.getClass().getName());
	logger.info("attempting to login, netId is "+netId+" , password is "+password);

	if (user != null) {
		switch (user.getUserType()) {
			case ADMINISTRATOR:
				Administrator admin = new Administrator(user);
				session.setAttribute("user", admin);
				logger.info("admin account matched");
				response.sendRedirect("admin/testingCenterInformation.jsp");
				break;
			
			case INSTRUCTOR:
				Instructor instructor = new Instructor(user);
				session.setAttribute("user", instructor);
				logger.info("instructor account matched");
				response.sendRedirect("instructor/pendingRequests.jsp");
				break;

			case STUDENT:
				Student student = new Student(user);
				session.setAttribute("user", student);
				logger.info("student account matched");
				response.sendRedirect("student/appointments.jsp");
				break;

			default:
				session.invalidate();
				logger.info("no account matched");
				response.sendRedirect("error.jsp");
				break;
		}
	}
	else {
		logger.info("no account matched");
		response.sendRedirect("error.jsp");
	}
%>