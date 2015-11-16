<%@ page import="java.util.logging.Logger" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%  Logger logger= Logger.getLogger(this.getClass().getName());
    logger.info("logging out");
    session.removeAttribute("user");
	session.invalidate();
    response.sendRedirect("logon.jsp");
%>