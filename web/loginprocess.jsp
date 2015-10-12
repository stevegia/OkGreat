

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