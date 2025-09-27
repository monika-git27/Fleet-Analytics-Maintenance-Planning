# Fleet-Analytics-Maintenance-Planning
## Overview

This project analyzes SkyFleet’s aircraft fleet using SQL and Tableau to support maintenance planning, spare part forecasting, and operational efficiency improvements. The analysis focuses on fleet composition, age, fuel efficiency, engine type, and retirement planning to provide actionable insights for airline management.

## Objective

The goal of this project is to use SQL-driven analytics to gain deeper insights into SkyFleet’s aircraft dataset. 
The analysis aims to:

* Understand fleet composition and efficiency.

* Identify aircraft models with higher operational and maintenance risks.

* Forecast spare parts demand based on aircraft age, engine type, and efficiency.

* Provide actionable insights to support maintenance planning, fleet modernization, and inventory allocation.

## Dataset

**Table Name:** `aircraft_fleet`

**Key Fields:**

- `Airline`
- `Aircraft_Model`
- `Year_Built`
- `Status` (Active / Retired)
- `Seats`
- `Fuel_Burn_L_hr`
- `Range_km`
- `Engine_Type`


## Exploratory Data Analysis (EDA)

This project provides a comprehensive exploratory data analysis on aircraft fleet data, covering various aspects of fleet status, performance, and business applications.

### Fleet Overview

- **Fleet Status:** Counts of active versus retired aircraft.
- **Fleet Age Distribution:** Average, youngest, and oldest aircraft ages broken down by airline and model.
- **Seating Capacity:** Average, minimum, and maximum seating capacity per aircraft model.
- **Fuel Efficiency:** Fuel burn per seat across active aircraft models.
- **Engine Type Breakdown:** Counts, average age, and average fuel burn by engine type.
- **Range Efficiency:** Range per litre of fuel burned as a proxy for operational efficiency.

### Business Applications

- **Age Group Classification:** Categorization of aircraft into age groups:  
  - New (0–9 years)  
  - Mid-life (10–20 years)  
  - Old (>20 years)
- **Spare Parts Demand Forecast:** Classification of aircraft models into high, medium, and low spare-parts demand categories.
- **Fleet Standardization Index:** Measurement of fleet complexity by airline, based on the number of unique models relative to total aircraft.
- **Retirement Forecast:** Identification of aircraft nearing or due for retirement (20–25+ years).
- **Spare Parts by Age Group:** Linking aircraft age brackets with inventory planning for spare parts.
- **Engine Type Analysis:** Identification of the most common engine types within the active fleet.
- **Fuel Inefficiency & Maintenance Demand:** Highlighting aircraft with high fuel burn that require closer maintenance monitoring.
- **Transitioning Models:** Identification of aircraft models that have both active and retired units.
- **Engine Reliability Risks:** Classification of engine risk levels (Low, Medium, High) based on aircraft age.

## Key Takeaways

- SQL-based analytics can uncover hidden inefficiencies in fleet management.
- The project highlights which models to retire, which to maintain, and where to allocate spare part budgets.
- Results directly support operational cost reduction, safety improvement, and sustainability goals.

