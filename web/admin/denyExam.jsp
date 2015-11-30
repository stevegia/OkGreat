<% String title = "Exam";%>
<%@include file="adminHeader.jsp"%>

  Exam exam=null;
  try {
    String ExamRefinedId = request.getParameter("ExamRefinedId");
    exam = retriever.getExam(ExamRefinedId);
  }catch(Exception e) {
    response.sendRedirect("../error.jsp");
  }
  try {
    exam.deny();
    retriever.persist(exam);
  }catch(Exception e){
    logger.info("error denying appointment");
    session.setAttribute("message", "error denying appointment");
    session.setAttribute("url", "admin/examsAndAppointments.jsp");
    response.sendRedirect("../error.jsp");
  }
  response.sendRedirect("examsAndAppointments.jsp");
%>
