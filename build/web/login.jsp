<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sunrise Dental Clinic - Login</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .login-box {
            width: 350px;
            margin: 100px auto;
            padding: 40px;
            background: #fff;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        .login-box h2 { text-align: center; color: #333; margin-bottom: 30px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Sunrise Dental Login</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <form action="login" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" style="width: 100%;">Login</button>
        </form>
        <p style="text-align: center; margin-top: 15px;">
            New Patient? <a href="signup.jsp">Register here</a>
        </p>
    </div>
</body>
</html>
