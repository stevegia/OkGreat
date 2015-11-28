<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="application.Instructor" %>
<%@ page import="application.Retriever" %><%


    SimpleDateFormat dateFormatter = new SimpleDateFormat("EEE MMM d HH:mm:ss z yyy");
    SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");

    String testname = request.getParameter("testname");
    String courseidentifier = request.getParameter("courseidentifier");
    String course = request.getParameter("course");
    String section = request.getParameter("section");
    String startTime= request.getParameter("starttime");
    String endTime = request.getParameter("endtime");
    String startDate = request.getParameter("startdate");
    String endDate = request.getParameter("enddate");
    String term = request.getParameter("term");
    String coursetoggle = request.getParameter("coursetog");
    String netId = request.getRemoteUser();
    String duration = request.getParameter("duration");
    Retriever retriever = Retriever.getInstance();
    Instructor instructor = new Instructor(retriever.getUser(request.getRemoteUser()));
   System.out.println(coursetoggle);

    if(coursetoggle!=null && coursetoggle.equals("on")){

        boolean possible = instructor.makeCourseRequest(testname,courseidentifier,section,startTime,endTime,startDate,endDate,term,course,request.getRemoteUser(),duration);
        if(possible){
            response.sendRedirect("createNewRequests.jsp");
        }else{
            response.sendRedirect("../error.jsp");
        }


    }else {


        int totalStudent = Integer.parseInt(request.getParameter("totalStudent"));
        String[] netid = new String[totalStudent];
        String[] firstname = new String[totalStudent];
        String[] lastname = new String[totalStudent];
        for(int i = 0; i< totalStudent; i++){
            netid[i] = request.getParameter("netid_"+i);
            firstname[i] = request.getParameter("firstname_" + i);
            lastname[i] = request.getParameter("lastname_" + i);


            boolean possible = instructor.makeAdhocRequest(testname, courseidentifier, section, startTime, endTime, startDate, endDate, term, course, request.getRemoteUser(), duration, totalStudent, netid, firstname, lastname);

            if(possible){
                response.sendRedirect("createNewRequests.jsp");
            }else{
                System.out.println(possible);
                response.sendRedirect("../error.jsp");
            }
        }
    }


%>

