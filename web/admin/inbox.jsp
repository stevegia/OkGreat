<% String title = "Inbox";%>
<%@include file="adminHeader.jsp" %>
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

            Administrator admin = new Administrator(retriever.getUser(request.getRemoteUser()));
            List<Message> messages = retriever.getMessagesForUser(admin.getNetId());

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