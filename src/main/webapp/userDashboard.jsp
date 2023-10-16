<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.webapp.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous" />
    <title>User Dashboard</title>
    <style>
        body {
            background-color: #0275d8;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center horizontally */
            justify-content: center; /* Center vertically */
        }

        .user-table {
            width: 100%;
            max-width: 100%; /* Make the table responsive */
            overflow-x: auto;
            background-color:white;
        }

        h1 {
            text-align: center;
            font-family: New Century Schoolbook, TeX Gyre Schola, serif;
            font-weight:bolder;
            text-shadow: 4px 4px 8px lightgrey;
        }

        .btn-container{
            margin:auto;
            text-align:center;
            height:20vh;
        }
    </style>
</head>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expires", 0); %>
<%
    String role = (String) session.getAttribute("role");
    if ("ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect("AdminDashboardServlet");
    }
%>
<body>
<jsp:include page="header.jsp" />
<!-- Add this code inside your userDashboard.jsp file -->
<div class="content">
    <h1>Welcome <%= session.getAttribute("username") %></h1>
    <table border="1" class="table table-striped user-table">
        <thead class="table table-secondary">
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Contact</th>
            <th>Gender</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${userList}" var="user">
           <tr>
               <td>${user.firstName}</td>
               <td>${user.lastName}</td>
               <td>${user.email}</td>
               <td>${user.contact}</td>
               <td>${user.gender}</td>
               <td><a href="userDetails.jsp" class="btn btn-secondary">View Details</td>
           </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<jsp:include page="footer.jsp" />
</body>
 <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha384-pzjw8f+uaBQ9k0z4zJdB+q5ezfahj0q7K5qOJccXnCqra5g1asU9Bd06u6z5S5Hp"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-d7I6txDpddRWz7TI7
</html>
