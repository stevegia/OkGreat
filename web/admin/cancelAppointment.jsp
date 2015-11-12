<% String title = "Cancel Appointment";%>
<%@include file="adminHeader.jsp"%>
<%
    int apptId = -1;
    Appointment appointment=null;
    String message;
    String url;
    logger.info("at editAppointmentProcess");
    logger.info("Appointment ID is " + apptId);
    try {
        apptId = Integer.parseInt(request.getParameter("AppointmentId"));
        appointment = retriever.getAppointment(apptId);
    }catch(Exception e) {
        logger.info("unable to get appointment");
        session.setAttribute("message", "unable to get appointment");
        session.setAttribute("url", "admin/appointments.jsp");
        url = "../error.jsp";
        response.sendRedirect(url);
    }
    try {
        appointment.cancel();
        retriever.persist(appointment);
    }catch(Exception e){
        logger.info("error canceling appointment");
        session.setAttribute("message", "error canceling appointment");
        session.setAttribute("url", "admin/appointments.jsp");
        url = "../error.jsp";
        response.sendRedirect(url);
    }
    response.sendRedirect("appointments.jsp");
%>