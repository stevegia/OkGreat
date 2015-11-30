<% String title = "Exam";%>
<%@include file="adminHeader.jsp"%>
<%@ page import="jpaentities.Exam" %><%

  Exam exam=null;

  try {
    String ExamRefinedId = request.getParameter("ExamRefinedId");
    exam = retriever.getExam(ExamRefinedId);
  }catch(Exception e) {

    response.sendRedirect("../error.jsp");
  }
  try {
    exam.approve();
    retriever.persist(exam);
  }catch(Exception e){
    logger.info("error approving appointment");
    session.setAttribute("message", "error approving appointment");
    session.setAttribute("url", "admin/examsAndAppointments.jsp");
    response.sendRedirect("../error.jsp");
  }
  response.sendRedirect("examsAndAppointments.jsp");
%>
