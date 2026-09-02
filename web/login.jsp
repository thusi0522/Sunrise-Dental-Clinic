<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sunrise Dental Clinic - Login</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Unified Split-Screen Card Container */
        .auth-container {
            display: flex;
            width: 100%;
            max-width: 850px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        /* Left Side: Branding, Vision & Mission */
        .brand-side {
            flex: 1;
            background: linear-gradient(135deg, #0288d1 0%, #005b9f 100%);
            color: #ffffff;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .brand-side h2 {
            font-size: 1.6rem;
            margin-bottom: 25px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.2);
            padding-bottom: 10px;
        }

        .info-block {
            margin-bottom: 25px;
        }

        .info-block:last-child {
            margin-bottom: 0;
        }

        .info-block h3 {
            font-size: 1rem;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #e0f7fa;
        }

        .info-block p {
            font-size: 0.88rem;
            line-height: 1.5;
            opacity: 0.9;
        }

        /* Right Side: Login Form */
        .form-side {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .auth-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .auth-header h2 {
            color: #333333;
            font-size: 1.6rem;
            margin-bottom: 6px;
        }

        .auth-header p {
            font-size: 0.85rem;
            color: #666666;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 0.85rem;
            color: #444444;
            margin-bottom: 6px;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #dcdcdc;
            border-radius: 6px;
            font-size: 0.9rem;
            background-color: #f9fafb;
            transition: all 0.2s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #0288d1;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(2, 136, 209, 0.1);
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #0288d1;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .btn-submit:hover {
            background-color: #0077b5;
        }

        .error-msg {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 0.85rem;
            text-align: center;
        }

        @media (max-width: 768px) {
            .auth-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

    <div class="auth-container">
        
        <!-- Left Side: Vision & Mission -->
        <div class="brand-side">
            <h2>Sunrise Dental</h2>
            
            <div class="info-block">
                <h3>Our Vision</h3>
                <p>To be the most trusted dental clinic, providing healthy and confident smiles for our entire community.</p>
            </div>

            <div class="info-block">
                <h3>Our Mission</h3>
                <p>To deliver compassionate, high-quality dental care using modern technology in a comfortable and pain-free environment.</p>
            </div>
        </div>

        <!-- Right Side: Login Form -->
        <div class="form-side">
            <div class="auth-header">
                <h2>Welcome Back</h2>
                <p>Access your Sunrise Dental account</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg">
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
                <button type="submit" class="btn-submit">Sign In</button>
            </form>

            <p style="text-align: center; margin-top: 20px; font-size: 0.85rem; color: #666;">
                New Patient? <a href="signup.jsp" style="color: #0288d1; font-weight: 600; text-decoration: none;">Register here</a>
            </p>
        </div>

    </div>

</body>
</html>