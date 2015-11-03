<%@ page import="java.text.DateFormat" %>
<%@ page import="jpaentities.TestingCenterHour" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Time" %>
<% String title = "Testing Center Information";%>
<%@include file="adminHeader.html"%>
<%  logger.info("at editTestingCenterInformation.jsp");
    Date date=null;
    Time StartTime=null;
    Time EndTime=null;
    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");
    TestingCenterHour hour = null;

    boolean goodie=true;
    String url = "testingCenterInformation.jsp";
    try {
        hour = retriever.getTestingCenterHour(date);
        date = dateFormatter.parse(request.getParameter("date"));
        Date startTime = timeFormatter.parse(request.getParameter("starttime"));
        Date endTime =timeFormatter.parse(request.getParameter("endtime"));
        StartTime = new Time(startTime.getTime());
        EndTime = new Time(endTime.getTime());
        logger.info("no error retireving data and parsing");
        logger.info("date is "+request.getParameter("date")+" , StartTime is "+request.getParameter("starttime")+" , EndTIme is "+request.getParameter("endtime"));
    }catch(Exception e){
        logger.info("error with input fields");
        goodie=false;
        session.setAttribute("message", "invalid field input");
        session.setAttribute("url", "admin/testingCenterInformation.jsp");
        url="../error.jsp";
    }
    if(hour==null){
        logger.info("date not found in DB");
        goodie=false;
        session.setAttribute("message", "invalid field input");
        session.setAttribute("url", "admin/testingCenterInformation.jsp");
        url="../error.jsp";
    }
    if(goodie) {
        hour.setStartTime(StartTime);
        hour.setEndTime(EndTime);
        retriever.persist(hour);
        logger.info("TestingCenterHour of" + date + " has StartTime set to" + StartTime + " and EndTime set to" +
            EndTime);
    }
    response.sendRedirect(url);

%>