<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>HELP</title>
</head>
<body>
<h2>HELP PAGE LOADED</h2>
<%
    String name = (String) request.getAttribute("name");
    String rollNo = (String) request.getAttribute("rollNo");
%>
<p>Name is : ${name}</p>
<p>RollNo is : ${rollNo}</p>
<ul>
<c:forEach var="item" items="${marks}">
<li><c:out value="${item}"></c:out></li>
</c:forEach>
</ul>
</body>
</html>
