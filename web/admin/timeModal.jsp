<%@ page import="application.Retriever" %>
<%--
  Created by IntelliJ IDEA.
  User: Gartusk
  Date: 11/22/2015
  Time: 12:11 AM
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Retriever retriever = Retriever.getInstance();
    String testingCenterId = (String) request.getParameter("testingCenterId");
    String openDate = (String) request.getParameter("openDate");
    System.out.println(testingCenterId);

    String dateInfo = retriever.getTestingCenterHour(openDate);


%>
<html>
<head>
    <title>Here</title>
</head>

<div>Start:</div>
<div id="startTime"></div>
<div>End:</div>
<div id="endTime"></div>
<div style="margin-top: 20px"></div>

<form NAME="form1" action="editTestingCenterHour.jsp" method="post">
    <INPUT TYPE="HIDDEN" NAME="date">
    Start Time:<input name="starttime" type="text" class="form-control" placeholder=""
                      value="Start Time" required>
    End Time:<input name="endtime" type="text" class="form-control" placeholder=""
                    value="End Time" required>
    <input type="submit" value="Submit"/>
</form>

<body>

</body>
</html>
<script>


    dateInfoPersistent = loadResults('<%=dateInfo%>');

    function loadResults(dateInfo) {


        var dateInfo = JSON.parse(decodeURI(dateInfo));


        $("#startTime").html(dateInfo.start);
        $("#endTime").html(dateInfo.end);

        document.form1.date.value = dateInfo.date;
        document.form1.starttime.value = dateInfo.startTime;
        document.form1.endtime.value = dateInfo.endTime;

        console.log(dateInfo);

        return dateInfo;
    }


    function submitHours() {


        form1.submit();

    }


</script>