<%@ page import="java.util.logging.Logger" %>
<html>
<head>
	<title>Error</title>
</head>
<body>
<div>Error</div>

<%  Logger logger= Logger.getLogger(this.getClass().getName());
	logger.info("at error page");
	if((String) session.getAttribute("message")!=null) {
%><%=(String) session.getAttribute("message")%>
<%	logger.info("error message is "+ (String) session.getAttribute("message"));
	session.setAttribute("message", "");
	}
%>
<% if((String) session.getAttribute("url")!=null) {
%>  <a href="<%=(String) session.getAttribute("url")%>">
	<button>Return</button>
</a>
<%  session.setAttribute("url", "index.jsp");
} else{
%>	<button>Return</button>
<% }
%>
</body>
</html>