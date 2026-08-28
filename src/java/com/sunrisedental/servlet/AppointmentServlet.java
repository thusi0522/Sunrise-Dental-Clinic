package com.sunrisedental.servlet;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.model.Appointment;
import com.sunrisedental.util.EmailUtil;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {
    private AppointmentDAO dao = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "register";

        try {
            if ("register".equals(action)) {
                handleRegistration(request, response);
            } else if ("confirmRegistration".equals(action)) {
                handleConfirmRegistration(request, response);
            } else if ("updateTreatment".equals(action)) {
                handleUpdateTreatment(request, response);
            } else if ("confirmPayment".equals(action)) {
                handleConfirmPayment(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register_appointment.jsp?error=Processing Error: " + e.getMessage());
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String dentist = request.getParameter("dentist");
        String dateStr = request.getParameter("date");
        String timeStr = request.getParameter("time");
        
        if (dateStr == null || timeStr == null || dentist == null) {
            response.sendRedirect("register_appointment.jsp?error=Missing required fields");
            return;
        }

        Date date = Date.valueOf(dateStr);
        if (timeStr.length() == 5) timeStr += ":00";
        Time time = Time.valueOf(timeStr);

        if (!dao.isSlotAvailable(dentist, date, time)) {
            response.sendRedirect("register_appointment.jsp?error=Doctor is already booked for this time slot!");
            return;
        }
        
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }

    private void handleConfirmRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Appointment app = new Appointment();
        String appNumber = "APP-" + (System.currentTimeMillis() % 100000);
        app.setAppointmentNumber(appNumber);
        app.setPatientName(request.getParameter("patientName"));
        app.setAddress(request.getParameter("address"));
        app.setContactNumber(request.getParameter("contact"));
        app.setDentistName(request.getParameter("dentist"));
        app.setTreatmentType(request.getParameter("treatment"));
        app.setAppointmentDate(Date.valueOf(request.getParameter("date")));
        
        String timeStr = request.getParameter("time");
        if (timeStr.length() == 5) timeStr += ":00";
        app.setAppointmentTime(Time.valueOf(timeStr));
        
        app.setConsultationFee(1000.00);
        app.setTreatmentCost(0.00);
        app.setStatus("Pending");

        if (dao.isSlotAvailable(app.getDentistName(), app.getAppointmentDate(), app.getAppointmentTime())) {
            if (dao.registerAppointment(app)) {
                try {
                    String email = request.getParameter("email");
                    if (email != null && !email.isEmpty()) {
                        EmailUtil.sendConfirmationEmail(email, app.getPatientName(), appNumber, app.getAppointmentDate().toString(), timeStr);
                    }
                } catch (Throwable t) {
                    System.err.println("Email service unavailable: " + t.getMessage());
                }
                
                // Dynamic Redirect to prevent logout
                com.sunrisedental.model.User user = (com.sunrisedental.model.User) request.getSession().getAttribute("user");
                if (user != null && "ADMIN".equals(user.getRole())) {
                    response.sendRedirect("admin_dashboard.jsp?msg=Booked");
                } else if (user != null && "CASHIER".equals(user.getRole())) {
                    response.sendRedirect("cashier_dashboard.jsp?msg=Booked");
                } else {
                    response.sendRedirect("patient_dashboard.jsp?msg=Success");
                }
            } else {
                response.sendRedirect("register_appointment.jsp?error=Database Error during saving.");
            }
        } else {
            response.sendRedirect("register_appointment.jsp?error=Slot was taken during payment.");
        }
    }

    private void handleUpdateTreatment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String appNo = request.getParameter("appNumber");
        String treatment = request.getParameter("treatment");
        String costStr = request.getParameter("cost");
        
        if (appNo == null || treatment == null || costStr == null) {
            response.sendRedirect("doctor_dashboard.jsp?error=Missing treatment data");
            return;
        }

        double cost = Double.parseDouble(costStr);
        if (dao.updateTreatment(appNo, treatment, cost)) {
            response.sendRedirect("doctor_dashboard.jsp?msg=TreatmentUpdated");
        } else {
            response.sendRedirect("doctor_dashboard.jsp?error=UpdateFailed");
        }
    }

    private void handleConfirmPayment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String appNo = request.getParameter("appNumber");
        if (appNo != null && dao.updateStatus(appNo, "Paid")) {
            response.sendRedirect("cashier_dashboard.jsp?msg=PaymentConfirmed");
        } else {
            response.sendRedirect("cashier_dashboard.jsp?error=PaymentFailed");
        }
    }
}
