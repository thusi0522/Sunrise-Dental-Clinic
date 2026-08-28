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
        <div class="auth-header">
            <h2>Welcome Back</h2>
            <p style="font-size: 0.8rem; color: var(--text-muted);">Access your Sunrise Dental account</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-msg" style="background: #ffebee; color: #c62828; padding: 10px; border-radius: 5px; margin-bottom: 15px; font-size: 0.85rem; text-align: center;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label>Username / Gmail</label>
                <input type="text" name="username" required placeholder="e.g. admin or user@gmail.com">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="••••••••">
            </div>
            <button type="submit" style="width: 100%;">Sign In</button>
        </form>
        <p style="text-align: center; margin-top: 20px; font-size: 0.9rem;">
            New Patient? <a href="signup.jsp" style="color: var(--primary); font-weight: 500;">Register here</a>
        </p>
    </div>

</body>
</html>
