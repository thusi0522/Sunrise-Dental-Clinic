<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="dashboard-card">
        <h2>Doctor Dashboard</h2>
        <h3>Today's Schedule</h3>
        <table>
            <tr>
                <th>App No</th>
                <th>Patient Name</th>
                <th>Treatment</th>
                <th>Time</th>
                <th>Status</th>
            </tr>
            <%
                AppointmentDAO dao = new AppointmentDAO();
                List<Appointment> list = dao.getAllAppointments();
                for(Appointment app : list) {
            %>
            <tr>
                <td><%= app.getAppointmentNumber() %></td>
                <td><%= app.getPatientName() %></td>
                <td><%= app.getTreatmentType() %></td>
                <td><%= app.getAppointmentDate() %></td>
                <td><%= app.getStatus() %></td>
            </tr>
            <% } %>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
