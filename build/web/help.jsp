<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>System Help Guide - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .help-section { margin-bottom: 40px; border-left: 4px solid var(--primary); padding-left: 20px; }
        .help-section h3 { color: var(--primary); font-size: 1.4rem; margin-bottom: 10px; }
        .step-box { background: #f8f9fa; padding: 15px; border-radius: 8px; margin-top: 10px; border: 1px solid #eee; }
        .step-box ul { list-style: none; padding: 0; }
        .step-box li { margin-bottom: 10px; display: flex; align-items: flex-start; gap: 10px; }
        .step-box li i { color: var(--success); margin-top: 4px; }
        .role-icon { font-size: 2rem; margin-bottom: 10px; color: var(--primary); }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <div class="dashboard-card" style="text-align: center; background: linear-gradient(135deg, #e9f3ff, #ffffff);">
            <h1><i class="fa-solid fa-circle-info"></i> Sunrise Dental Help Center</h1>
            <p>Welcome to our simple guide. Find your role below to learn how to use the system.</p>
        </div>

        <!-- 1. Patient Guide -->
        <% if ("PATIENT".equals(user.getRole())) { %>
        <div class="dashboard-card help-section">
            <i class="fa-solid fa-user-injured role-icon"></i>
            <h3>Patient User Guide</h3>
            <p>Welcome! Here is how you can use our system:</p>
            <div class="step-box">
                <ul>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Booking:</strong> Go to "New Appointment", pick a Doctor, Date, and Time.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Payment:</strong> Pay the LKR 1,000 fee on the secure payment page to confirm your slot.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>History:</strong> Check "My Appointments" to see your past visits and download PDF bills.</li>
                </ul>
            </div>
        </div>
        <% } %>

        <!-- 2. Doctor Guide -->
        <% if ("DOCTOR".equals(user.getRole())) { %>
        <div class="dashboard-card help-section">
            <i class="fa-solid fa-user-doctor role-icon"></i>
            <h3>Doctor User Guide</h3>
            <p>Manage your patients and finalized treatments easily:</p>
            <div class="step-box">
                <ul>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Schedule:</strong> Your dashboard shows only the patients assigned to YOU.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Treating:</strong> Click <b>"Treat Patient"</b> for any "PENDING" appointment.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Billing:</strong> Tick the treatments you gave. The cost is calculated automatically.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Custom:</strong> Use the "Other Treatment" box to add special services.</li>
                </ul>
            </div>
        </div>
        <% } %>

        <!-- 3. Cashier Guide -->
        <% if ("CASHIER".equals(user.getRole())) { %>
        <div class="dashboard-card help-section">
            <i class="fa-solid fa-cash-register role-icon"></i>
            <h3>Cashier User Guide</h3>
            <p>Handle payments and generate professional receipts:</p>
            <div class="step-box">
                <ul>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Pending Bills:</strong> Look at "Pending Payments" for patients who finished their treatment.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Billing:</strong> Click "Process Payment" to open the final bill.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Confirmation:</strong> Click "Confirm Payment" once you receive the funds.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>PDF & QR:</strong> Provide the digital invoice with the unique QR code.</li>
                </ul>
            </div>
        </div>
        <% } %>

        <!-- 4. Admin Guide -->
        <% if ("ADMIN".equals(user.getRole())) { %>
        <div class="dashboard-card help-section">
            <i class="fa-solid fa-user-shield role-icon"></i>
            <h3>Admin Management Guide</h3>
            <p>Full control over clinic operations and staff:</p>
            <div class="step-box">
                <ul>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Analytics:</strong> View real-time income graphs for the last 7 days.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Staff:</strong> Add or remove Doctor and Cashier accounts.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Financials:</strong> Generate and download monthly income PDF reports.</li>
                </ul>
            </div>
        </div>
        <% } %>

        <div class="dashboard-card" style="text-align: center; border: none; box-shadow: none; background: transparent;">
            <p>Need more help? Contact our technical team at <b>support@sunrisedental.com</b></p>
            <a href="javascript:history.back()" class="btn">Go Back</a>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
