<% String title = "Import Data"; %>
<%@include file="adminHeader.jsp"%>
<% logger.info("at admin's importData page");
    List<Term> terms = retriever.getTerms();
    int termId = 1158;
    String termName = "Fall 2015";
    if (request.getParameter("termId") != null) {
        termId = Integer.parseInt(request.getParameter("termId"));
        termName = request.getParameter("termName");
    }
%>
<body>
	<div class="container"> 
        <div class="col-5">
            <div class="TermButton">
                <div class="dropdown">
                    Term:
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="true">
                        <%out.print(termName);
                        %>
                    </button>
                    <ul class="dropdown-menu" id="termDropdown" aria-labelledby="dropdownMenu1">
                        <%for(Term term : terms){
                        %> <li onclick="submitTerm(<%=term.getId()%>,'<%=term.getTermName()%>')"><%=term.getTermName()%></li>
                        <%}
                        %>
                    </ul>
                </div>
            </div>
            <!--This is a hidden form that enables term changing -->
            <form NAME="form1">
                <INPUT TYPE="HIDDEN" NAME="termId" value=<%=termId%>>
                <INPUT TYPE="HIDDEN" NAME="termName" value=<%=termName%>>
            </form>
          <br>
          <button>Browse</button>
          <p>Browse for folder containing data files</p>
          <p>user.csv, class.csv, and roster.csv</p>
          Number of superfluous appointments detected: 0
        </div>
    </div>
</body>
<SCRIPT LANGUAGE="JavaScript">
    function submitTerm(termId, termName) {
        document.form1.termId.value = termId;
        document.form1.termName.value = termName;
        form1.submit();
    }

    function changeTermName(termName) {
        if (termName != "" && termName != null) {
            $("#dropdownMenu1").html(termName);
        }
    }
    // -->
</SCRIPT>
</html>
