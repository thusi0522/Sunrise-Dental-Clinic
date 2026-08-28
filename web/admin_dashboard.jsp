<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment, java.util.List" %>
<!DOCTYPE html>
<html lang="ta">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Sunrise Dental</title>
    
    <!-- Google Fonts & Font Awesome Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f4f7fe;
            color: #2b3674;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .dashboard-header {
            margin-bottom: 25px;
        }

        .dashboard-header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #1b2559;
        }

        .dashboard-header p {
            color: #a3edda;
            color: #707ebe;
            font-size: 14px;
            margin-top: 5px;
        }

        /* Stat Cards Layout */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: #ffffff;
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: center;
            box-shadow: 0px 18px 40px rgba(112, 144, 176, 0.12);
            transition: transform 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 20px;
        }

        .stat-icon.blue { background: #e9f3ff; color: #0066ff; }
        .stat-icon.green { background: #e6f9f0; color: #05cd99; }

        .stat-info h3 {
            font-size: 14px;
            color: #a3eedb;
            color: #707ebe;
            font-weight: 500;
        }

        .stat-info .value {
            font-size: 24px;
            font-weight: 700;
            color: #1b2559;
            margin-top: 5px;
        }

        /* Analytics & Quick Actions Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        @media (max-width: 900px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        .card {
            background: #ffffff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0px 18px 40px rgba(112, 144, 176, 0.12);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-header h3 {
            font-size: 18px;
            font-weight: 700;
            color: #1b2559;
        }

        /* Quick Action Buttons */
        .action-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .action-btn {
            display: flex;
            align-items: center;
            padding: 14px 18px;
            background: #f4f7fe;
            color: #1b2559;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .action-btn i {
            margin-right: 12px;
            font-size: 16px;
            color: #4318ff;
        }

        .action-btn:hover {
            background: #4318ff;
            color: #ffffff;
        }

        .action-btn:hover i {
            color: #ffffff;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <%
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        AppointmentDAO appDAO = new AppointmentDAO();
        double todayIncome = appDAO.getTodayIncome();
        double totalRegFees = appDAO.getTotalRegistrationFees();
        double totalTreatIncome = appDAO.getTotalTreatmentIncome();
        List<Appointment> allApp = appDAO.getAllAppointments();
        int totalApp = allApp.size();

        // Fetch real weekly data
        java.util.List<Double> weeklyIncome = appDAO.getWeeklyIncomeData();

        // Prepare labels for the last 7 days
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("EEE");
        java.util.Calendar cal = java.util.Calendar.getInstance();
        String[] dayLabels = new String[7];
        for (int i = 6; i >= 0; i--) {
            java.util.Calendar tempCal = (java.util.Calendar) cal.clone();
            tempCal.add(java.util.Calendar.DATE, -i);
            dayLabels[6-i] = sdf.format(tempCal.getTime());
        }
    %>

    <div class="dashboard-container">
        <!-- Header -->
        <div class="dashboard-header">
            <h2>Admin Analytics Dashboard</h2>
            <p>Welcome back, <%= user.getFullName() %>. Here's what's happening today.</p>
        </div>

        <!-- Top Stat Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Appointments</h3>
                    <div class="value"><%= totalApp %></div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon green">
                    <i class="fa-solid fa-file-invoice-dollar"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Registration Fees</h3>
                    <div class="value">LKR <%= String.format("%.2f", totalRegFees) %></div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon blue">
                    <i class="fa-solid fa-hand-holding-dollar"></i>
                </div>
                <div class="stat-info">
                    <h3>Treatment Income</h3>
                    <div class="value">LKR <%= String.format("%.2f", totalTreatIncome) %></div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon green">
                    <i class="fa-solid fa-wallet"></i>
                </div>
                <div class="stat-info">
                    <h3>Today's Income</h3>
                    <div class="value">LKR <%= String.format("%.2f", todayIncome) %></div>
                </div>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="content-grid">
            <!-- Chart Card -->
            <div class="card">
                <div class="card-header">
                    <h3>Income Trends (Last 7 Days)</h3>
                </div>
                <canvas id="incomeChart" style="max-height: 280px;"></canvas>
            </div>

            <!-- Quick Actions Card -->
            <div class="card">
                <div class="card-header">
                    <h3>Quick Actions</h3>
                </div>
                <div class="action-list">
                    <a href="register_appointment.jsp" class="action-btn">
                        <i class="fa-solid fa-plus-circle"></i> Register New Appointment
                    </a>
                    <a href="manage_users.jsp" class="action-btn">
                        <i class="fa-solid fa-user-gear"></i> Manage Staff Accounts
                    </a>
                    <a href="search_appointment.jsp" class="action-btn">
                        <i class="fa-solid fa-magnifying-glass"></i> Search Patient Record
                    </a>
                    <a href="help.jsp" class="action-btn">
                        <i class="fa-solid fa-circle-question"></i> System Documentation
                    </a>
                </div>
            </div>
        </div>

        <!-- Recent Appointments Table -->
        <div class="card" style="margin-top: 25px;">
            <div class="card-header">
                <h3>Recent Appointments</h3>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>App No</th>
                        <th>Patient Name</th>
                        <th>Doctor (Dentist)</th>
                        <th>Date & Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int count = 0;
                        for(Appointment app : allApp) {
                            if(count++ >= 5) break; // Show only top 5
                    %>
                    <tr>
                        <td><strong><%= app.getAppointmentNumber() %></strong></td>
                        <td><%= app.getPatientName() %></td>
                        <td style="color: #4318ff; font-weight: 500;">
                            <i class="fa-solid fa-user-doctor" style="margin-right: 5px;"></i> <%= app.getDentistName() %>
                        </td>
                        <td><%= app.getAppointmentDate() %> | <%= app.getAppointmentTime() %></td>
                        <td>
                            <span class="status-badge <%= app.getStatus().toLowerCase() %>">
                                <%= app.getStatus() %>
                            </span>
                        </td>
                    </tr>
                    <% } if (allApp.isEmpty()) { %>
                    <tr><td colspan="5" style="text-align: center; color: #707ebe;">No appointments found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Financial History Table -->
        <div class="card" style="margin-top: 25px; border-top: 4px solid #05cd99;">
            <div class="card-header">
                <h3>Paid Bills History (Financial Records)</h3>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Bill No</th>
                        <th>Patient</th>
                        <th>Treatments</th>
                        <th>Reg Fee</th>
                        <th>Treat Cost</th>
                        <th>Total Paid</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int paidCount = 0;
                        for(Appointment app : allApp) {
                            if("PAID".equalsIgnoreCase(app.getStatus())) {
                                paidCount++;
                    %>
                    <tr>
                        <td><strong>B-<%= app.getAppointmentNumber() %></strong></td>
                        <td><%= app.getPatientName() %></td>
                        <td><%= app.getTreatmentType() %></td>
                        <td>LKR <%= app.getConsultationFee() %></td>
                        <td>LKR <%= app.getTreatmentCost() %></td>
                        <td style="color: #05cd99; font-weight: 700;">LKR <%= String.format("%.2f", app.getTotalBill()) %></td>
                        <td>
                            <a href="billing.jsp?appNumber=<%= app.getAppointmentNumber() %>" target="_blank" class="btn btn-small" title="Download PDF" style="background: var(--primary); text-decoration: none; padding: 5px 10px; border-radius: 4px; color: white;">
                                <i class="fa-solid fa-file-pdf"></i> PDF
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                        if (paidCount == 0) {
                    %>
                    <tr><td colspan="7" style="text-align:center;">No paid bills recorded yet.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const ctx = document.getElementById('incomeChart').getContext('2d');
        
        // Gradient background for chart
        let gradient = ctx.createLinearGradient(0, 0, 0, 300);
        gradient.addColorStop(0, 'rgba(67, 24, 255, 0.2)');
        gradient.addColorStop(1, 'rgba(67, 24, 255, 0)');

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: [<% for(int i=0; i<7; i++) { %> '<%= dayLabels[i] %>' <%= i<6?",":"" %> <% } %>],
                datasets: [{
                    label: 'Revenue (LKR)',
                    data: [<% for(int i=0; i<7; i++) { %> <%= weeklyIncome.get(i) %> <%= i<6?",":"" %> <% } %>],
                    borderColor: '#4318ff',
                    borderWidth: 3,
                    backgroundColor: gradient,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#4318ff',
                    pointRadius: 4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: { 
                        grid: { borderDash: [5, 5] },
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) { return 'LKR ' + value; }
                        }
                    }
                }
            }
        });
    </script>


    <%@ include file="footer.jsp" %>

</body>
</html>