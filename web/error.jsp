<html>
<head>
<title>Error</title>
</head>
<body>
	<div>Error</div>

	<!-- <button onclick="<%=session.getAttribute("url")%> >Return</button> -->
		<% if((String) session.getAttribute("message")!=null) {
			%><%=(String) session.getAttribute("message")%>
		<%
		}
		%>
		<% if((String) session.getAttribute("url")!=null) {
		%>  <a href="<%=(String) session.getAttribute("url")%>">
				<button>Return</button>
			</a>
		<%
			} else{
		%>	<button>Return</button>
		<% }
		%>
</body>
</html>
