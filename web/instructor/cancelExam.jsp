<%@ page import="application.Retriever" %>
<%@ page import="jpaentities.Exam" %>
<%@ page import="application.Instructor" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.FileHandler" %>
<%@ page import="java.util.logging.SimpleFormatter" %>
<%
  Logger logger=Logger.getLogger(this.getClass().getName());
  FileHandler fileHandler = new FileHandler("okgreatlogs/"+this.getClass().getName()+" .xml");
  SimpleFormatter formatter = new SimpleFormatter();
  fileHandler.setFormatter(formatter);
  logger.addHandler(fileHandler);
  logger.info("at instructor's cancelExam");
  // use this apptId to link back to the appointment in the database
  String examRefinedId = request.getParameter("ExamRefinedId");
  Retriever retriever = Retriever.getInstance();
  Instructor instructor = new Instructor(retriever.getUser(request.getRemoteUser()));
  instructor.cancelExam(examRefinedId);
  logger.info("Exam "+ examRefinedId+" cancelled");
  response.sendRedirect("pendingRequests.jsp");
%>