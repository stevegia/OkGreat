<% String title = "Exams"; %>
<%@include file="adminHeader.jsp"%>
<% logger.info("at admin's exams page");
    List<Exam> examsPending = retriever.getExamsOfStatus("PENDING");
    List<Exam> examsApproved = retriever.getExamsOfStatus("APPROVED");
    List<Exam> examsDenied = retriever.getExamsOfStatus("DENIED");
%>
<div class="container">
    <div class="row">
        <div class="col-md-1">
            Pending:
        </div>
        <div class="col-md-11">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th> Exam </th>
                        <th> Name </th>
                        <th> StartDate </th>
                        <th> EndDate </th>
                        <th> </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%for(Exam exam : examsPending){
                    %>  <tr>
                            <td > <%=exam.getRefinedId()%> </td>
                            <td > <%=exam.getExamName()%> </td>
                            <td > <%=exam.getStartDate()%> </td>
                            <td > <%=exam.getEndDate()%> </td>
                            <td > <a href="examUtilization.jsp?examRefinedId=<%=exam.getRefinedId()%>"><button>View</button></a> </td>
                        </tr>
                    <%}
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-1">
            Approved:
        </div>
        <div class="col-md-11">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th> Exam </th>
                        <th> Name </th>
                        <th> StartDate </th>
                        <th> EndDate </th>
                        <th> </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%for(Exam exam : examsApproved){
                    %>  <tr>
                            <td > <%=exam.getRefinedId()%> </td>
                            <td > <%=exam.getExamName()%> </td>
                            <td > <%=exam.getStartDate()%> </td>
                            <td > <%=exam.getEndDate()%> </td>
                            <td></td>
                            <!--
                            <td > <a href="examUtilization.jsp?examRefinedId=<%=exam.getRefinedId()%>"><button>View</button></a> </td>
                            -->
                        </tr>
                    <%}
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-1">
            Denied:
        </div>
        <div class="col-md-11">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th> Exam </th>
                        <th> Name </th>
                        <th> StartDate </th>
                        <th> EndDate </th>
                        <th> </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%for(Exam exam : examsDenied){
                    %>  <tr>
                            <td > <%=exam.getRefinedId()%> </td>
                            <td > <%=exam.getExamName()%> </td>
                            <td > <%=exam.getStartDate()%> </td>
                            <td > <%=exam.getEndDate()%> </td>
                            <td></td>
                            <!--
                            <td > <a href="examUtilization.jsp?examRefinedId=<%=exam.getRefinedId()%>"><button>View</button></a> </td>
                            -->
                        </tr>
                    <%}
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
