<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Exam" %>
<%@ page import="application.Instructor" %><%
  // use this apptId to link back to the appointment in the database
  String examRefinedId = request.getParameter("ExamRefinedId");
  System.out.println("Exam ID is " + examRefinedId);

  Instructor user = (Instructor) session.getAttribute("user");
  user.cancelExam(examRefinedId);

  System.out.println("Cancel button clicked");
  response.sendRedirect("pendingRequests.jsp");
%>