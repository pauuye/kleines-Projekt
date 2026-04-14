# User Churn Analysis — Excel Dashboard

## Overview
Built an Excel dashboard analyzing customer churn behavior across 178 customers in 4 countries — Philippines, USA, UK, and Unknown. The workbook translates the SQL EDA findings into a visual, pivot-driven dashboard covering churn rate, age group segmentation, country distribution, spending, and watch time patterns.

---

## Problem Statement
After identifying high-risk segments through SQL analysis, the next step was making those findings accessible to non-technical stakeholders. This Excel workbook presents the same insights in a visual format — with interactive pivot charts and a summary narrative that translates data into decisions.

---

## What I Built

### Workbook Structure

| Sheet | Purpose |
|---|---|
| `raw_data_clean_2` | Cleaned dataset with engineered fields — Day, Month, Year, Month Name, Age Bracket |
| `PivotTables` | Source pivots powering the dashboard — monthly churn share, country churn rate & spending, age group watch time & churn rate, KPI aggregates |
| `Dashboard` | Visual dashboard — *User Churn Analysis* |
| `Summary` | Written insights and recommendations per analytical area |

### Dashboard Metrics
- **Overall churn rate** — 30.34% across 178 customers
- **Monthly churn share** — identifies February as the peak churn month, December as the lowest
- **Churn rate by country** — UK highest spender ($2,210 avg); Philippines largest user base
- **Spending by age group** — Mid-career (35–44) leads at $102,451 total monthly spend
- **Watch time vs churn rate by age group** — Early Professionals (25–34) benchmark: highest retention, second highest watch time
- **KPI cards** — Total Customers (178), Average Watch Time (10.84 hrs), Total Churn Rate (30.34%)

---

## Key Findings
- Overall churn rate is **30.34%** — roughly 1 in 3 customers has churned
- **Mid-career (35–44)** is the highest-value at-risk segment — highest total spend AND a 31.5% churn rate
- **Philippines** dominates customer count (~44.94%) but its high absolute churn is a pool-size effect, not necessarily a higher churn rate
- **Early Professionals (25–34)** have the lowest churn rate (13%) and second highest watch time — the strongest retention benchmark segment
- **27 customers** have Unknown country — a data quality gap limiting geographic segmentation accuracy

---

## Excel Skills Demonstrated
`Pivot Tables` · `Pivot Charts` · `GETPIVOTDATA` · `Date Engineering (Day/Month/Year columns)` · `KPI Aggregation` · `Dashboard Design` · `Data Validation`


---

## Tools
- Microsoft Excel
