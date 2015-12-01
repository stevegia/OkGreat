<%@ page import="application.Administrator" %>
<%@include file="adminHeader.jsp" %>
<%
    Administrator admin = (Administrator) session.getAttribute("user");
    int termId = Integer.parseInt(request.getParameter("termId"));
    boolean importSuccessful = admin.importData(termId);
    if (importSuccessful) {
        response.sendRedirect("appointments.jsp");
    }
    else {
        response.sendRedirect("../error.jsp");
    }
%>