/*
===============================================================================
SQL Script: Clinic Data Analysis Queries
===============================================================================
Script Purpose:
    This script contains SQL queries to analyze clinic data.

    It includes:
    - Revenue by sales channel
    - Top customers
    - Monthly profit/loss analysis
    - Most profitable clinics
    - Least profitable clinics

    Run this script after schema setup to generate insights.
===============================================================================
*/ 
-- SOLVING QUESTIONS 
-- Q1: Revenue by sales channel (year = 2021) 
SELECT 
    sales_channel,
    SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel; 

-- Q2: Top 10 valuable customers 
SELECT TOP 10
    uid,
    SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC; 


-- Q3: Month-wise revenue, expense, profit, status
SELECT 
    s.month,
    s.revenue,
    e.expense,
    (s.revenue - e.expense) AS profit,
    CASE 
        WHEN (s.revenue - e.expense) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM 
    (SELECT MONTH(datetime) AS month, SUM(amount) AS revenue
     FROM clinic_sales
     WHERE YEAR(datetime) = 2021
     GROUP BY MONTH(datetime)) s
JOIN 
    (SELECT MONTH(datetime) AS month, SUM(amount) AS expense
     FROM expenses
     WHERE YEAR(datetime) = 2021
     GROUP BY MONTH(datetime)) e
ON s.month = e.month; 

-- Q4: Most profitable clinic per city (example: November) 
SELECT *
FROM (
    SELECT 
        c.city,
        c.cid,
        SUM(cs.amount) - ISNULL(SUM(e.amount),0) AS profit,
        RANK() OVER (
            PARTITION BY c.city 
            ORDER BY SUM(cs.amount) - ISNULL(SUM(e.amount),0) DESC
        ) AS rnk
    FROM clinics c
    JOIN clinic_sales cs ON c.cid = cs.cid
    LEFT JOIN expenses e ON c.cid = e.cid 
        AND MONTH(e.datetime) = 11
    WHERE MONTH(cs.datetime) = 11 AND YEAR(cs.datetime) = 2021
    GROUP BY c.city, c.cid
) t
WHERE rnk = 1;
