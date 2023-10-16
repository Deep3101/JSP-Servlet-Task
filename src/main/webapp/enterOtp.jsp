<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
        integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <title>Enter OTP</title>
    <style>
        body {
            background-color: #0275d8;
        }

        .center-content {
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #fff;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0px 0px 10px 2px rgba(0, 0, 0, 0.4);
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

        .forgot {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            text-align: left;
        }

        .forgot h2 {
            color: #123955;
            font-size: 24px;
            margin-bottom: 10px;
            text-align:center;
        }

        .forgot p {
            color: #555;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .steps .step {
            display: flex;
            flex-direction: column;
            color: #333;
            font-size: 16px;
            margin-bottom: 5px;
            margin-left: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #555;
        }

        .form-group .form-control {
            border-radius: 5px;
            background-color: #f7f7f7;
            color: #333;
        }

        .form-group .form-control:focus {
            box-shadow: none;
            background-color: #e0e0e0;
        }

        .form-text {
            color: #777;
        }

        .btn-success {
            background-color: #4caf50;
            border: none;
            transition: background-color 0.3s;
        }

        .btn-success:hover {
            background-color: #45a045;
        }

        .btn-danger {
            background-color: #f44336;
            border: none;
            transition: background-color 0.3s;
        }

        .btn-danger:hover {
            background-color: #e23c2f;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container center-content">
        <div class="col-md-4 form-container">
            <div class="forgot">
                <h2>Enter your OTP</h2>
            </div>
            <form action="ValidateOtpServlet" method="POST">
            <% String message = (String) request.getAttribute("message"); %>
                    <% if (message != null) { %>
                        <div class="success-message"><%= message %></div>
                    <% } %>
                <div class="form-group">
                    <label for="otp">Enter OTP :</label>
                    <input class="form-control" type="text" name="otp" id="otp" required="">
                    <small class="form-text text-muted">Enter the OTP you received in your email.</small>
                </div>
                <button class="btn btn-success btn-block" type="submit">Reset Password</button>
                <button class="btn btn-danger btn-block" type="button" onclick="window.location.href='login.jsp'">Back to Login</button>
            </form>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
