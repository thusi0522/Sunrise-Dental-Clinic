<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Appointment - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="dashboard-card">
        <h2>Search Appointment Record</h2>
        <form action="search_appointment.jsp" method="get">
            <div class="form-group">
                <input type="text" name="appNumber" placeholder="Enter Appointment Number" required>
            </div>
            <button type="submit">Search</button>
        </form>
    </div>

    <%
        String appNumber = request.getParameter("appNumber");
        if (appNumber != null) {
            AppointmentDAO dao = new AppointmentDAO();
            Appointment app = dao.getAppointment(appNumber);
            if (app != null) {
    %>
    <div class="dashboard-card">
        <h3>Patient Record: <%= app.getAppointmentNumber() %></h3>
        <table style="max-width: 500px;">
            <tr><td><strong>Patient Name:</strong></td><td><%= app.getPatientName() %></td></tr>
            <tr><td><strong>Address:</strong></td><td><%= app.getAddress() %></td></tr>
            <tr><td><strong>Contact:</strong></td><td><%= app.getContactNumber() %></td></tr>
            <tr><td><strong>Dentist:</strong></td><td><%= app.getDentistName() %></td></tr>
            <tr><td><strong>Treatment:</strong></td><td><%= app.getTreatmentType() %></td></tr>
            <tr><td><strong>Date:</strong></td><td><%= app.getAppointmentDate() %></td></tr>
            <tr><td><strong>Time:</strong></td><td><%= app.getAppointmentTime() %></td></tr>
            <tr><td><strong>Status:</strong></td><td><%= app.getStatus() %></td></tr>
        </table>
    </div>
    <%
            } else {
    %>
        <p class="error" style="text-align: center;">No record found for Appointment Number: <%= appNumber %></p>
    <%
            }
        }
    %>

    <%@ include file="footer.jsp" %>
</body>
</html>
