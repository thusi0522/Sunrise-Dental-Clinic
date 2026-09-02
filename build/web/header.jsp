<%@ page import="com.sunrisedental.model.User" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- Fonts & Icons -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary-color: #4318ff;
        --text-dark: #1b2559;
        --text-gray: #707ebe;
        --bg-light: #f4f7fe;
    }

    body {
        font-family: 'Inter', sans-serif;
        margin: 0;
        background-color: var(--bg-light);
    }

    .main-navbar {
        background-color: #ffffff;
        box-shadow: 0 4px 20px rgba(112, 144, 176, 0.08);
        padding: 12px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .brand-logo {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
    }

    .brand-logo i {
        font-size: 26px;
        color: var(--primary-color);
        background: #e9f3ff;
        padding: 10px;
        border-radius: 12px;
    }

    .brand-logo h1 {
        font-size: 20px;
        font-weight: 700;
        color: var(--text-dark);
        margin: 0;
    }

    .nav-container {
        display: flex;
        align-items: center;
        gap: 30px;
    }

    .nav-menu {
        display: flex;
        list-style: none;
        gap: 15px;
        margin: 0;
        padding: 0;
        align-items: center;
    }

    .nav-menu a {
        text-decoration: none;
        color: var(--text-gray);
        font-weight: 500;
        font-size: 14px;
        padding: 8px 14px;
        border-radius: 8px;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .nav-menu a:hover {
        color: var(--primary-color);
        background-color: #e9f3ff;
    }

    .user-profile {
        display: flex;
        align-items: center;
        gap: 10px;
        background-color: #f4f7fe;
        padding: 6px 14px;
        border-radius: 20px;
        border: 1px solid #e0e5f2;
    }

    .user-profile i {
        color: var(--primary-color);
    }

    .user-info {
        font-size: 13px;
        font-weight: 600;
        color: var(--text-dark);
    }

    .role-badge {
        font-size: 11px;
        background: var(--primary-color);
        color: white;
        padding: 2px 8px;
        border-radius: 10px;
        margin-left: 4px;
    }

    .logout-link {
        color: #ff3b30 !important;
        font-weight: 600 !important;
    }

    .logout-link:hover {
        background-color: #ffe5e5 !important;
    }
</style>

<header class="main-navbar">
    <a href="#" class="brand-logo">
        <i class="fa-solid fa-tooth"></i>
        <h1 style="color: white;"> Sunrise Dental Clinic </h1>
    </a>

    <div class="nav-container">
        <nav>
            <ul class="nav-menu">
                <% if ("ADMIN".equals(user.getRole())) { %>
                    <li><a href="admin_dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a></li>
                    <li><a href="register_appointment.jsp"><i class="fa-solid fa-calendar-plus"></i> New Appointment</a></li>
                    <li><a href="reports.jsp"><i class="fa-solid fa-file-invoice-dollar"></i> Reports</a></li>
                <% } %>
                
                <% if ("DOCTOR".equals(user.getRole())) { %>
                    <li><a href="doctor_dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a></li>
                    <li><a href="search_appointment.jsp"><i class="fa-solid fa-folder-open"></i> View Records</a></li>
                <% } %>
                
                <% if ("CASHIER".equals(user.getRole())) { %>
                    <li><a href="cashier_dashboard.jsp"><i class="fa-solid fa-chart-pie"></i> Dashboard</a></li>
                    <li><a href="register_appointment.jsp"><i class="fa-solid fa-calendar-plus"></i> New Appointment</a></li>
                    <li><a href="billing.jsp"><i class="fa-solid fa-receipt"></i> Billing</a></li>
                <% } %>
                
                <% if ("PATIENT".equals(user.getRole())) { %>
                    <li><a href="patient_dashboard.jsp"><i class="fa-solid fa-calendar-check"></i> My Appointments</a></li>
                <% } %>
                
                <li><a href="help.jsp"><i class="fa-solid fa-circle-question"></i> Help</a></li>
                <li><a href="logout.jsp" class="logout-link"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
            </ul>
        </nav>

        <div class="user-profile">
            <i class="fa-solid fa-circle-user"></i>
            <span class="user-info">
                <%= user.getFullName() %> 
                <span class="role-badge"><%= user.getRole() %></span>
            </span>
        </div>
    </div>
</header>

<div class="container" style="padding: 20px 30px;">