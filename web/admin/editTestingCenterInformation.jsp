<% String title = "Testing Center Information";%>
<%@include file="adminHeader.html"%>
<%  logger.info("at editTestingCenterInformation.jsp");
    int numberOfSeats=0;
    int numberOfSetAsideSeats=0;
    int gapTime=0;
    int reminderInterval=0;
    boolean goodie=true;
    String url = "testingCenterInformation.jsp";
    try{
        numberOfSeats=Integer.parseInt(request.getParameter("numberofseats"));
        numberOfSetAsideSeats=Integer.parseInt(request.getParameter("numberofsetasideseats"));
        gapTime=Integer.parseInt(request.getParameter("gaptime"));
        reminderInterval=Integer.parseInt(request.getParameter("reminderinterval"));

    }catch(NumberFormatException e){
        logger.info("error parsing input fields into int");
        goodie=false;
        request.setAttribute("message", "invalid field input");
        request.setAttribute("url", "admin/testingCenterInformation.jsp");
        url="../error.jsp";
    }
    if(goodie) {
        TestingCenter testingCenter = retriever.getTestingCenter();
        testingCenter.setNumberOfSeats(numberOfSeats);
        testingCenter.setNumberOfSetAsideSeats(numberOfSetAsideSeats);
        testingCenter.setGapTime(gapTime);
        testingCenter.setReminderInterval(reminderInterval);
        logger.info("numberofseats set to" + numberOfSeats + "/nnumberofsetasideseats set to" + numberOfSetAsideSeats + "/ngaptime set to" +
                gapTime + "/nremainderinterval set to" + reminderInterval);
    }
    response.sendRedirect(url);

%>