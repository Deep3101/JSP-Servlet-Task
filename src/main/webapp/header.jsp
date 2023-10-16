<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.webapp.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-dark fixed-top">
    <img src="https://www.inexture.com/wp-content/uploads/2023/06/inx-white-logos.png" alt="Inexture Logo" style="max-width: 200px;height: auto !important;">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link text-white" href="welcome.jsp">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="about.jsp">About Us</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="contact.jsp">Contact Us</a>
            </li>
            <c:choose>
                <c:when test="${sessionScope.loggedIn}">
                    <li class="nav-item">
                      <form action="LogoutServlet" method="get">
                         <button type="submit" class="btn btn-warning">Logout</button>
                      </form>
                    </li>
                </c:when>
            </c:choose>
        </ul>
    </div>
</nav>
</body>
</html>
