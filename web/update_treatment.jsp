<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Treatment - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
        String appNo = request.getParameter("appNumber");
        AppointmentDAO dao = new AppointmentDAO();
        Appointment app = dao.getAppointment(appNo);
        if (app == null) {
            response.sendRedirect("doctor_dashboard.jsp?error=NotFound");
            return;
        }
    %>

    <div class="dashboard-card">
        <h2>Update Treatment Details</h2>
        <p><strong>Patient:</strong> <%= app.getPatientName() %> | <strong>App No:</strong> <%= app.getAppointmentNumber() %></p>

        <form action="AppointmentServlet" method="post">
            <input type="hidden" name="action" value="updateTreatment">
            <input type="hidden" name="appNumber" value="<%= app.getAppointmentNumber() %>">

            <div class="form-group">
                <label>Treatment Finalized</label>
                <select name="treatment">
                    <option value="Cleaning" <%= "Cleaning".equals(app.getTreatmentType()) ? "selected" : "" %>>Cleaning</option>
                    <option value="Filling" <%= "Filling".equals(app.getTreatmentType()) ? "selected" : "" %>>Filling</option>
                    <option value="Extraction" <%= "Extraction".equals(app.getTreatmentType()) ? "selected" : "" %>>Extraction</option>
                    <option value="Root Canal" <%= "Root Canal".equals(app.getTreatmentType()) ? "selected" : "" %>>Root Canal</option>
                    <option value="Braces Adjustment">Braces Adjustment</option>
                    <option value="Consultation Only">Consultation Only</option>
                </select>
            </div>

            <div class="form-group">
                <label>Treatment Cost (LKR)</label>
                <input type="number" name="cost" required placeholder="Enter total cost for this treatment">
            </div>

            <div style="margin-top: 20px;">
                <button type="submit" class="btn">Complete Treatment & Notify Cashier</button>
                <a href="doctor_dashboard.jsp" style="margin-left: 10px;">Cancel</a>
            </div>
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
