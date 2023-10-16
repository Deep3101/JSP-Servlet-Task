<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.webapp.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous" />
    <title>Admin Dashboard</title>
    <style>
        body {
            background-color: #0275d8;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
        }

        .content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center horizontally */
            justify-content: flex-start; /* Align content at the top */
            padding: 20px; /* Add some padding */
        }

        .admin-table-container {
            width: 100%;
            max-width: 100%; /* Make the table container responsive */
            background-color:white;
            overflow-x: auto; /* Add horizontal scroll if necessary */
            max-height: 70vh; /* Limit the maximum height with vertical scroll */
        }

        .admin-table {
            width: 100%;
        }

        h1 {
            margin-top:50px;
            text-align: center;
            font-family: New Century Schoolbook, TeX Gyre Schola, serif;
            font-weight:bolder;
            text-shadow: 4px 4px 8px lightgrey;

        }


        .add-user-button {
            margin-bottom: 20px;
        }
    </style>
</head>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expires", 0); %>
<%
    String role = (String) session.getAttribute("role");
        if ("USER".equalsIgnoreCase(role)) {
            response.sendRedirect("UserDashboardServlet");
        }
%>
<body>
<jsp:include page="header.jsp" />
<div class="content">
    <h1>Welcome to Admin Dashboard</h1>
    <a href="register.jsp" class="btn btn-success add-user-button">Add User</a>
    <div class="admin-table-container">
        <table border="1" class="table table-striped admin-table">
            <thead class="table table-secondary">
            <tr>
                <th>UserId</th>
                <th>Username</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Gender</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${userList}" var="user">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.userName}</td>
                    <td>${user.firstName}</td>
                    <td>${user.lastName}</td>
                    <td>${user.email}</td>
                    <td>${user.contact}</td>
                    <td>${user.gender}</td>
                    <td>${user.role}</td>
                    <td>
                        <a href="ViewServlet?userId=${user.userId}"  class="btn btn-primary">View</a>
                        <a href="DeleteUserServlet?userId=${user.userId}" class="btn btn-danger py-1 remove-user-btn">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
<script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha384-pzjw8f+uaBQ9k0z4zJdB+q5ezfahj0q7K5qOJccXnCqra5g1asU9Bd06u6z5S5Hp"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-d7I6txDpddRWz7TI7">
</html>
