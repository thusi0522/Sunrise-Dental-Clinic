<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sunrise Dental Clinic - Login</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .login-box { border-top: none; }
    </style>
</head>
<body>
    <div class="login-box">
        <div class="auth-header">
            <i class="fa-solid fa-tooth" style="font-size: 3rem; color: var(--primary); margin-bottom: 1rem;"></i>
            <h2>Welcome Back</h2>
            <p style="font-size: 0.8rem; color: var(--text-muted);">Access your Sunrise Dental account</p>
        </div>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-msg" style="background: #ffebee; color: #c62828; padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 0.85rem; border: 1px solid #ffcdd2; text-align: center;">
                <i class="fa-solid fa-circle-exclamation"></i>
                <% if("InvalidCredentials".equals(request.getParameter("error"))) { %>
                    Invalid username or password.
                <% } else { %>
                    <%= request.getParameter("error") %>
                <% } %>
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
            New Patient? <a href="signup.jsp" style="color: var(--primary); font-weight: 600; text-decoration: none;">Register here</a>
        </p>
    </div>
</body>
</html>
