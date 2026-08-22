<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="dashboard-card">
        <h2>Admin Overview</h2>
        <p>Manage appointments, staff, and system settings from here.</p>
        <div style="display: flex; gap: 20px;">
            <div style="flex: 1; background: #e3f2fd; padding: 20px; border-radius: 5px; text-align: center;">
                <h3>Total Appointments</h3>
                <p style="font-size: 24px; font-weight: bold;">15</p>
            </div>
            <div style="flex: 1; background: #e8f5e9; padding: 20px; border-radius: 5px; text-align: center;">
                <h3>Today's Income</h3>
                <p style="font-size: 24px; font-weight: bold;">LKR 25,000</p>
            </div>
        </div>
    </div>

    <div class="dashboard-card">
        <h3>Quick Actions</h3>
        <ul>
            <li><a href="register_appointment.jsp">Register New Appointment</a></li>
            <li><a href="manage_users.jsp">Manage Users (Add Doctor/Staff)</a></li>
            <li><a href="search_appointment.jsp">Search Appointment</a></li>
            <li><a href="help.jsp">System Help Guide</a></li>
        </ul>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
