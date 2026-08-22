<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Bill - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .bill-container {
            background: #fff;
            padding: 40px;
            max-width: 600px;
            margin: 20px auto;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        .bill-header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .bill-row { display: flex; justify-content: space-between; padding: 5px 0; }
        .total-row { font-weight: bold; font-size: 1.2em; border-top: 1px solid #333; margin-top: 10px; padding-top: 10px; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="bill-container">
        <%
            String appNumber = request.getParameter("appNumber");
            AppointmentDAO dao = new AppointmentDAO();
            Appointment app = dao.getAppointment(appNumber);

            if (app != null) {
                String qrData = "Patient: " + app.getPatientName() +
                               " | AppNo: " + app.getAppointmentNumber() +
                               " | Total: LKR " + app.getTotalBill();
                String qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + java.net.URLEncoder.encode(qrData, "UTF-8");
        %>
            <div class="bill-header">
                <h2>SUNRISE DENTAL CLINIC</h2>
                <p>123, Ward Place, Colombo 07</p>
                <h3>Patient Bill / Receipt</h3>
            </div>

            <div class="bill-row"><span>Appointment No:</span> <strong><%= app.getAppointmentNumber() %></strong></div>
            <div class="bill-row"><span>Patient Name:</span> <span><%= app.getPatientName() %></span></div>
            <div class="bill-row"><span>Date:</span> <span><%= app.getAppointmentDate() %></span></div>
            <div class="bill-row"><span>Treatment:</span> <span><%= app.getTreatmentType() %></span></div>
            <hr>
            <div class="bill-row"><span>Consultation Fee:</span> <span>LKR <%= app.getConsultationFee() %></span></div>
            <div class="bill-row"><span>Treatment Cost:</span> <span>LKR <%= app.getTreatmentCost() %></span></div>

            <div class="bill-row total-row">
                <span>TOTAL AMOUNT:</span>
                <span>LKR <%= app.getTotalBill() %></span>
            </div>

            <div class="qr-code">
                <p>Scan for Details</p>
                <img src="<%= qrUrl %>" alt="QR Code">
            </div>

            <div style="margin-top: 30px; text-align: center;">
                <button onclick="window.print()">Print Bill</button>
            </div>
        <% } else { %>
            <p class="error">Appointment not found. Please check the ID.</p>
        <% } %>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
