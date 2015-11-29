<% String title = "Make Appointment";%>
<%@include file="studentHeader.jsp" %>
<%logger.info("Now at the make.jsp file");
%>
<div class="makeAppointmentContent">

    <form action="selectTimeslot.jsp">

        <div class="col-md-5">
            <div class="row">Exam Identifier</div>
            <div class="row">
                <div class="input-group">
                    <input type="text" class="form-control"
                           placeholder="Enter Identifier" name="examRefinedId"
                           aria-describedby="basic-addon2">
                </div>
            </div>
            <div class="row">
                <input type="submit" value="Submit Request">
            </div>
        </div>

    </form>


</div>


</body>

</html>
