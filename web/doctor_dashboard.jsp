<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment, com.sunrisedental.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
        // The variable 'user' is already declared in header.jsp
        if (!"DOCTOR".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="dashboard-card">
        <h2>Welcome, Dr. <%= user.getFullName() %></h2>
        <h3>Your Appointments</h3>
        <table>
            <tr>
                <th>App No</th>
                <th>Patient</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                AppointmentDAO dao = new AppointmentDAO();
                List<Appointment> list = dao.getAppointmentsByDoctor(user.getFullName());
                for(Appointment app : list) {
            %>
            <tr>
                <td><%= app.getAppointmentNumber() %></td>
                <td><%= app.getPatientName() %></td>
                <td><%= app.getAppointmentDate() %></td>
                <td><%= app.getAppointmentTime() %></td>
                <td><span class="status-badge <%= app.getStatus().toLowerCase() %>"><%= app.getStatus() %></span></td>
                <td>
                    <% if (app.getStatus() != null && app.getStatus().trim().equalsIgnoreCase("PENDING")) { %>
                        <a href="update_treatment.jsp?appNumber=<%= app.getAppointmentNumber() %>" class="btn btn-small" style="background-color: var(--success-color); color: white; text-decoration: none; padding: 5px 10px; border-radius: 4px;">Treat Patient</a>
                    <% } else { %>
                        <span class="status-badge completed"><%= app.getStatus() %></span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>

