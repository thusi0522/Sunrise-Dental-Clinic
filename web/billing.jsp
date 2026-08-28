<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Bill - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <!-- PDF Libraries -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
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

            <div style="margin-top: 30px; text-align: center; display: flex; justify-content: center; gap: 15px;">
                <button onclick="downloadPDF()" style="background-color: #0077b6;">Download PDF Invoice</button>
                <button onclick="window.print()" style="background-color: #707ebe;">Print Receipt</button>

                <% if (app.getStatus() != null && !app.getStatus().equalsIgnoreCase("Paid")) { %>
                    <form action="AppointmentServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="confirmPayment">
                        <input type="hidden" name="appNumber" value="<%= app.getAppointmentNumber() %>">
                        <button type="submit" style="background-color: #2dce89;">Confirm Payment & Close</button>
                    </form>
                <% } %>
            </div>

            <script>
                async function downloadPDF() {
                    const { jsPDF } = window.jspdf;
                    const doc = new jsPDF('p', 'pt', 'a4');
                    const element = document.querySelector('.bill-container');

                    // Hide buttons temporarily during capture
                    const buttons = document.querySelectorAll('button, form');
                    buttons.forEach(b => b.style.display = 'none');

                    await html2canvas(element, { scale: 2 }).then(canvas => {
                        const imgData = canvas.toDataURL('image/png');
                        const imgProps = doc.getImageProperties(imgData);
                        const pdfWidth = doc.internal.pageSize.getWidth();
                        const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;
                        doc.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);
                        doc.save('Invoice_<%= app.getAppointmentNumber() %>.pdf');
                    });

                    // Restore buttons
                    buttons.forEach(b => b.style.display = 'inline-block');
                }
            </script>

        <% } else { %>
            <p class="error">Appointment not found. Please check the ID.</p>
        <% } %>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
