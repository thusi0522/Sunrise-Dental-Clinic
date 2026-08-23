<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment, com.sunrisedental.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
        // The variable 'user' is already declared in header.jsp
        if (!"PATIENT".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="dashboard-card">
        <h2>Welcome, <%= user.getFullName() %></h2>
        <p>Your Health Records & Appointments</p>

        <table>
            <tr>
                <th>App No</th>
                <th>Doctor</th>
                <th>Treatment</th>
                <th>Date</th>
                <th>Fee (LKR)</th>
                <th>Status</th>
            </tr>
            <%
                AppointmentDAO dao = new AppointmentDAO();
                List<Appointment> list = dao.getAppointmentsByPatient(user.getFullName());
                for(Appointment app : list) {
            %>
            <tr>
                <td><%= app.getAppointmentNumber() %></td>
                <td><%= app.getDentistName() %></td>
                <td><%= app.getTreatmentType() %></td>
                <td><%= app.getAppointmentDate() %></td>
                <td><%= app.getTotalBill() %></td>
                <td><%= app.getStatus() %></td>
            </tr>
            <% } %>
        </table>

        <div style="margin-top: 20px;">
            <a href="register_appointment.jsp" class="btn">Book New Appointment</a>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>

