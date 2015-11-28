<% String title = "Reports"; %>
<%@include file="adminHeader.jsp"%>
<% logger.info("at admin's reportsRange page");
    List<Term> terms = retriever.getTerms();
    String report = "<u>over 9000</u>" +
            "<br>Utilization";
    int termId1 = 1158;
    String termName1 = "Fall 2015";
    int termId2 = 1161;
    String termName2 = "Winter 2015";
    if (request.getParameter("termId1") != null) {
        termId1 = Integer.parseInt(request.getParameter("termId1"));
        termName1 = request.getParameter("termName1");
    }
    if (request.getParameter("termId2") != null) {
        termId2 = Integer.parseInt(request.getParameter("termId2"));
        termName2 = request.getParameter("termName2");
    }
    logger.info("termId1= " + termId1 + ", termName1=" + termName1 + ", termId2=" + termId2 + ",termName2=" + termName2);
    report = retriever.getReportBetweenTerms(termId1, termId2);
    request.setAttribute("report", report);
    logger.info(report);
%>

<body>
<div class="container">
    <div class="row">
            <div class="dropdown">
                Term:
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="true">
                    <%
                        out.print(termName1);
                    %>
                </button>
                <ul class="dropdown-menu" id="termDropdown" aria-labelledby="dropdownMenu1">
                    <%for(Term term : terms){
                    %> <li onclick="submitTerm1(<%=term.getId()%>,'<%=term.getTermName()%>')"><%=term.getTermName()%></li>
                    <%
                        }%>
                    <a href="reportsRange.jsp">
                        <li>Range of Terms</li>
                    </a>
                </ul>
        </div>
        <div class="dropdown">
            &nbsp&nbsp&nbspto
            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="true">
                <%
                    out.print(termName2);
                %>
            </button>
            <ul class="dropdown-menu" id="termDropdown2" aria-labelledby="dropdownMenu2">
                <%for(Term term : terms){
                %> <li onclick="submitTerm2(<%=term.getId()%>,'<%=term.getTermName()%>')"><%=term.getTermName()%></li>
                <%
                    }%>
                <a href="reportsRange.jsp">
                    <li>Range of Terms</li>
                </a>
            </ul>
        </div>
    </div>
    <!--This is a hidden form that enables term changing -->
    <form NAME="form1">
        <INPUT TYPE="HIDDEN" NAME="termId1" value="<%=termId1%>">
        <INPUT TYPE="HIDDEN" NAME="termName1" value="<%=termName1%>">
        <INPUT TYPE="HIDDEN" NAME="termId2" value="<%=termId2%>">
        <INPUT TYPE="HIDDEN" NAME="termName2" value="<%=termName2%>">
    </form>
    <br>
    <button onclick="submit()">Generate Report</button>
    <br><br>
    <h3><%=termName1%> to <%=termName2%></h3>
    <br>
    <div class="textbox">
        <%=report%>
    </div>
</div>

</body>
<SCRIPT LANGUAGE="JavaScript">
    function submitTerm1(termId, termName) {
        document.form1.termId1.value = termId;
        document.form1.termName1.value = termName;
        $("#dropdownMenu1").html(termName);
    }
    function submitTerm2(termId, termName) {
        document.form1.termId2.value = termId;
        document.form1.termName2.value = termName;
        $("#dropdownMenu2").html(termName);
    }
    function submit() {
        form1.submit();
    }
</SCRIPT>

</html>
