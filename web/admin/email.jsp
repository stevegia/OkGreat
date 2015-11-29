<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% String result;
    String to = "kudale.ashish1992@gmail.com";
    String from = "kudale.ashish1992@yahoo.com";
    String host = "localhost";
    Properties properties = System.getProperties();
    properties.setProperty("mail.smtp.host", host);
    properties.setProperty("mail.user", "Username");
    properties.setProperty("mail.password", "Paasword");
    //String to = request.getParameter("to");
    //String from = request.getParameter("from");
    String subject = request.getParameter("subject");
    String messageText = request.getParameter("body");
    Session mailSession = Session.getDefaultInstance(properties);
    try{
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        BodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setText("This is message body");
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        messageBodyPart = new MimeBodyPart();
        String filename = "file.txt";
        DataSource source = new FileDataSource(filename);
        messageBodyPart.setDataHandler(new DataHandler(source));
        messageBodyPart.setFileName(filename);
        multipart.addBodyPart(messageBodyPart);
        message.setContent(multipart );
        Transport.send(message);
        String title = "Send Email";
        result = "Sent message successfully....";
    }
    catch (MessagingException mex) {
        mex.printStackTrace();
        result = "Error: unable to send message....";
    }
%>
<html>
<head>
    <title>Send email</title>
</head>
<body>
<center> <h1>Send Attachement Email using JSP</h1> </center>
<p align="center">
    <% out.println("Result: " + result + "\n"); %>
</p>
</body>
</html>