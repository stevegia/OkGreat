<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    session.removeAttribute("user");
	session.invalidate();
    response.sendRedirect("index.jsp");
%>