<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cashier Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
        if (!"CASHIER".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="dashboard-card">
        <h2>Cashier Dashboard</h2>
        <h3>Pending Payments (Ready for Billing)</h3>
        <table>
            <tr>
                <th>App No</th>
                <th>Patient</th>
                <th>Treatment</th>
                <th>Total Bill (LKR)</th>
                <th>Action</th>
            </tr>
            <%
                AppointmentDAO dao = new AppointmentDAO();
                List<Appointment> list = dao.getPendingPayments();
                if (list.isEmpty()) {
            %>
                <tr><td colspan="5" style="text-align:center;">No pending payments found.</td></tr>
            <%
                }
                for(Appointment app : list) {
            %>
            <tr>
                <td><%= app.getAppointmentNumber() %></td>
                <td><%= app.getPatientName() %></td>
                <td><%= app.getTreatmentType() %></td>
                <td><%= app.getTotalBill() %></td>
                <td>
                    <a href="billing.jsp?appNumber=<%= app.getAppointmentNumber() %>" class="btn-small">Process Payment</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <div class="dashboard-card">
        <h3>Search Manual Bill</h3>
        <form action="billing.jsp" method="get">
            <div class="form-group">
                <label>Appointment Number:</label>
                <input type="text" name="appNumber" placeholder="Enter App Number" required>
            </div>
            <button type="submit">Find & Bill</button>
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>

