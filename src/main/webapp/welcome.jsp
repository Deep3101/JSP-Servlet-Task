<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.webapp.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <style>
        body {
            background-color: #0275d8;
            color: white;
        }

        .center-content {
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 92.5vh;
        }

        .cool-jumbotron {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 100px 20px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 2px rgba(0, 0, 0, 0.4);
        }

        .cool-jumbotron h1 {
            font-size: 4rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .cool-jumbotron .lead {
            font-size: 1.5rem;
            margin-top: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .btn-container {
            margin-top: 20px;
        }

        .btn {
            margin: 10px;
        }
    </style>
</head>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expires", 0); %>
<body>
    <jsp:include page="header.jsp" />
    <div class="container center-content">
        <div class="jumbotron cool-jumbotron">
            <h1 class="display-4">Welcome to INEXTURE Solutions LLP</h1>
            <p class="lead">Get started by registering or logging in.</p>
            <div class="btn-container">
                <c:choose>
                    <c:when test="${sessionScope.loggedIn == true}">
                        <!-- User is logged in, don't display the Login button -->
                        <a href="register.jsp" class="btn btn-primary btn-lg">Register</a>
                    </c:when>
                    <c:otherwise>
                        <a href="register.jsp" class="btn btn-primary btn-lg">Register</a>
                        <a href="login.jsp" class="btn btn-success btn-lg">Login</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
    <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha384-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-9aIt2nRpC12Uk9gqF8v5nHf5g5n0wwr45eC7Jk5G4C4z5P4f5uKbpz5UF5F5e5uKfs5r"
        crossorigin="anonymous"></script>
</body>
</html>
