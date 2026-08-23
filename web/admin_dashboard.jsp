<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        AppointmentDAO appDAO = new AppointmentDAO();
        double todayIncome = appDAO.getTodayIncome();
        int totalApp = appDAO.getAllAppointments().size();
    %>

    <div class="dashboard-card">
        <h2>Admin Overview</h2>
        <p>Manage appointments, staff, and system settings from here.</p>
        <div style="display: flex; gap: 20px;">
            <div style="flex: 1; background: #e3f2fd; padding: 20px; border-radius: 5px; text-align: center;">
                <h3>Total Appointments</h3>
                <p style="font-size: 24px; font-weight: bold;"><%= totalApp %></p>
            </div>
            <div style="flex: 1; background: #e8f5e9; padding: 20px; border-radius: 5px; text-align: center;">
                <h3>Today's Income</h3>
                <p style="font-size: 24px; font-weight: bold;">LKR <%= String.format("%.2f", todayIncome) %></p>
            </div>
        </div>
    </div>

    <div class="dashboard-card">
        <h3>Income Analytics</h3>
        <canvas id="incomeChart" width="400" height="150"></canvas>
    </div>

    <script>
        const ctx = document.getElementById('incomeChart').getContext('2d');
        const incomeChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'Revenue (LKR)',
                    data: [12000, 19000, 3000, 5000, 20000, 30000, <%= todayIncome %>],
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            }
        });
    </script>

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

