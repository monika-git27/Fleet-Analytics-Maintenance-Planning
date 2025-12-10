# Fleet-Analytics-Maintenance-Planning
## Project Overview

This project builds a complete fleet analytics system to help airlines monitor aircraft performance, identify high-risk assets, optimize maintenance planning, and improve operational decision-making.

The project includes:

- A cleaned and validated aviation dataset
- More than 30 SQL analyses for fleet health, efficiency, risk, and spare-parts demand
- A Power BI dashboard that provides executive-level insights
- Predictive indicators such as retirement forecast, spare-parts demand categories, and efficiency rankings
## Key Insights & KPIs (Power BI Dashboard)

### Top Summary KPIs
- Total Aircraft: **50**
- Active Aircraft: **22**
- Average Fuel Burn per Seat: **25.55**
- Average Fleet Age: **15.34 years**
- High-Risk Aircraft: **18**

### Dashboard Visuals
![Fleet Performance Dashboard](https://github.com/monika-git27/Fleet-Analytics-Maintenance-Planning/blob/main/Dashboard.png)
- Fleet Count by Aircraft Model
- Fuel Efficiency Ranking
- Fleet Status (Active, Retired, Under Maintenance)
- Spare Parts Demand Classification
- Aircraft Age Distribution
- Retirement Forecast (Immediate, Near, Healthy)

---

## Data Cleaning and Quality Checks

The project uses SQL to perform structured data validation, including:

- Duplicate aircraft checks
- Missing value identification
- Invalid year and date detection
- Fuel burn, seat count, and numeric validations
- Verification of valid status categories

All SQL quality checks and analytics queries are included in the project SQL file.

---

## Exploratory Data Analysis (SQL)

The SQL analysis includes:

- Fleet status breakdown
- Aircraft model–wise age distribution
- Fuel burn per seat analysis
- Engine type analysis and reliability insights
- Seating capacity comparison
- Range efficiency calculations

---

## Business and Maintenance Analytics

### Age-Based Aircraft Classification

Aircraft are categorized into age groups:

- New (0–9 years)
- Mid-life (10–20 years)
- Old (more than 20 years)

### Spare Parts Demand Forecast

Demand categories are assigned using:

- Average aircraft age
- Fuel burn per seat
- Operational usage intensity

Categories include **High**, **Medium**, and **Low** demand.

### Retirement Forecasting

Retirement decisions are analyzed using age thresholds:

- Immediate Retirement: Older than 25 years
- Near Retirement: 20–25 years
- Active / Healthy: Less than 20 years

### Engine Reliability Risk Model

Aircraft engines are classified into **Low**, **Medium**, or **High** reliability risk levels based on age and condition metrics.

---

## Skills and Tools Used

- SQL (data validation, EDA, analytical modeling)
- Power BI, Tableau (KPI visualization, trend dashboards, slicers, DAX expressions)
- Data cleaning and preprocessing
- Aviation fleet analytics and domain KPIs
- Predictive categorization for maintenance and risk
