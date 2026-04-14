# User Churn Analysis — MySQL

## Overview
End-to-end MySQL project covering data cleaning and exploratory data analysis on a customer churn dataset of 178 customers across 4 countries. The goal was to identify which customer segments are most at risk of churning and understand the relationship between spending, watch time, age, and churn behavior.

---

## Problem Statement
The raw CSV import arrived with a corrupted column name, string-formatted dates, and blank entries that needed proper null handling. Beyond cleaning, the business needed to understand *who* is churning and *why* — not just the headline churn rate — to inform targeted retention strategies.

---

## What I Did

### Data Cleaning (`clean_data.sql`)
- Fixed a BOM encoding artifact on import: `ï»¿CustomerID` → `CustomerID`
- Converted `SignupDate` from string format (`dd/mm/yyyy`) to proper `DATE` type using `STR_TO_DATE()`
- Set blank `SignupDate` entries explicitly to `NULL` so they are handled correctly in date functions and aggregations
- Created `raw_data_clean_2` as a structured backup table with explicit data types and a `PRIMARY KEY` on `CustomerID` — preserving the original table untouched

### EDA (`churn_eda.sql`)

**Overall Churn Rate**
Calculated the headline churn rate across all customers as the baseline metric for all segment comparisons.

**Country-Level Analysis**
Broke down customer distribution %, churn share, and churn rate per country — distinguishing between absolute churn volume (driven by pool size) and true churn rate (driven by risk). Applied a four-tier risk framework per country.

**Age Group Analysis**
Segmented customers into five age brackets and analyzed churn rate, average watch time, and average spending per group — identifying the highest-value at-risk segments.

**Spending & Watch Time vs Churn**
Cross-analyzed total monthly spend, average watch hours, churn share, and churn rate by both country and age group to test whether higher spending or engagement correlates with lower churn.

**New User Growth Trend**
Month-over-month new signup growth using `LAG()` with `COALESCE` handling null months gracefully.

---

## Key Findings
- Overall churn rate is **30.34%** — roughly 1 in 3 customers has churned
- **Mid-career (35–44)** is the highest-value at-risk segment — highest total monthly spend ($102,451) and a 31.5% churn rate
- **Philippines** dominates customer count (~44.94%) but its high absolute churn is a pool-size effect, not a higher churn rate per customer
- **Early Professionals (25–34)** have the lowest churn rate (13%) and second highest watch time — the strongest retention benchmark
- Higher watch time loosely correlates with lower churn — making it a useful early warning signal
- **27 customers** have Unknown country — a data quality gap that limits geographic segmentation accuracy

---

## Churn Risk Framework

| Churn Rate | Category |
|---|---|
| ≥ 35% | Very High Risk |
| ≥ 30% | High Risk |
| ≥ 25% | Moderate Risk |
| < 25% | Low Risk |

---

## SQL Skills Demonstrated
`CTEs` · `Window Functions` · `LAG()` · `SUM() OVER()` · `CASE WHEN` · `STR_TO_DATE()` · `NULL Handling` · `COALESCE()` · `DATE_FORMAT()` · `Aggregate Functions` · `CREATE TABLE` · `ALTER TABLE`

---

## Tools
- MySQL 8.0+
