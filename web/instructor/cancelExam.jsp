<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Exam" %>
<%@ page import="application.Instructor" %>
<%@ page import="java.util.logging.Logger" %>
<%Logger logger= Logger.getLogger(this.getClass().getName());
  logger.info("at instructor's cancelExam");
  // use this apptId to link back to the appointment in the database
  String examRefinedId = request.getParameter("ExamRefinedId");
  Instructor user = (Instructor) session.getAttribute("user");
  user.cancelExam(examRefinedId);
  logger.info("Exam "+ examRefinedId+" cancelled");
  response.sendRedirect("pendingRequests.jsp");
%>