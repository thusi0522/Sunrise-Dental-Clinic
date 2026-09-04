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
                <label>Treatment Type (Select one or more)</label>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; background: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px solid #ddd;">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" name="treatment" value="Cleaning" class="treatment-cb" style="width: 18px; height: 18px;"> Cleaning
                    </label>
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" name="treatment" value="Filling" class="treatment-cb" style="width: 18px; height: 18px;"> Filling
                    </label>
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" name="treatment" value="Extraction" class="treatment-cb" style="width: 18px; height: 18px;"> Extraction
                    </label>
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" name="treatment" value="Root Canal" class="treatment-cb" style="width: 18px; height: 18px;"> Root Canal
                    </label>
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" name="treatment" value="Checkup" class="treatment-cb" style="width: 18px; height: 18px;"> General Checkup
                    </label>
                </div>
            </div>

            <div style="background: #e3f2fd; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #2196f3;">
                <p style="margin: 0; font-size: 1rem; color: #0d47a1; font-weight: 600;">
                    Total Registration Fee: LKR <span id="displayFee">0.00</span>
                </p>
                <input type="hidden" name="totalFee" id="totalFeeInput" value="0">
            </div>

            <script>
                const checkboxes = document.querySelectorAll('.treatment-cb');
                const displayFee = document.getElementById('displayFee');
                const feeInput = document.getElementById('totalFeeInput');

                checkboxes.forEach(cb => {
                    cb.addEventListener('change', () => {
                        const count = document.querySelectorAll('.treatment-cb:checked').length;
                        const total = count * 1000;
                        displayFee.innerText = total.toLocaleString() + ".00";
                        feeInput.value = total;
                    });
                });
            </script>

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
