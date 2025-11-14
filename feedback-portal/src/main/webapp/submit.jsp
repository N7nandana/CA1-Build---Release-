<%@ page import="com.xebia.feedback.feedback" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submitting...</title>
</head>
<body>
<%
// Read parameters
String course = request.getParameter("course");
String message = request.getParameter("message");


boolean added = feedback.addFeedback(course, message);
%>


<% if (added) { %>
<p>Feedback submitted successfully.</p>
<p><a href="view.jsp">View all feedback</a> | <a href="index.jsp">Submit another</a></p>
<% } else { %>
<p style="color:red">Feedback was empty and was not added. Please provide a non-empty message.</p>
<p><a href="index.jsp">Back to submit form</a></p>
<% } %>


</body>
</html>