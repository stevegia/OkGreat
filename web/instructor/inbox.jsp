<%@ page import="application.Instructor" %>
<% String title = "Inbox";%>
<%@include file="instructorHeader.jsp" %>
<h2>Your Messages</h2>

<div class="container">

  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Date</th>
      <th>Subject</th>
      <th>Content</th>
    </tr>
    </thead>
    <tbody>
    <%
      logger.info("Now at the inbox.jsp file");
      Instructor instructor = new Instructor(retriever.getUser(request.getRemoteUser()));

      List<Message> messages = retriever.getMessagesForUser(instructor.getNetId());

      if (messages != null) {
        for (Message message : messages) {
    %>
    <tr>
      <td><%= message.getDateMade().toString() %>
      </td>
      <td><%= message.getMessageSubject() %>
      </td>
      <td><%= message.getContent() %>
      </td>

    </tr>
    <%
        }
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>