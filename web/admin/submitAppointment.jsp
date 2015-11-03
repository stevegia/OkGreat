<%@ page import="application.*"%>
<%
    Administrator admin = (Administrator) session.getAttribute("user");
    String studentNetId = request.getParameter("studentNetId");
    String examRefinedId = request.getParameter("examRefinedId");
    String typeOfSeat = request.getParameter("seatRadio");
    String apptDatetime = request.getParameter("appointmentDatetime");
    boolean apptSuccessful = admin.makeAppointment(studentNetId, examRefinedId, apptDatetime, typeOfSeat);

    if (apptSuccessful)
        response.sendRedirect("appointments.jsp");
    else {
        System.out.println("There was an error making your appointment. Make sure your inputs are correct.");
        response.sendRedirect("error.jsp");
    }
%>