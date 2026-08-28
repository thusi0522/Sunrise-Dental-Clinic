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
        <h2>Treat Patient: Finalize Bill</h2>
        <p><strong>Patient:</strong> <%= app.getPatientName() %> | <strong>App No:</strong> <%= app.getAppointmentNumber() %></p>
        <hr style="margin-bottom: 20px; border: 0; border-top: 1px solid #eee;">

        <form action="AppointmentServlet" method="post" id="treatmentForm">
            <input type="hidden" name="action" value="updateTreatment">
            <input type="hidden" name="appNumber" value="<%= app.getAppointmentNumber() %>">

            <div class="form-group">
                <label style="font-size: 1.1rem; color: #1b2559;">Select Treatments Provided:</label>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; background: #f8f9fa; padding: 20px; border-radius: 12px; margin-top: 10px;">

                    <label class="check-container" style="display: flex; align-items: center; cursor: pointer; gap: 10px;">
                        <input type="checkbox" name="treatments" value="Cleaning" data-price="2000" style="width: 18px; height: 18px;">
                        <span>Cleaning (LKR 2,000)</span>
                    </label>

                    <label class="check-container" style="display: flex; align-items: center; cursor: pointer; gap: 10px;">
                        <input type="checkbox" name="treatments" value="Filling" data-price="3500" style="width: 18px; height: 18px;">
                        <span>Filling (LKR 3,500)</span>
                    </label>

                    <label class="check-container" style="display: flex; align-items: center; cursor: pointer; gap: 10px;">
                        <input type="checkbox" name="treatments" value="Extraction" data-price="4500" style="width: 18px; height: 18px;">
                        <span>Extraction (LKR 4,500)</span>
                    </label>

                    <label class="check-container" style="display: flex; align-items: center; cursor: pointer; gap: 10px;">
                        <input type="checkbox" name="treatments" value="Root Canal" data-price="15000" style="width: 18px; height: 18px;">
                        <span>Root Canal (LKR 15,000)</span>
                    </label>

                    <label class="check-container" style="display: flex; align-items: center; cursor: pointer; gap: 10px;">
                        <input type="checkbox" name="treatments" value="Braces Adjust" data-price="5000" style="width: 18px; height: 18px;">
                        <span>Braces Adjustment (LKR 5,000)</span>
                    </label>

                    <label class="check-container" style="display: flex; align-items: center; cursor: pointer; gap: 10px;">
                        <input type="checkbox" name="treatments" value="Consultation" data-price="1000" style="width: 18px; height: 18px;">
                        <span>Consultation Only (LKR 1,000)</span>
                    </label>
                </div>
            </div>

            <!-- Custom Treatment Note Area -->
            <div class="form-group" style="margin-top: 20px;">
                <label style="font-weight: 600;">Other Treatment Note / Remarks:</label>
                <div style="display: flex; gap: 10px; margin-top: 10px;">
                    <input type="text" id="customNote" placeholder="Enter treatment name (e.g. Whitening)" style="flex: 2;">
                    <input type="number" id="customPrice" placeholder="Price (LKR)" style="flex: 1;" oninput="calculateTotal()">
                </div>
            </div>

            <!-- Hidden input to store joined treatment names -->
            <input type="hidden" name="treatment" id="finalTreatments">

            <div class="form-group" style="margin-top: 30px; background: #e9f3ff; padding: 20px; border-radius: 12px; border: 1px solid #0066ff;">
                <label style="color: #0066ff; font-weight: 700; font-size: 1.1rem;">Calculated Treatment Cost (LKR)</label>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <span style="font-size: 1.5rem; font-weight: 700;">LKR</span>
                    <input type="number" name="cost" id="totalCost" value="0" readonly style="font-size: 1.5rem; font-weight: 700; color: #1b2559; border: none; background: transparent; width: 100%;">
                </div>
                <p style="font-size: 0.85rem; color: #555; margin-top: 8px;">* Excluding base registration fee (1,000 LKR).</p>
            </div>

            <div style="margin-top: 30px; display: flex; gap: 15px;">
                <button type="submit" class="btn" style="flex: 2; background: #05cd99; height: 50px;">Finalize Treatment & Bill</button>
                <a href="doctor_dashboard.jsp" class="btn" style="flex: 1; background: #707ebe; text-decoration: none; height: 50px; display: flex; align-items: center; justify-content: center;">Cancel</a>
            </div>
        </form>
    </div>

    <script>
        const checkboxes = document.querySelectorAll('input[name="treatments"]');
        const costInput = document.getElementById('totalCost');
        const finalTreatmentsInput = document.getElementById('finalTreatments');

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', calculateTotal);
        });

        function calculateTotal() {
            let total = 0;
            let selectedNames = [];

            // From Checkboxes
            checkboxes.forEach(cb => {
                if (cb.checked) {
                    total += parseInt(cb.getAttribute('data-price'));
                    selectedNames.push(cb.value);
                }
            });

            // From Custom Note
            let customNote = document.getElementById('customNote').value;
            let customPrice = parseInt(document.getElementById('customPrice').value) || 0;

            if (customNote && customPrice > 0) {
                total += customPrice;
                selectedNames.push(customNote);
            }

            costInput.value = total;
            finalTreatmentsInput.value = selectedNames.join(", ");
        }

        // Also update if custom note text changes
        document.getElementById('customNote').addEventListener('input', calculateTotal);
    </script>


    <%@ include file="footer.jsp" %>
</body>
</html>
