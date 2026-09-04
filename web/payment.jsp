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

        // Handle multiple treatment values
        String[] treatmentsArray = request.getParameterValues("treatment");
        String treatment = "";
        if (treatmentsArray != null) {
            treatment = String.join(", ", treatmentsArray);
        }

        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
    %>

    <div class="payment-box">
        <h2 style="text-align: center; color: #28a745;">Secure Payment</h2>
        <p style="text-align: center; font-size: 1.1rem;">Total Amount: <strong>LKR <%= request.getParameter("totalFee") != null ? request.getParameter("totalFee") : "1,000" %>.00</strong></p>
        <hr>

        <form action="AppointmentServlet" method="post">
            <input type="hidden" name="action" value="confirmRegistration">
            <input type="hidden" name="totalFee" value="<%= request.getParameter("totalFee") %>">
            <input type="hidden" name="patientName" value="<%= patientName %>">
            <input type="hidden" name="email" value="<%= email %>">
            <input type="hidden" name="dentist" value="<%= dentist %>">
            <input type="hidden" name="date" value="<%= date %>">
            <input type="hidden" name="time" value="<%= time %>">
            <input type="hidden" name="treatment" value="<%= treatment %>">
            <input type="hidden" name="contact" value="<%= contact %>">
            <input type="hidden" name="address" value="<%= address %>">

            <div class="card-icons" style="text-align: center; margin-bottom: 20px;">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png" height="20" alt="Visa">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png" height="25" alt="Mastercard" style="margin-left: 15px;">
            </div>

            <div class="form-group">
                <label>Cardholder Name</label>
                <input type="text" placeholder="Full name on card" required>
            </div>
            <div class="form-group">
                <label>Card Number</label>
                <input type="text" id="cardNum" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" required>
            </div>
            <div style="display: flex; gap: 10px;">
                <div class="form-group" style="flex: 2;">
                    <label>Expiry Date</label>
                    <input type="text" placeholder="MM / YY" maxlength="5" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>CVV</label>
                    <input type="password" placeholder="***" maxlength="3" required>
                </div>
            </div>

            <div id="loading" style="display:none; text-align:center; margin-bottom:15px; color: #28a745; font-weight: bold;">
                🔄 Processing Transaction...
            </div>

            <button type="submit" id="payBtn" style="width: 100%; background: #28a745; height: 50px; font-size: 1.1em; transition: 0.3s;">Confirm & Pay LKR 1,000.00</button>
        </form>

        <script>
            document.querySelector('form').onsubmit = function(e) {
                const btn = document.getElementById('payBtn');
                btn.disabled = true;
                btn.style.opacity = "0.7";
                btn.innerText = "Authorizing...";
                document.getElementById('loading').style.display = "block";
            };

            // Auto format card number with spaces
            document.getElementById('cardNum').addEventListener('input', function (e) {
                let target = e.target;
                let position = target.selectionEnd;
                let length = target.value.length;
                target.value = target.value.replace(/[^\d]/g, '').replace(/(.{4})/g, '$1 ').trim();
                target.selectionEnd = position + (target.value.length > length ? 1 : 0);
            });
        </script>

        <p style="text-align: center; font-size: 0.8em; color: #888; margin-top: 15px;">
            🔒 SSL Encrypted Connection
        </p>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
