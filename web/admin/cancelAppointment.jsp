<%
    // use this apptId to link back to the appointment in the database
    int apptId = Integer.parseInt(request.getParameter("ExamId"));
    System.out.println("Appointment ID is " + apptId);
    System.out.println("cancel button clicked");
    response.sendRedirect("appointments.jsp");
%>