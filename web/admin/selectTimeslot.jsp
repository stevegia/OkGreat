<% String title = "Select Timeslot";%>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Time" %>
<%@include file="adminHeader.jsp" %>
<h2>Available Timeslots</h2>
<div class="container">

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Appointment Start</th>
            <th>Appointment End</th>
        </tr>
        </thead>
        <tbody>
<%
    logger.info("Now at the selectTimeslot.jsp file from the makeAppointments.jsp file");

    String studentNetId = request.getParameter("studentNetId");
    String examRefinedId = request.getParameter("examRefinedId");
    String typeOfSeat = request.getParameter("seatRadio");

    session.setAttribute("studentNetId", studentNetId);
    session.setAttribute("examRefinedId", examRefinedId);
    session.setAttribute("typeOfSeat", typeOfSeat);

    Validator validator = Validator.getInstance();

    if (validator.eligibleForExam(studentNetId, examRefinedId) && validator.noExistingAppointmentForExam(studentNetId, examRefinedId)) {
        Exam exam = retriever.getExam(examRefinedId);
        TestingCenter testingCenter = Retriever.getTestingCenter();

        LocalDateTime start = exam.getStartDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        LocalDateTime end = exam.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        for (LocalDateTime date = start; date.isBefore(end); date = date.plusMinutes(exam.getDuration() + testingCenter.getGapTime()).truncatedTo(ChronoUnit.HOURS).plusHours(1)) {
            if(validator.noOverlappingAppointments(Date.from(date.atZone(ZoneId.systemDefault()).toInstant()))) {
                Date convertedDate = Date.from(date.atZone(ZoneId.systemDefault()).toInstant());
                TestingCenterHour tch = retriever.getTestingCenterHour(convertedDate);
                if (tch != null) {
                    Time apptStartTime = Time.valueOf(date.toLocalTime());
                    if ((apptStartTime.equals(tch.getStartTime()) || apptStartTime.after(tch.getStartTime())) && apptStartTime.before(tch.getEndTime())) {

%>
        <tr>
            <td><%= date.format(dtf) %></td>
            <td><%= date.plusMinutes(exam.getDuration() + testingCenter.getGapTime()).format(dtf) %></td>
            <td><input type="button" onclick="javascript:
                    window.open('submitAppointment.jsp?apptDate=<%=date.format(dtf)%>', '_self');
                    return;" value="Select"></td>

        </tr>
<%
                    }
                }
            }
        }
    }
%>
        </tbody>
    </table>
</div>
</body>
</html>