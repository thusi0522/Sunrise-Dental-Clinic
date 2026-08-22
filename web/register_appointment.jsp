<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register Appointment - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="dashboard-card">
        <h2>Register New Patient/Appointment</h2>
        <form action="AppointmentServlet" method="post">
            <div class="form-group">
                <label>Appointment Number</label>
                <input type="text" name="appNumber" required placeholder="e.g. APP101">
            </div>
            <div class="form-group">
                <label>Patient Name</label>
                <input type="text" name="patientName" required>
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
                <label>Dentist Name</label>
                <select name="dentist">
                    <option value="Dr. Arul">Dr. Arul</option>
                    <option value="Dr. Silva">Dr. Silva</option>
                    <option value="Dr. Perera">Dr. Perera</option>
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
                <label>Time</label>
                <input type="time" name="time" required>
            </div>
            <div class="form-group">
                <label>Consultation Fee (LKR)</label>
                <input type="number" name="consultationFee" value="1000">
            </div>
            <div class="form-group">
                <label>Treatment Cost (LKR)</label>
                <input type="number" name="treatmentCost" value="0">
            </div>
            <button type="submit">Register Appointment</button>
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
