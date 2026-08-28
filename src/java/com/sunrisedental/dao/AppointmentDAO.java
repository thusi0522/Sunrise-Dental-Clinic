package com.sunrisedental.dao;

import com.sunrisedental.model.Appointment;
import com.sunrisedental.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {
    
    public boolean registerAppointment(Appointment app) {
        String query = "INSERT INTO appointments (appointment_number, patient_name, address, contact_number, dentist_name, treatment_type, appointment_date, appointment_time, consultation_fee, treatment_cost, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            ps.setDouble(9, 1000.00); 
            ps.setDouble(10, 0.00); 
            ps.setString(11, "PENDING");
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isSlotAvailable(String dentist, Date date, Time time) {
        String query = "SELECT COUNT(*) FROM appointments WHERE dentist_name = ? AND appointment_date = ? AND appointment_time = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, dentist);
            ps.setDate(2, date);
            ps.setTime(3, time);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public double getTodayIncome() {
        String query = "SELECT SUM(consultation_fee + treatment_cost) FROM appointments WHERE appointment_date = CURRENT_DATE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public double getTotalRegistrationFees() {
        String query = "SELECT SUM(consultation_fee) FROM appointments";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public double getTotalTreatmentIncome() {
        String query = "SELECT SUM(treatment_cost) FROM appointments WHERE UPPER(status) = 'PAID'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public Appointment getAppointment(String appNumber) {
        String query = "SELECT * FROM appointments WHERE appointment_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, appNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToAppointment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT * FROM appointments ORDER BY appointment_date DESC, appointment_time DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                list.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Double> getWeeklyIncomeData() {
        List<Double> incomeList = new ArrayList<>();
        String query = "SELECT days.day_date, COALESCE(SUM(a.consultation_fee + a.treatment_cost), 0) AS daily_total " +
                       "FROM ( " +
                       "    SELECT CURRENT_DATE - INTERVAL 6 DAY AS day_date UNION ALL " +
                       "    SELECT CURRENT_DATE - INTERVAL 5 DAY UNION ALL " +
                       "    SELECT CURRENT_DATE - INTERVAL 4 DAY UNION ALL " +
                       "    SELECT CURRENT_DATE - INTERVAL 3 DAY UNION ALL " +
                       "    SELECT CURRENT_DATE - INTERVAL 2 DAY UNION ALL " +
                       "    SELECT CURRENT_DATE - INTERVAL 1 DAY UNION ALL " +
                       "    SELECT CURRENT_DATE " +
                       ") days " +
                       "LEFT JOIN appointments a ON a.appointment_date = days.day_date AND UPPER(a.status) = 'PAID' " +
                       "GROUP BY days.day_date " +
                       "ORDER BY days.day_date ASC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                incomeList.add(rs.getDouble("daily_total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Ensure we always have 7 entries even if query fails
        while (incomeList.size() < 7) incomeList.add(0.0);
        
        return incomeList;
    }



    public List<Appointment> getAppointmentsByDoctor(String doctorName) {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT * FROM appointments WHERE dentist_name = ? ORDER BY appointment_date DESC, appointment_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, doctorName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = mapResultSetToAppointment(rs);
                list.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Appointment> getAppointmentsByPatient(String patientName) {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT * FROM appointments WHERE patient_name = ? ORDER BY appointment_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, patientName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = mapResultSetToAppointment(rs);
                list.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Appointment> getPendingPayments() {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT * FROM appointments WHERE UPPER(status) = 'COMPLETED'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                list.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateTreatment(String appNumber, String treatment, double cost) {
        String query = "UPDATE appointments SET treatment_type = ?, treatment_cost = ?, status = 'COMPLETED' WHERE appointment_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, treatment);
            ps.setDouble(2, cost);
            ps.setString(3, appNumber);
            int result = ps.executeUpdate();
            System.out.println("DEBUG: Updating app " + appNumber + " to COMPLETED. Result: " + result);
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean updateStatus(String appNumber, String status) {
        String query = "UPDATE appointments SET status = ? WHERE appointment_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status.toUpperCase());
            ps.setString(2, appNumber);
            
            boolean updated = ps.executeUpdate() > 0;
            
            // If status is PAID, automatically archive to bills table
            if (updated && "PAID".equalsIgnoreCase(status)) {
                saveBillRecord(appNumber);
            }
            return updated;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private void saveBillRecord(String appNumber) {
        Appointment app = getAppointment(appNumber);
        if (app != null) {
            String query = "INSERT INTO bills (appointment_number, patient_name, consultation_fee, treatment_cost, total_amount) VALUES (?, ?, ?, ?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, app.getAppointmentNumber());
                ps.setString(2, app.getPatientName());
                ps.setDouble(3, app.getConsultationFee());
                ps.setDouble(4, app.getTreatmentCost());
                ps.setDouble(5, app.getTotalBill());
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }



    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
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
}

