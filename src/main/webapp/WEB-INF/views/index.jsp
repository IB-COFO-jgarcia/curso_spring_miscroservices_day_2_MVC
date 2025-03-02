<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
<h2>INDEX PAGE LOADED</h2>
<h1>Called by Home Controller</h1>
<h1> url / home</h1>

<%
    String name = (String) request.getAttribute("name");
    String desig = (String) request.getAttribute("Designation");

%>

<p>Name is : <%=name%></p>
<p>Designation is : <%=desig%></p>
</body>
</html>
