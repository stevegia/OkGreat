<%@page import="basic.okgreat.Login"%>
<jsp:useBean id="obj" class="basic.okgreat.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%
    String id = request.getParameter("netid");
    String pw = request.getParameter("password");
    if(id.equals("student")){

        response.sendRedirect("student/appointments.jsp");
        return;
    }
    if(id.equals("instructor")){

        response.sendRedirect("student/appointments.jsp");
        return;
    }

    if(id.equals("admin")){

        response.sendRedirect("admin/testingCenterInformation.jsp");
        return;
    }

%>