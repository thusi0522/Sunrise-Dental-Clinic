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
        <h3>Paid Bills History</h3>
        <table>
            <thead>
                <tr>
                    <th>App No</th>
                    <th>Patient Name</th>
                    <th>Treatments</th>
                    <th>Total Paid (LKR)</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Appointment> history = dao.getAllAppointments();
                    int histCount = 0;
                    for(Appointment app : history) {
                        if("PAID".equalsIgnoreCase(app.getStatus())) {
                            histCount++;
                %>
                <tr>
                    <td><strong><%= app.getAppointmentNumber() %></strong></td>
                    <td><%= app.getPatientName() %></td>
                    <td><%= app.getTreatmentType() %></td>
                    <td style="font-weight: 600;">LKR <%= String.format("%.2f", app.getTotalBill()) %></td>
                    <td>
                        <a href="billing.jsp?appNumber=<%= app.getAppointmentNumber() %>" target="_blank" class="btn btn-small" style="background: var(--primary); text-decoration: none; padding: 5px 10px; border-radius: 4px; color: white; font-size: 0.8rem;">
                            <i class="fa-solid fa-file-pdf"></i> VIEW PDF
                        </a>
                    </td>
                </tr>
                <%
                        }
                    }
                    if (histCount == 0) {
                %>
                <tr><td colspan="5" style="text-align:center;">No payment history found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>

