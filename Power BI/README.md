# Power BI Dashboard — kleines Projekt Churn Analysis

## File
`small_churn.pbix`

## Requirements
- Power BI Desktop (latest version recommended)
- MySQL connection or imported Excel data (`hallo_churn.xlsx`)

---

## Data Source

The dashboard connects to a MySQL table `raw_data_clean_2` with the following fields:

| Field | Type | Description |
|---|---|---|
| CustomerID | VARCHAR | Unique customer ID |
| SignupDate | DATE | Customer signup date |
| Country | TEXT | Customer country |
| Age | INT | Customer age |
| MonthlySpend | DOUBLE | Average monthly spend |
| WatchTimeHours | DOUBLE | Average weekly watch hours |
| Churned | INT | 1 = churned, 0 = retained |

> If you don't have MySQL, you can connect directly to `hallo_churn.xlsx` instead. Go to **Home → Transform data → Data source settings** and update the connection.

---

## Pages

### Page 1 — Dashboard
The main interactive dashboard with slicers and all visuals.

### Page 2 — Summary
Plain-language findings for non-technical stakeholders.

---

## Visuals Explained

### KPI Cards (top row)
| Card | Measure | Notes |
|---|---|---|
| Total Customer | COUNT(CustomerID) | 178 total |
| Total Churn | SUM(Churned) | 54 churned |
| MoM % | Custom DAX measure | Based on signup date month |

> ⚠️ MoM % is calculated from signup date, not activity date. Interpret with caution.

### Average Watch Time v Churn % by Age Bracket
- **Type:** Area + Line combo chart
- **Left axis:** Average WatchTimeHours
- **Right axis:** Churn % (% of grand total)
- **Story:** Shows inverse relationship — age groups that watch less tend to churn more

### Watch Hours v Spending by Age Bracket (Scatter)
- **Type:** Scatter plot
- **X axis:** Average MonthlySpend
- **Y axis:** Average WatchTimeHours
- **Legend:** age_bracket
- **Story:** Mild positive trend — higher spenders tend to watch slightly more

### When Churned Users Originally Signed Up
- **Type:** Bar chart
- **X axis:** Month (name)
- **Y axis:** Churn % of grand total
- **Story:** August had the highest churn cohort (54.55% — 6 of 11 signups)

### Average Spending by Age Bracket
- **Type:** Horizontal bar chart
- **Story:** Early Professionals (25–34) spend the most on average

---

## DAX Measures

### Total Customer
```dax
Total Customer = COUNTROWS(raw_data_clean_2)
```

### Total Churn
```dax
Total Churn = SUM(raw_data_clean_2[Churned])
```

### Churn %
```dax
Churn % = DIVIDE([Total Churn], [Total Customer])
```

### Customer Previous Month
```dax
Customer Previous Month = 
CALCULATE(
    [Total Customer],
    DATEADD(raw_data_clean_2[SignupDate], -1, MONTH)
)
```

### MoM Display (with arrows)
```dax
forPreCustomer = 
VAR _PM = [Customer Previous Month]
VAR _format =
    SWITCH(TRUE(),
        _PM > 0, UNICHAR(11165) & " " & FORMAT(_PM, "0"),
        _PM < 0, UNICHAR(11167) & " " & FORMAT(_PM * -1, "0"),
        FORMAT(_PM, "0")
    )
RETURN _format
```

---

## Slicers

| Slicer | Field | Notes |
|---|---|---|
| Country | Country | Excludes Unknown recommended for cleaner analysis |
| Month | Month Name | Based on SignupDate |

> ⚠️ With 178 customers, combining both slicers will often return 0% for some segments. This is a sample size limitation, not a formula error.

---

## Known Limitations

- Churn date not available — all time-based analysis uses SignupDate as proxy
- 27 customers with unknown country are included in totals but distort country-level analysis
- MoM % can behave unexpectedly with small monthly counts
- % of Grand Total recalculates when filters are applied — use with care

---

## How to Refresh

1. Open `small_churn.pbix` in Power BI Desktop
2. Go to **Home → Refresh**
3. If prompted, update credentials for your MySQL or Excel connection
