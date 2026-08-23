<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Secure Payment - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .payment-box { max-width: 400px; margin: 50px auto; border: 1px solid #ddd; padding: 30px; border-radius: 10px; background: #fff; }
        .card-icons { font-size: 24px; margin-bottom: 20px; color: #555; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <%
        // Get data from registration form to pass to final servlet
        String patientName = request.getParameter("patientName");
        String email = request.getParameter("email");
        String dentist = request.getParameter("dentist");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String treatment = request.getParameter("treatment");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
    %>

    <div class="payment-box">
        <h2 style="text-align: center; color: #28a745;">Secure Payment</h2>
        <p style="text-align: center;">Registration Fee: <strong>LKR 1,000.00</strong></p>
        <hr>

        <form action="AppointmentServlet" method="post">
            <input type="hidden" name="action" value="confirmRegistration">
            <input type="hidden" name="patientName" value="<%= patientName %>">
            <input type="hidden" name="email" value="<%= email %>">
            <input type="hidden" name="dentist" value="<%= dentist %>">
            <input type="hidden" name="date" value="<%= date %>">
            <input type="hidden" name="time" value="<%= time %>">
            <input type="hidden" name="treatment" value="<%= treatment %>">
            <input type="hidden" name="contact" value="<%= contact %>">
            <input type="hidden" name="address" value="<%= address %>">

            <div class="form-group">
                <label>Cardholder Name</label>
                <input type="text" placeholder="John Doe" required>
            </div>
            <div class="form-group">
                <label>Card Number</label>
                <input type="text" placeholder="1234 5678 9101 1121" maxlength="19" required>
            </div>
            <div style="display: flex; gap: 10px;">
                <div class="form-group" style="flex: 1;">
                    <label>Expiry Date</label>
                    <input type="text" placeholder="MM/YY" maxlength="5" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>CVV</label>
                    <input type="password" placeholder="***" maxlength="3" required>
                </div>
            </div>

            <button type="submit" style="width: 100%; background: #28a745;">Pay LKR 1,000 & Confirm</button>
        </form>
        <p style="text-align: center; font-size: 0.8em; color: #888; margin-top: 15px;">
            🔒 SSL Encrypted Connection
        </p>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
