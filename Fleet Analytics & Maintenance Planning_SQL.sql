CREATE TABLE aircraft_fleet (
    Airline VARCHAR(100),
    Aircraft_Model VARCHAR(100),
    Registration_ID VARCHAR(50) PRIMARY KEY,
    Year_Built INT,
    Seats INT,
    Engine_Type VARCHAR(100),
    Range_km INT,
    Fuel_Burn_L_hr INT,
    Status VARCHAR(50)
);


-- Data Quality Check
-- Check for Duplicate Aircraft (by Registration_ID)
SELECT Registration_ID, COUNT(*) AS cnt
FROM aircraft_fleet
GROUP BY Registration_ID
HAVING COUNT(*) > 1;

-- Check for Missing Values
SELECT
    SUM(CASE WHEN Airline IS NULL OR Airline = '' THEN 1 ELSE 0 END) AS missing_airline,
    SUM(CASE WHEN Aircraft_Model IS NULL OR Aircraft_Model = '' THEN 1 ELSE 0 END) AS missing_model,
    SUM(CASE WHEN Registration_ID IS NULL OR Registration_ID = '' THEN 1 ELSE 0 END) AS missing_reg,
    SUM(CASE WHEN Year_Built IS NULL THEN 1 ELSE 0 END) AS missing_year,
    SUM(CASE WHEN Seats IS NULL THEN 1 ELSE 0 END) AS missing_seats,
    SUM(CASE WHEN Engine_Type IS NULL OR Engine_Type = '' THEN 1 ELSE 0 END) AS missing_engine,
    SUM(CASE WHEN Range_km IS NULL THEN 1 ELSE 0 END) AS missing_range,
    SUM(CASE WHEN Fuel_Burn_L_hr IS NULL THEN 1 ELSE 0 END) AS missing_fuel,
    SUM(CASE WHEN Status IS NULL OR Status = '' THEN 1 ELSE 0 END) AS missing_status
FROM aircraft_fleet;

-- Check for Invalid Year_Built
SELECT *
FROM aircraft_fleet
WHERE Year_Built < 1950 OR Year_Built > 2025;

-- Check for Negative or Zero Numeric Values
SELECT *
FROM aircraft_fleet
WHERE Seats <= 0 OR Range_km <= 0 OR Fuel_Burn_L_hr <= 0;

-- Check for Inconsistent Status Values
SELECT DISTINCT Status
FROM aircraft_fleet;


-- Exploratory Data Analysis
-- 1. Fleet Status (Active vs Retired)
SELECT Status, COUNT(*) AS Aircraft_Count
FROM aircraft_fleet
GROUP BY Status;

-- 2. Fleet Age Distribution
SELECT Airline, Aircraft_Model,
       AVG(2025 - Year_Built) AS Avg_Age,
       MIN(2025 - Year_Built) AS Youngest,
       MAX(2025 - Year_Built) AS Oldest
FROM aircraft_fleet
GROUP BY Airline, Aircraft_Model
ORDER BY Avg_Age DESC;

-- 3.	Seating Capacity by Model
SELECT Aircraft_Model, 
       AVG(Seats) AS Avg_Seats,
       MIN(Seats) AS Min_Seats,
       MAX(Seats) AS Max_Seats
FROM aircraft_fleet
GROUP BY Aircraft_Model
ORDER BY Avg_Seats DESC;


-- 4.	Fuel Efficiency (Burn per Seat)
SELECT Aircraft_Model,
       ROUND(AVG(Fuel_Burn_L_hr * 1.0 / Seats),2) AS Fuel_Burn_Per_Seat
FROM aircraft_fleet
WHERE Status = 'Active'
GROUP BY Aircraft_Model
ORDER BY Fuel_Burn_Per_Seat DESC;


-- 5.	Engine Type Breakdown
SELECT Engine_Type, COUNT(*) AS Count,
       ROUND(AVG(2025 - Year_Built),1) AS Avg_Age,
       ROUND(AVG(Fuel_Burn_L_hr),1) AS Avg_Fuel_Burn
FROM aircraft_fleet
GROUP BY Engine_Type
ORDER BY Count DESC;

-- 6. Range Efficiency (km per Litre burned)
SELECT Aircraft_Model,
       ROUND(AVG(Range_km * 1.0 / Fuel_Burn_L_hr),2) AS Range_Efficiency
FROM aircraft_fleet
WHERE Status = 'Active'
GROUP BY Aircraft_Model
ORDER BY Range_Efficiency ASC;

-- Fleet Age Percentile Analysis (Window Function)
WITH AgeRank AS (
    SELECT 
        Registration_ID,
        Aircraft_Model,
        (2025 - Year_Built) AS Age,
        PERCENT_RANK() OVER (ORDER BY (2025 - Year_Built) DESC) AS Age_Percentile
    FROM skyfleet_aircraft_dataset
)
SELECT *
FROM AgeRank
WHERE Age_Percentile <= 0.10;



-- Business Application (Maintenance & Spare Part Forecast)

-- 1.	Classify Aircraft by Age Group
SELECT Airline, Aircraft_Model,
       CASE 
           WHEN 2025 - Year_Built < 10 THEN 'New (0-9 yrs)'
           WHEN 2025 - Year_Built BETWEEN 10 AND 20 THEN 'Mid-life (10-20 yrs)'
           ELSE 'Old (>20 yrs)'
       END AS Age_Group,
       COUNT(*) AS Aircraft_Count
FROM aircraft_fleet
GROUP BY Airline, Aircraft_Model, Age_Group
ORDER BY Age_Group DESC, Aircraft_Count DESC;

