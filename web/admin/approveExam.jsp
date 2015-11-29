<% String title = "Approve Exam"; %>
<%@include file="adminHeader.jsp"%>
<% logger.info("at admin's deny exam page");
    String examRefinedId = request.getParameter("examRefinedId");
    if(examRefinedId==null){
        logger.info("not examRefinedId found");
        session.setAttribute("message", "no examRefinedId found");
        session.setAttribute("url", "admin/exams.jsp");
        response.sendRedirect("../error.jsp");
    }
    Exam exam = retriever.getExam(examRefinedId);
    if(exam==null){
        logger.info("not examRefinedId found");
        session.setAttribute("message", "no examRefinedId found");
        session.setAttribute("url", "admin/exams.jsp");
        response.sendRedirect("../error.jsp");
    }
    exam.setExamStatus("APPROVED");
    retriever.persist(exam);
    response.sendRedirect("exams.jsp");
%>
</body>
</html>
