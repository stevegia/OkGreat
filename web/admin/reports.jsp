<% String title = "Reports"; %>
<%@include file="adminHeader.jsp"%>
<% logger.info("at admin's report page");
    List<Term> terms = retriever.getTerms();
    String report = "<u>over 9000</u>" +
            "<br>Utilization";
    int termId = 1158;
    String termName = "Fall 2015";
    if (request.getParameter("termId") != null) {
        termId = Integer.parseInt(request.getParameter("termId"));
        termName = request.getParameter("termName");
    }
    logger.info("termId= "+termId+", termName="+termName);
    report = retriever.getReportInTerm(termId);
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
                    out.print(termName);
                %>
            </button>
            <ul class="dropdown-menu" id="termDropdown" aria-labelledby="dropdownMenu1">
                <%for(Term term : terms){
                %> <li onclick="submitTerm(<%=term.getId()%>,'<%=term.getTermName()%>')"><%=term.getTermName()%></li>
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
        <INPUT TYPE="HIDDEN" NAME="termId" value=<%=termId%>>
        <INPUT TYPE="HIDDEN" NAME="termName" value=<%=termName%>>
    </form>
    <div class="textbox">
        <%=report%>
    </div>
</div>

</body>
<SCRIPT LANGUAGE="JavaScript">
    function submitTerm(termId, termName) {
        document.form1.termId.value = termId;
        document.form1.termName.value = termName;
        form1.submit();
    }
</SCRIPT>

</html>