-- 2.	Spare Parts Demand Forecast (Proxy)
WITH FleetRisk AS (
    SELECT Airline, Aircraft_Model,
           2025 - Year_Built AS Age,
           ROUND(Fuel_Burn_L_hr * 1.0 / Seats,2) AS Fuel_Burn_Per_Seat
    FROM aircraft_fleet
    WHERE Status = 'Active'
)
SELECT Airline, Aircraft_Model,
       COUNT(*) AS Aircraft_Count,
       ROUND(AVG(Age),1) AS Avg_Age,
       ROUND(AVG(Fuel_Burn_Per_Seat),2) AS Avg_Fuel_Burn_Per_Seat,
       CASE 
           WHEN AVG(Age) > 15 AND AVG(Fuel_Burn_Per_Seat) > 30 THEN 'High Demand'
           WHEN AVG(Age) BETWEEN 10 AND 15 THEN 'Medium Demand'
           ELSE 'Low Demand'
       END AS Spare_Part_Demand_Category
FROM FleetRisk
GROUP BY Airline, Aircraft_Model
ORDER BY Spare_Part_Demand_Category DESC, Avg_Age DESC;


-- 3.	Airline Fleet Standardization (Complexity Index)
SELECT Airline,
       COUNT(DISTINCT Aircraft_Model) AS Unique_Models,
       COUNT(*) AS Total_Aircraft,
       ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT Aircraft_Model),2) AS Aircraft_Per_Model
FROM aircraft_fleet
GROUP BY Airline
ORDER BY Unique_Models DESC;

-- 4.	Aircraft Retirement Forecast (based on Age Thresholds)
SELECT Airline, Aircraft_Model,
       COUNT(*) FILTER (WHERE 2025 - Year_Built > 25) AS Immediate_Retirement,
       COUNT(*) FILTER (WHERE 2025 - Year_Built BETWEEN 20 AND 25) AS Near_Retirement,
       COUNT(*) FILTER (WHERE 2025 - Year_Built < 20) AS Active_Healthy
FROM aircraft_fleet
GROUP BY Airline, Aircraft_Model
ORDER BY Immediate_Retirement DESC;


-- 5.	Spare Part Demand by Age Group
SELECT CASE
           WHEN 2025 - Year_Built < 10 THEN 'New (<10 yrs)'
           WHEN 2025 - Year_Built BETWEEN 10 AND 20 THEN 'Mid-life (10-20 yrs)'
           ELSE 'Old (>20 yrs)'
       END AS Age_Group,
       COUNT(*) AS Aircraft_Count
FROM aircraft_fleet
WHERE Status = 'Active'
GROUP BY Age_Group;

-- 6.	Engine Type & Spare Part Planning
SELECT Engine_Type, COUNT(*) AS Aircraft_Count
FROM aircraft_fleet
WHERE Status = 'Active'
GROUP BY Engine_Type
ORDER BY Aircraft_Count DESC;

-- 7. Fuel Inefficiency & Maintenance Demand
SELECT Airline, Aircraft_Model,
       ROUND(AVG(Fuel_Burn_L_hr),0) AS Avg_Fuel_Burn,
       ROUND(AVG(Range_km),0) AS Avg_Range
FROM aircraft_fleet
WHERE Status = 'Active'
GROUP BY Airline, Aircraft_Model
ORDER BY Avg_Fuel_Burn DESC;

-- 8.	Aircraft Retirement Forecast
SELECT Airline, Aircraft_Model,
       COUNT(*) FILTER (WHERE 2025 - Year_Built > 25) AS Immediate_Retirement,
       COUNT(*) FILTER (WHERE 2025 - Year_Built BETWEEN 20 AND 25) AS Near_Retirement,
       COUNT(*) FILTER (WHERE 2025 - Year_Built < 20) AS Active_Healthy
FROM aircraft_fleet
GROUP BY Airline, Aircraft_Model
ORDER BY Immediate_Retirement DESC;


--9. Transition Fleet Models (CTE + DISTINCT + Join Handling)
WITH Transition AS (
    SELECT DISTINCT Aircraft_Model
    FROM skyfleet_aircraft_dataset a
    JOIN skyfleet_aircraft_dataset b
        ON a.Aircraft_Model = b.Aircraft_Model
    WHERE a.Status = 'Active'
      AND b.Status = 'Retired'
)
SELECT 
    t.Aircraft_Model,
    COUNT(CASE WHEN s.Status = 'Active' THEN 1 END) AS Active_Count,
    COUNT(CASE WHEN s.Status = 'Retired' THEN 1 END) AS Retired_Count
FROM Transition t
JOIN skyfleet_aircraft_dataset s
    ON t.Aircraft_Model = s.Aircraft_Model
GROUP BY t.Aircraft_Model;



--10. Engine Reliability Risk by Age
WITH EngineRisk AS (
    SELECT 
        Aircraft_Model,
        Engine_Type,
        (2025 - Year_Built) AS Age,
        CASE 
            WHEN (2025 - Year_Built) > 20 THEN 'High Risk'
            WHEN (2025 - Year_Built) BETWEEN 10 AND 20 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Level
    FROM skyfleet_aircraft_dataset
    WHERE Status = 'Active'
)
SELECT 
    Engine_Type,
    Risk_Level,
    COUNT(*) AS Aircraft_Count
FROM EngineRisk
GROUP BY Engine_Type, Risk_Level
ORDER BY Engine_Type, Risk_Level;

