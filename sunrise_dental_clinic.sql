-- =========================================================
-- SUNRISE DENTAL CLINIC - COMPLETE DATABASE SCRIPT
-- =========================================================

CREATE DATABASE IF NOT EXISTS sunrise_dental;
USE sunrise_dental;

-- 1. Users Table (Role-Based Access Control)
-- All user passwords hashed using SHA-256
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'DOCTOR', 'CASHIER', 'PATIENT') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Appointments Table (Patient Visits & Treatment Records)
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
    status VARCHAR(50) DEFAULT 'PENDING'
);

-- 3. Bills Table (Financial History & Audit Trail)
CREATE TABLE IF NOT EXISTS bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_number VARCHAR(20),
    patient_name VARCHAR(100),
    consultation_fee DECIMAL(10,2),
    treatment_cost DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_number) REFERENCES appointments(appointment_number)
);

-- =========================================================
-- INITIAL SEED DATA (Default Password for all: admin123)
-- Password Hash: JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=
-- =========================================================

INSERT IGNORE INTO users (username, password, role, full_name) VALUES
('admin@gmail.com', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'ADMIN', 'System Director'),
('silva@gmail.com', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'DOCTOR', 'Dr. Silva'),
('arul@gmail.com', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'DOCTOR', 'Dr. Arul'),
('cashier@gmail.com', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwdyPqCKAn3THIKk=', 'CASHIER', 'Main Cashier');
