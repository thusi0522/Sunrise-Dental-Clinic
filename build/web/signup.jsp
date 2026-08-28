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
        <div class="auth-header">
            <h2>Patient Registration</h2>
            <p style="font-size: 0.8rem; color: var(--text-muted);">Join the Sunrise Dental Community</p>
        </div>

        <% if(request.getParameter("error") != null) { %>
            <div class="error-msg" style="background: #ffebee; color: #c62828; padding: 10px; border-radius: 5px; margin-bottom: 15px; font-size: 0.85rem; text-align: center;">
                <% if("InvalidUsernameFormat".equals(request.getParameter("error"))) { %>
                    Username must end with <strong>@gmail.com</strong>
                <% } else { %>
                    Registration failed. Please try again.
                <% } %>
            </div>
        <% } %>

        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="register">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" required placeholder="e.g. John Doe">
            </div>
            <div class="form-group">
                <label>Username (Gmail Required for Patients)</label>
                <input type="text" name="username" required placeholder="username@gmail.com">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="••••••••">
            </div>
            <button type="submit" style="width: 100%;">Create Secure Account</button>
        </form>
        <p style="text-align: center; margin-top: 20px; font-size: 0.9rem;">
            Already have an account? <a href="login.jsp" style="color: var(--primary); font-weight: 500;">Login here</a>
        </p>
    </div>

</body>
</html>
