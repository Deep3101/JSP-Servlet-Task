<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
        integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <title>Login</title>
    <style>
        body {
            background-color: #0275d8;
        }

        .center-content {
            text-align: left;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 92.5vh;
        }

        .form-container {
            background-color: #fff;
            border-radius: 5px;
            padding: 30px;
            box-shadow: 0px 0px 10px 2px rgba(0, 0, 0, 0.4);
        }
        .form-group{
            text-align:left;
        }

        .forgot-password {
            margin-top: 10px;
        }


        .error-message {
            color: red;
        }

        .success-message {
            color: green;
        }


        .error-box {
            border: 2px solid red;
            box-shadow: 0.5px 0.5px 1px 0.5px red;
        }

        .success-box {
            border: 2px solid green;
            box-shadow: 0.5px 0.5px 1px 0.5px green;
        }
    </style>
</head>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expires", 0); %>
<%
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    String role = (String) session.getAttribute("role");

    if (loggedInUser != null) {
        // User is already logged in, redirect to the appropriate dashboard
        if ("ADMIN".equals(role)) {
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.sendRedirect("userDashboard.jsp");
        }
    }
%>
<body>
<jsp:include page="header.jsp" />
    <div class="container center-content">
        <div class="col-md-4 form-container">
            <h3>Welcome to Login Page</h3>
            <form action="loginServlet" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username">Username :</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
    <p id="username-error" class="error-message">${usernameError}</p>
                </div>
                <div class="form-group">
                    <label for="password">Password :</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                    <p id="password-error" class="error-message">${passwordError}</p>
                </div>
                <button type="submit" class="btn btn-primary btn-block" style="box-shadow: 0px 0px 5px 2px rgba(0, 0, 0, 0.3)">Login</button>
            </form>
            <div class="forgot-password">
                <a href="forgotPassword.jsp">Forgot Password?</a>
            </div>
            <div>Not Registered? <a href="register.jsp">Click Here</a></div>
        </div>
    </div>
<jsp:include page="footer.jsp" />
    <script>
        function validateForm() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;
            var usernameRegex = /^[a-zA-Z0-9]{3,10}$/;
            var passwordRegex = /^[a-zA-Z0-9!@#$%^&*()_+{}|:"<>?~]{6,20}$/;


            if (!usernameRegex.test(username)) {
                document.getElementById("username-error").innerHTML = "Invalid username";
                document.getElementById("username").classList.add("error-box");
                return false;
            } else {
                document.getElementById("username-error").innerHTML = "";
                document.getElementById("username").classList.remove("error-box");
            }


            if (!passwordRegex.test(password)) {
                document.getElementById("password-error").innerHTML = "Invalid password";
                document.getElementById("password").classList.add("error-box");
                return false;
            } else {
                document.getElementById("password-error").innerHTML = "";
                document.getElementById("password").classList.remove("error-box");
            }

            return true;
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha384-pzjw8f+uaBQ9k0z4zJdB+q5ezfahj0q7K5qOJccXnCqra5g1asU9Bd06u6z5S5Hp"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-d7I6txDpddRWz7TI7p/kICm4nR39izJbdC5f2oxm4T5kaQ5A5dVd7/TJgsB6jS/7"
        crossorigin="anonymous"></script>
</body>
</html>
