<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.AppointmentDAO, com.sunrisedental.model.Appointment, java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Financial Reports - Sunrise Dental</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String filterMonth = request.getParameter("month"); // Format: YYYY-MM
        AppointmentDAO dao = new AppointmentDAO();
        List<Appointment> allApp = dao.getAllAppointments();
        List<Appointment> filteredList = new ArrayList<>();
        double totalIncome = 0;

        if (filterMonth != null && !filterMonth.isEmpty()) {
            for (Appointment app : allApp) {
                if ("PAID".equalsIgnoreCase(app.getStatus())) {
                    String appMonth = new SimpleDateFormat("yyyy-MM").format(app.getAppointmentDate());
                    if (appMonth.equals(filterMonth)) {
                        filteredList.add(app);
                        totalIncome += app.getTotalBill();
                    }
                }
            }
        }
    %>

    <div class="container">
        <div class="dashboard-card">
            <h2><i class="fa-solid fa-chart-line"></i> Financial Income Reports</h2>
            <form action="reports.jsp" method="get" style="display: flex; gap: 15px; align-items: flex-end;">
                <div class="form-group" style="margin-bottom: 0;">
                    <label>Select Month & Year</label>
                    <input type="month" name="month" value="<%= filterMonth != null ? filterMonth : "" %>" required>
                </div>
                <button type="submit" class="btn">Generate Report</button>
            </form>
        </div>

        <% if (filterMonth != null) { %>
        <div id="reportContent" class="dashboard-card">
            <div style="text-align: center; margin-bottom: 20px; border-bottom: 2px solid #eee; padding-bottom: 10px;">
                <h2 style="margin: 0; color: #1b2559;">SUNRISE DENTAL CLINIC</h2>
                <p style="color: #707ebe;">Income Report for <%= filterMonth %></p>
            </div>

            <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                <div class="stat-box" style="background: #e9f3ff; padding: 15px; border-radius: 8px; flex: 1; margin-right: 10px; text-align: center;">
                    <h4 style="margin: 0; font-size: 0.9rem; color: #0066ff;">Total Transactions</h4>
                    <p style="font-size: 1.5rem; font-weight: 700; margin: 5px 0;"><%= filteredList.size() %></p>
                </div>
                <div class="stat-box" style="background: #e6f9f0; padding: 15px; border-radius: 8px; flex: 1; text-align: center;">
                    <h4 style="margin: 0; font-size: 0.9rem; color: #05cd99;">Total Monthly Income</h4>
                    <p style="font-size: 1.5rem; font-weight: 700; margin: 5px 0;">LKR <%= String.format("%.2f", totalIncome) %></p>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>App No</th>
                        <th>Patient</th>
                        <th>Treatments</th>
                        <th>Income (LKR)</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Appointment app : filteredList) { %>
                    <tr>
                        <td><%= app.getAppointmentDate() %></td>
                        <td><%= app.getAppointmentNumber() %></td>
                        <td><%= app.getPatientName() %></td>
                        <td><%= app.getTreatmentType() %></td>
                        <td style="font-weight: 600;">LKR <%= String.format("%.2f", app.getTotalBill()) %></td>
                    </tr>
                    <% } if (filteredList.isEmpty()) { %>
                    <tr><td colspan="5" style="text-align:center;">No records found for this period.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div style="text-align: center; margin-bottom: 40px;">
            <button onclick="downloadReportPDF()" class="btn" style="background: #0066ff; padding: 15px 30px;">
                <i class="fa-solid fa-file-arrow-down"></i> Download Monthly Report (PDF)
            </button>
        </div>
        <% } %>
    </div>

    <script>
        async function downloadReportPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF('p', 'pt', 'a4');
            const element = document.getElementById('reportContent');

            await html2canvas(element, { scale: 2 }).then(canvas => {
                const imgData = canvas.toDataURL('image/png');
                const pdfWidth = doc.internal.pageSize.getWidth();
                const pdfHeight = (canvas.height * pdfWidth) / canvas.width;
                doc.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);
                doc.save('Monthly_Report_<%= filterMonth %>.pdf');
            });
        }
    </script>

    <%@ include file="footer.jsp" %>
</body>
</html>
