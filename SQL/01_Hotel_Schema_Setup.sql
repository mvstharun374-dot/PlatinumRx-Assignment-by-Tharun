/*
===============================================================================
DDL Script: Create Hotel Tables
===============================================================================
Script Purpose:
    This script creates tables for the Hotel Management System including
    users, bookings, items, and booking_commercials.

    It defines the database structure and relationships using primary and
    foreign keys.

    Run this script to initialize the hotel database schema and insert
    sample data for testing.
===============================================================================
*/
CREATE DATABASE HotelDB;
GO

USE HotelDB;
GO 
-- CREATION OF USERS TABLE 
CREATE TABLE users ( 
     user_id VARCHAR(50) PRIMARY KEY, 
     name VARCHAR(100), 
     phone_number VARCHAR(20), 
     mail_id VARCHAR(100), 
     billing_address VARCHAR(200) 
); 
-- INSERT DATA INTO THE USERS TABLE 
INSERT INTO users 
VALUES ('U1', 'Tharun', '9951350554', 'mvstharun374@gmail.com', 'Chennai'), 
       ('U2', 'Venkat', '9988776655', 'venkat324@gmail.com', 'Hyderbad'), 
       ('U3', 'Siva',   '9876543210', 'siva123@gmail.com', 'Vijawada') 
-- CREATE A TABLE FOR BOOKINGS 
CREATE TABLE Bookings (
      bookoing_id VARCHAR(50) PRIMARY KEY, 
      booking_date DATETIME, 
      room_no VARCHAR(50), 
      user_id VARCHAR(50), 
      FOREIGN KEY (user_id) REFERENCES users(user_id)  
);  
-- INSERT THE VALUES INTO BOOKING TABLE 
INSERT INTO Bookings 
VALUES  ('B1', '2021-10-10 10:00:00', 'R1', 'U1'),
        ('B2', '2021-10-15 12:00:00', 'R2', 'U2'),
        ('B3', '2021-11-05 14:00:00', 'R3', 'U1'),
        ('B4', '2021-11-20 16:00:00', 'R2', 'U3'),
        ('B5', '2021-12-01 18:00:00', 'R1', 'U2'); 
-- CREATE A TABLE FOR ITEMS 
CREATE TABLE items ( 
    item_id VARCHAR(50) PRIMARY KEY, 
    item_name VARCHAR(100), 
    item_price DECIMAL(10,2) 
);   
-- INSERT VALUES INTO THE ITEMS TABLE
INSERT INTO items   
VALUES  ('I1', 'Chicken Biryani', 200),
        ('I2', 'Veg Biryani', 100),
        ('I3', 'Mutton Biryani', 500);

-- CREATE A TABLE BOOKING COMMERCIALS
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(bookoing_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
); 
-- INSERT VALUES INTO BOOKING COMMERCIALS 
INSERT INTO booking_commercials 
VALUES ('BC1', 'B1', 'BL1', '2021-10-10', 'I1', 3),
       ('BC2', 'B1', 'BL1', '2021-10-10', 'I3', 2),
       ('BC3', 'B2', 'BL2', '2021-10-15', 'I2', 5),
       ('BC4', 'B3', 'BL3', '2021-11-05', 'I3', 4),
       ('BC5', 'B3', 'BL3', '2021-11-05', 'I1', 2),
       ('BC6', 'B4', 'BL4', '2021-11-20', 'I3', 5),
       ('BC7', 'B5', 'BL5', '2021-12-01', 'I1', 1); 
