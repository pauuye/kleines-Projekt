# kleines Projekt: Customer Churn Analysis

An end-to-end churn analysis project covering data cleaning, exploratory data analysis in SQL, and an interactive dashboard built in Power BI.

---

## Project Overview

This project analyzes customer churn behavior for a subscription-based streaming service with 178 customers across 4 countries. The goal is to identify which customer segments are most at risk of churning and surface patterns around spending, watch time, and signup trends.

**Overall churn rate: 30.34% (54 out of 178 customers)**

---

## Tools Used

| Tool | Purpose |
|---|---|
| MySQL | Data cleaning & exploratory data analysis |
| Microsoft Excel | Initial data exploration & pivot analysis |
| Power BI | Interactive dashboard & summary insights |

---

## Repository Structure

```
Hulu it me/
│
├── data/
│   ├── messy_customer_data.csv    # Messy dataset
│   └── raw_data_clean.csv         # Clean dataset
│
├── Power BI/
│   ├── icons/                     # Custom icons used in Power BI visuals
│       ├── churn-rate by Freepik.png       
│       └── customer by Freepik.png 
│   ├── Screenshots/               # Dashboard screenshots
│       ├── Dashboard.png      
│       └── Summary.png 
│   ├── small_churn.pbix           # Power BI dashboard file
│   └── README.md                  # Power BI documentation
│
├── Excel/
│   ├── Screenshots/               # Excel screenshots
│       ├── Dashboard.png      
│       └── Summary.png
│   ├── hallo_churn.xlsx           # Raw dataset & pivot analysis
│   └── README.md                  # MS Excel documentation
│
├── MySQL/
│   ├── Screenshots/               # MySQL screenshots
│       ├── age_bracket_churn.png
│       ├── country_churn.png      
│       └── cleaning.png 
│   ├── clean_data.sql             # Data cleaning & table setup
│   ├── churn_eda.sql              # Exploratory data analysis queries
│   └── README.md                  # MySQL documentation
│
└── README.md                      # This file
```

---

## Dataset

| Column | Type | Description |
|---|---|---|
| `CustomerID` | VARCHAR | Unique customer identifier |
| `SignupDate` | DATE | Date the customer signed up |
| `Country` | TEXT | Customer country (Philippines, UK, USA, Unknown) |
| `Age` | INT | Customer age |
| `MonthlySpend` | DOUBLE | Average monthly spend |
| `WatchTimeHours` | DOUBLE | Average weekly watch time in hours |
| `Churned` | INT | Binary flag — 1 = churned, 0 = retained |

> **Note:** 27 customers have an 'Unknown' country value, indicating a data collection gap at signup.

---

## Data Cleaning (`clean_data.sql`)

- Fixed malformed column name (`ï»¿CustomerID` → `CustomerID`) caused by CSV encoding issue
- Converted `SignupDate` from string to proper `DATE` format using `STR_TO_DATE()`
- Set empty signup dates to `NULL`
- Created a backup table `raw_data_clean_2` for safe EDA

---

## SQL EDA Highlights (`churn_eda.sql`)

### Overall Churn
- 54 out of 178 customers churned — **30.34% churn rate**

### Churn by Country
| Country | Customers | Churn Rate | Risk Level |
|---|---|---|---|
| Unknown | 27 | ~38% | Very High Risk |
| UK | ~40 | ~30% | Moderate Risk |
| USA | ~31 | ~27% | Low Risk |
| Philippines | 80 | ~28% | Low Risk |

> Philippines contributes the most churned users in absolute numbers due to pool size, not a higher individual rate.

### Churn by Age Group
| Age Group | Risk Level |
|---|---|
| Mid-career (35–44) | High Risk — 31.48% of all churns |
| Young Adults (18–24) | Moderate Risk — 22.22% |
| Experienced Professionals (45–54) | Moderate Risk — 18.52% |
| Late Career (55–64) | Low Risk — 14.81% |
| Early Professionals (25–34) | Lowest Risk — 12.96% |

### Signup Cohort Churn
- August cohort had the highest churn rate — 6 of 11 August signups churned (54.55%)
- December cohort had the lowest — 7.69%

---

## Key Findings

1. **Mid-career (35–44) churn the most** — 31.48% of all churns despite moderate spending
2. **Early Professionals (25–34) are the best segment** — highest avg spend (₱2,280/month), lowest churn
3. **Watch time predicts churn** — lower watch hours consistently correlates with higher churn across all brackets
4. **August cohort is the most at-risk** — 54.55% cohort churn rate
5. **Unknown country customers churn disproportionately** — a data collection gap worth fixing at signup

---

## Power BI Dashboard

Two pages:
- **HR Dashboard** — interactive visuals with Country and Month slicers
- **Summary Insight** — plain-language findings and recommendations for stakeholders

See `Power BI/README.md` for full documentation of visuals, DAX measures, and known limitations.

---

## Limitations

- Small dataset (178 customers) — findings are directional, not statistically conclusive
- No actual churn date available — signup date used as time proxy for all cohort analysis
- 27 customers with unknown country reduce geographic accuracy
- Combined Country + Month filters may show 0% for some segments due to small cell sizes

---

## How to Run

### MySQL
1. Import `hallo_churn.xlsx` into MySQL as `raw_data_clean`
2. Run `clean_data.sql` to clean and set up the tables
3. Run `churn_eda.sql` for exploratory analysis

### Power BI
1. Open `small_churn.pbix` in Power BI Desktop
2. Update the data source connection to your MySQL instance if needed
3. Click **Home → Refresh**

---

## Author

hireme,bitte.
kleines Projekt, a personal end-to-end analytics project covering SQL, Excel, and Power BI.
