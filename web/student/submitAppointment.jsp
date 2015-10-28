<!DOCTYPE html>
<html lang="en">
<head></head>

<%@ page import="jpaentities.TCSUser"%>
<%@ page import="application.*"%>

<body>
	<%
		Student student = (Student) session.getAttribute("user");
	%>

	<div>

		<%
			System.out.println(student.getNetId());
			request.getParameter("termId");
			request.getParameter("examRefinedId");
			request.getParameter("appointmentDatetime");
		%>


	</div>
</body>
</html>