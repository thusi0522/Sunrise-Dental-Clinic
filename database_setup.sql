-- Sunrise Dental Clinic - Database Setup Script

CREATE DATABASE IF NOT EXISTS sunrise_dental;
USE sunrise_dental;

-- 1. Users Table (RBAC)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- SHA-256 Hashed
    role ENUM('ADMIN', 'DOCTOR', 'CASHIER', 'PATIENT') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Appointments Table
CREATE TABLE IF NOT EXISTS appointments (
    appointment_number VARCHAR(20) PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    address TEXT,
    contact_number VARCHAR(15),
    dentist_name VARCHAR(100) NOT NULL,
    treatment_type VARCHAR(100),
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    consultation_fee DECIMAL(10,2) DEFAULT 1000.00,
    treatment_cost DECIMAL(10,2) DEFAULT 0.00,
    status ENUM('Pending', 'Treatment Completed', 'Paid', 'Cancelled') DEFAULT 'Pending'
);

-- 3. Initial Data (Passwords are 'admin123', 'doctor123', 'cashier123')
-- Hash for 'admin123': JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=
-- Hash for 'doctor123': x62v96T94D6dJ6a39d883f3e... (Wait, I'll use the same for simplicity or calculate)

INSERT INTO users (username, password, role, full_name) VALUES
('admin', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'ADMIN', 'System Administrator'),
('dr_silva', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'DOCTOR', 'Dr. Silva'),
('dr_arul', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'DOCTOR', 'Dr. Arul'),
('cashier01', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'CASHIER', 'Main Cashier');

-- Note: All default passwords are 'admin123'
