<%@ page import="com.xebia.feedback.FeedbackStore" %>
<%@ page import="com.xebia.feedback.FeedbackStore.Feedback" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Feedback</title>
<style>
body { font-family: Arial, Helvetica, sans-serif; margin: 40px; }
.entry { border-bottom: 1px solid #ddd; padding: 8px 0; }
.meta { color: #666; font-size: 0.9em; }
</style>
</head>
<body>
<h1>All Feedback</h1>
<p><a href="index.jsp">Submit feedback</a></p>


<%
java.util.List<Feedback> list = FeedbackStore.getAllFeedbacks();
int count = list.size();
%>
<p>Total feedbacks: <strong><%=count%></strong></p>


<% if (list.isEmpty()) { %>
<p>No feedback submitted yet.</p>
<% } else {
for (Feedback f : list) { %>
<div class="entry">
<div class="meta">Course: <%= (f.getCourse().isEmpty()?"(not specified)":f.getCourse()) %> — <%= f.getTimestamp() %></div>
<div class="message"><%= f.getMessage() %></div>
</div>
<% }
} %>


</body>
</html>