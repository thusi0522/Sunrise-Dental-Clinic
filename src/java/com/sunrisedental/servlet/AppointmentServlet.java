package com.sunrisedental.servlet;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.model.Appointment;
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
        try {
            Appointment app = new Appointment();
            app.setAppointmentNumber(request.getParameter("appNumber"));
            app.setPatientName(request.getParameter("patientName"));
            app.setAddress(request.getParameter("address"));
            app.setContactNumber(request.getParameter("contact"));
            app.setDentistName(request.getParameter("dentist"));
            app.setTreatmentType(request.getParameter("treatment"));
            
            // Handle Date
            String dateStr = request.getParameter("date");
            if (dateStr != null && !dateStr.isEmpty()) {
                app.setAppointmentDate(Date.valueOf(dateStr));
            }
            
            // Handle Time
            String timeStr = request.getParameter("time");
            if (timeStr != null && !timeStr.isEmpty()) {
                app.setAppointmentTime(Time.valueOf(timeStr + ":00"));
            }
            
            app.setConsultationFee(Double.parseDouble(request.getParameter("consultationFee")));
            app.setTreatmentCost(Double.parseDouble(request.getParameter("treatmentCost")));
            
            if (dao.registerAppointment(app)) {
                response.sendRedirect("doctor_dashboard.jsp?msg=Success");
            } else {
                response.sendRedirect("register_appointment.jsp?error=Failed to register in database");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register_appointment.jsp?error=" + e.getMessage());
        }
    }
}
