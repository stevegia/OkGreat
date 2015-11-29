<%@ page import="java.text.SimpleDateFormat" %>
<% String title = "Exam Utilization"; %>
<%@include file="adminHeader.jsp"%>
<% logger.info("at admin's exam utilization page");
    String examRefinedId = request.getParameter("examRefinedId");
    if(examRefinedId==null){
        logger.info("not examRefinedId found");
        session.setAttribute("message", "no examRefinedId found");
        session.setAttribute("url", "admin/exams.jsp");
        response.sendRedirect("../error.jsp");
    }
    Exam exam = retriever.getExam(examRefinedId);
    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    GregorianCalendar cal = new GregorianCalendar();
    Date startDate = exam.getStartDate();
    Date endDate = exam.getEndDate();
    cal.setTime(startDate);
%>

<div class="container">
    <div class="row">
        <div class="col-md-11">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th> Date </th>
                        <th> Current Utilization </th>
                        <th> Utilization After Approval </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%while (!cal.getTime().after(endDate)) {
                    %>  <tr>
                            <td > <%=dateFormatter.format(cal.getTime())%> </td>
                            <td > <%="0"%> </td>
                            <td > <%="50"%> </td>
                        </tr>
                    <%  cal.add(Calendar.DAY_OF_YEAR, 1);
                     }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
  <!-- if scheduable -->
    <a href="approveExam.jsp?examRefinedId=<%=examRefinedId%>"><button>Approve</button></a>
    <a href="denyExam.jsp?examRefinedId=<%=examRefinedId%>"><button>Deny</button></a>



</body>
</html>
