<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Signup - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .signup-box {
            width: 400px;
            margin: 50px auto;
            padding: 40px;
            background: #fff;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        .signup-box h2 { text-align: center; color: #333; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="signup-box">
        <h2>Patient Registration</h2>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="register">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" required>
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" style="width: 100%;">Create Account</button>
        </form>
        <p style="text-align: center; margin-top: 15px;">
            Already have an account? <a href="login.jsp">Login here</a>
        </p>
    </div>
</body>
</html>
