/*
===============================================================================
DDL Script: Create Clinic Tables
===============================================================================
Script Purpose:
    This script creates tables for the Clinic Management System including
    clinics, customers, clinic_sales, and expenses.

    It defines relationships and inserts sample data for analysis.

    Run this script to set up the clinic database schema.
===============================================================================
*/  
CREATE DATABASE Clinics 
GO
use Clinics 
GO 
-- CREATE A TABLE CLINICS
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
); 
-- INSERT VALUES INTO THE CLINICS  
INSERT INTO clinics 
VALUES ('C1', 'Tharun Clinic', 'Chennai', 'TN', 'India'),
       ('C2', 'Veni Clinic', 'Vijawada', 'AP', 'India'),
       ('C3', 'Charan Clinic', 'Hyderbad', 'TG', 'India'); 

-- CREATE A CUSTOMERS TABLE
CREATE TABLE customers (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
); 

-- INSERT DATA INTO CUSTOMER TABLES  
INSERT INTO customers 
VALUES ('U1', 'Pawan Kalyan', '9876543210'),
       ('U2', 'Allu Arjun', '9123456780'),
       ('U3', 'Prabhas', '9988776655'); 

-- CREATE A CLINIC SALES TABLE
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customers(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);
-- CLINIC SALES
INSERT INTO clinic_sales 
VALUES ('O1', 'U1', 'C1', 2000, '2021-10-10', 'Online'),
       ('O2', 'U2', 'C1', 3000, '2021-10-15', 'Offline'),
       ('O3', 'U1', 'C2', 4000, '2021-11-05', 'Online'),
       ('O4', 'U3', 'C2', 2500, '2021-11-20', 'Offline'),
       ('O5', 'U2', 'C3', 3500, '2021-11-25', 'Online'),
       ('O6', 'U3', 'C1', 1500, '2021-12-01', 'Offline'); 

-- CREATE A EXPENSES TABLE 
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(200),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);  
-- INSERT DATA INT0 EXPENSES TABLE 
INSERT INTO expenses 
VALUES ('E1', 'C1', 'Rent', 1000, '2021-10-01'),
       ('E2', 'C1', 'Salary', 1500, '2021-10-15'),
       ('E3', 'C2', 'Supplies', 1200, '2021-11-10'),
       ('E4', 'C2', 'Maintenance', 800, '2021-11-20'),
       ('E5', 'C3', 'Rent', 1000, '2021-11-05'),
       ('E6', 'C1', 'Misc', 500, '2021-12-01'); 
