<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patient Signup - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: linear-gradient(135deg, var(--primary-dark), var(--primary)); display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; padding: 20px 0;">
    <div class="signup-box" style="margin: 0; border-top: none; max-width: 450px; background: #fff; padding: 40px; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
        <div class="auth-header" style="text-align: center; margin-bottom: 25px;">
            <i class="fa-solid fa-user-plus" style="font-size: 3rem; color: var(--primary); margin-bottom: 1rem;"></i>
            <h2 style="color: var(--primary); margin: 0;">Create Account</h2>
            <p style="font-size: 0.8rem; color: var(--text-muted);">Join the Sunrise Dental community</p>
        </div>

        <% if(request.getParameter("error") != null) { %>
            <div class="error-msg" style="background: #ffebee; color: #c62828; padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 0.85rem; border: 1px solid #ffcdd2; text-align: center;">
                <i class="fa-solid fa-circle-exclamation"></i>
                <% if("InvalidUsernameFormat".equals(request.getParameter("error"))) { %>
                    Username must end with <strong>@gmail.com</strong>
                <% } else if("PasswordTooShort".equals(request.getParameter("error"))) { %>
                    Password must be at least <strong>6 characters</strong> long.
                <% } else if("UsernameExists".equals(request.getParameter("error"))) { %>
                    This username is already taken.
                <% } else { %>
                    Registration failed. Please try again.
                <% } %>
            </div>
        <% } %>

        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="register">
            <div class="form-group" style="margin-bottom: 15px;">
                <label style="display: block; margin-bottom: 5px; font-weight: 500;">Full Name</label>
                <input type="text" name="fullName" required placeholder="e.g. John Doe" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px;">
            </div>
            <div class="form-group" style="margin-bottom: 15px;">
                <label style="display: block; margin-bottom: 5px; font-weight: 500;">Username (Gmail Required)</label>
                <input type="text" name="username" required placeholder="username@gmail.com" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px;">
            </div>
            <div class="form-group" style="margin-bottom: 15px;">
                <label style="display: block; margin-bottom: 5px; font-weight: 500;">Password (Min. 6 chars)</label>
                <input type="password" name="password" required placeholder="••••••••" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px;">
            </div>
            <button type="submit" style="width: 100%; background: var(--primary); color: white; border: none; padding: 12px; border-radius: 6px; font-weight: 600; cursor: pointer; transition: 0.3s;">Create Secure Account</button>
        </form>
        <p style="text-align: center; margin-top: 20px; font-size: 0.9rem;">
            Already have an account? <a href="login.jsp" style="color: var(--primary); font-weight: 600; text-decoration: none;">Login here</a>
        </p>
    </div>
</body>
</html>
