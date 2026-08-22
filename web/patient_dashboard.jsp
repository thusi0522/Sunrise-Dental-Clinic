<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="dashboard-card">
        <h2>My Health Records</h2>
        <p>View your past treatments and upcoming appointments.</p>
        <div style="background: #fff3e0; padding: 15px; border-left: 5px solid #ff9800;">
            <strong>Next Appointment:</strong> Not scheduled yet. <a href="#">Click here to request</a>.
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
