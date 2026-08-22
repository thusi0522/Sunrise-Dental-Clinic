package com.sunrisedental.dao;

import com.sunrisedental.model.Appointment;
import com.sunrisedental.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {
    
    public boolean registerAppointment(Appointment app) {
        String query = "INSERT INTO appointments (appointment_number, patient_name, address, contact_number, dentist_name, treatment_type, appointment_date, appointment_time, consultation_fee, treatment_cost) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, app.getAppointmentNumber());
            ps.setString(2, app.getPatientName());
            ps.setString(3, app.getAddress());
            ps.setString(4, app.getContactNumber());
            ps.setString(5, app.getDentistName());
            ps.setString(6, app.getTreatmentType());
            ps.setDate(7, app.getAppointmentDate());
            ps.setTime(8, app.getAppointmentTime());
            ps.setDouble(9, app.getConsultationFee());
            ps.setDouble(10, app.getTreatmentCost());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Appointment getAppointment(String appNumber) {
        String query = "SELECT * FROM appointments WHERE appointment_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, appNumber);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentNumber(rs.getString("appointment_number"));
                app.setPatientName(rs.getString("patient_name"));
                app.setAddress(rs.getString("address"));
                app.setContactNumber(rs.getString("contact_number"));
                app.setDentistName(rs.getString("dentist_name"));
                app.setTreatmentType(rs.getString("treatment_type"));
                app.setAppointmentDate(rs.getDate("appointment_date"));
                app.setAppointmentTime(rs.getTime("appointment_time"));
                app.setConsultationFee(rs.getDouble("consultation_fee"));
                app.setTreatmentCost(rs.getDouble("treatment_cost"));
                app.setStatus(rs.getString("status"));
                return app;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT * FROM appointments";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentNumber(rs.getString("appointment_number"));
                app.setPatientName(rs.getString("patient_name"));
                app.setDentistName(rs.getString("dentist_name"));
                app.setTreatmentType(rs.getString("treatment_type"));
                app.setAppointmentDate(rs.getDate("appointment_date"));
                app.setStatus(rs.getString("status"));
                list.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
