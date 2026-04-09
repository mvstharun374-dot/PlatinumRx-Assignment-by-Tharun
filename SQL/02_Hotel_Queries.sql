/*
===============================================================================
SQL Script: Hotel Data Analysis Queries
===============================================================================
Script Purpose:
    This script contains SQL queries to analyze hotel booking data.

    It includes:
    - Last booked room per user
    - Monthly billing calculations
    - High-value bill filtering
    - Most and least ordered items
    - Second highest billing customers

    Run this script after schema setup to generate insights.
===============================================================================
*/


-- SOLVING QUESTIONS 
-- Q1 Find the (Last booked room): 
SELECT user_id, room_no
FROM (
    SELECT 
        user_id,
        room_no,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
    FROM bookings
) t
WHERE rn = 1; 

-- Q2 Find the  (Billing in Nov 2021):  
SELECT 
    b.bookoing_id,
    SUM(bc.item_quantity * i.item_price) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.bookoing_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11 AND YEAR(b.booking_date) = 2021
GROUP BY b.bookoing_id 

-- Q3: Find the Bills in October > 1000 
SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_price) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_price) > 1000; 

-- Q4 Find the Most & Least ordered item per month 
SELECT *
FROM (
    SELECT 
        MONTH(bc.bill_date) AS month,
        i.item_name,
        SUM(bc.item_quantity) AS total_qty,
        RANK() OVER (PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity) DESC) AS rnk_desc,
        RANK() OVER (PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity) ASC) AS rnk_asc
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), i.item_name
) t
WHERE rnk_desc = 1 OR rnk_asc = 1; 

-- Q5 find the customers Customers with 2nd highest bill per month 
SELECT *
FROM (
    SELECT 
        MONTH(bc.bill_date) AS month,
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_price) AS bill_amount,
        RANK() OVER (
            PARTITION BY MONTH(bc.bill_date)
            ORDER BY SUM(bc.item_quantity * i.item_price) DESC
        ) AS rnk
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.bookoing_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), b.user_id, bc.bill_id
) t
WHERE rnk = 2;  
