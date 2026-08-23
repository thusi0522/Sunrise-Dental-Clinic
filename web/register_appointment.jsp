<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.UserDAO, com.sunrisedental.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Appointment - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
        UserDAO userDAO = new UserDAO();
        List<User> doctors = userDAO.getDoctors();
    %>

    <div class="dashboard-card">
        <h2>Register New Appointment</h2>
        <% if (request.getParameter("error") != null) { %>
            <div class="error-msg" style="color: #d32f2f; background: #ffebee; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                <%= request.getParameter("error") %>
            </div>
        <% } %>
        <form action="AppointmentServlet" method="post">
            <input type="hidden" name="action" value="register">
                <label>Patient Name</label>
                <input type="text" name="patientName" required value="<%= user.getFullName() %>" <%= "PATIENT".equals(user.getRole()) ? "readonly" : "" %>>
            </div>
            <div class="form-group">
                <label>Patient Email</label>
                <input type="email" name="email" required placeholder="For confirmation receipt">
            </div>
            <div class="form-group">
                <label>Address</label>
                <textarea name="address"></textarea>
            </div>
            <div class="form-group">
                <label>Contact Number</label>
                <input type="text" name="contact">
            </div>
            <div class="form-group">
                <label>Select Dentist</label>
                <select name="dentist" required>
                    <option value="">-- Choose a Doctor --</option>
                    <% for(User doc : doctors) { %>
                        <option value="<%= doc.getFullName() %>"><%= doc.getFullName() %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label>Treatment Type</label>
                <select name="treatment">
                    <option value="Cleaning">Cleaning</option>
                    <option value="Filling">Filling</option>
                    <option value="Extraction">Extraction</option>
                    <option value="Root Canal">Root Canal</option>
                </select>
            </div>
            <div class="form-group">
                <label>Date</label>
                <input type="date" name="date" required>
            </div>
            <div class="form-group">
                <label>Time (8:30 AM - 7:00 PM)</label>
                <input type="time" name="time" required>
            </div>

            <div style="background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
                <p style="margin: 0; font-size: 0.9em; color: #666;">
                    * A fixed registration fee of <strong>LKR 1,000.00</strong> will be applied automatically.
                </p>
            </div>

            <button type="submit">Book Slot & Pay Fee</button>
        </form>

    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
