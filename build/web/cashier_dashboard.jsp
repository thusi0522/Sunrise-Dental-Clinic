<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cashier Dashboard - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="dashboard-card">
        <h2>Cashier Dashboard</h2>
        <p>Process payments and generate bills with QR codes.</p>
        <form action="billing.jsp" method="get">
            <div class="form-group">
                <label>Search Appointment Number for Billing:</label>
                <input type="text" name="appNumber" placeholder="Enter App Number (e.g. APP001)" required>
            </div>
            <button type="submit">Find & Bill</button>
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
