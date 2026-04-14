-- MINI PROJECT SQL EDA --
-- -------------------- --
describe raw_data_clean_2;
-- -------------------------------------------------------------------------------- --
-- Counting the Total Customer in the dataset
SELECT
	Count(DISTINCT CustomerID) as TotalCustomer
FROM raw_data_clean_2;
-- -------------------------------------------------------------------------------- --
-- Total Churn Rate
SELECT
    COUNT(*) as TotalCustomer,
	SUM(Churned) as TotalChurn,
    ROUND(SUM(Churned)/COUNT(*)*100,2) as ChurnRate
FROM raw_data_clean_2;
-- -------------------------------------------------------------------------------- --
-- Determining the country with the Highest customer distribution
-- Philippines have the highest customer count of 44.94% (80) of the total customer.
-- There is a 27 with 'Unkown' origings
WITH countries AS (
SELECT
	Country,
    ROUND(SUM(MonthlySpend), 2) as TotalSpent,
    ROUND(AVG(WatchTimeHours), 2) as avg_watched_hours,
    COUNT(CustomerID) as CustomerCount
FROM raw_data_clean_2
GROUP BY Country
)
SELECT
	Country,
    TotalSpent,
    avg_watched_hours,
    CustomerCount,
    CONCAT(ROUND(CustomerCount/SUM(CustomerCount) OVER() * 100, 2), ' %') as User_Distri_Percent
FROM countries
ORDER BY CustomerCount DESC;
-- -------------------------------------------------------------------------------- --
-- Age bracket Customer Distribution Percentage
-- Middle Age (40-54) is the largest signed users with 37.64%
WITH users AS (
SELECT
	CASE
        WHEN Age >= 55 THEN 'Adult (55+)'
        WHEN Age >= 40 THEN 'Middle Age (40-54)'
        WHEN Age >= 30 THEN 'Early Adult (30-39)'
        WHEN Age >= 18 THEN 'Young Adult (18-29)'
    END AS Age_Group,
    ROUND(SUM(MonthlySpend), 2) as TotalSpent,
    ROUND(AVG(WatchTimeHours), 2) as avg_watched_hours,
    COUNT(CustomerID) as CustomerCount
FROM raw_data_clean_2
GROUP BY Age_Group
)
SELECT
	Age_Group,
    TotalSpent,
    avg_watched_hours,
    CustomerCount,
    CONCAT(ROUND(CustomerCount/SUM(CustomerCount) OVER() * 100, 2), ' %') as User_Distri_Percent
FROM users
ORDER BY CustomerCount DESC;
-- -------------------------------------------------------------------------------- --
-- Does spending and watched hours affects the churn rate?
-- The Philippines have the highest spent on the software  with the lowest churn rate but contributes the most share in churning 
-- because of a larger pool of users
WITH rankings AS (
SELECT
	Country,
    ROUND(SUM(MonthlySpend), 2) as TotalSpent,
    ROUND(AVG(WatchTimeHours), 2) AS AvgWatchedHrs,
    COUNT(*) as CustomerCount,
    SUM(Churned) as churn
FROM raw_data_clean_2
GROUP BY Country
),
categorize AS (
	SELECT
		Country,
		TotalSpent,
		AvgWatchedHrs,
		CONCAT(ROUND(churn/SUM(churn) OVER() * 100, 1), ' %') as churn_share,
		CONCAT(ROUND(churn/CustomerCount * 100, 1), ' %') as churn_rate
	FROM rankings
	ORDER BY TotalSpent DESC
)
SELECT
	Country,
	TotalSpent,
	AvgWatchedHrs,
    churn_share,
	churn_rate,
	CASE
		WHEN churn_rate >= 35 THEN 'Very High Risk'
		WHEN churn_rate >= 30 THEN 'High Risk'
		WHEN churn_rate >= 25 THEN 'Moderate Risk'
		ELSE 'Low Risk'
	END AS Category
FROM categorize
ORDER BY churn_rate DESC;
-- -------------------------------------------------------------------------------- --
-- Country with highest churn rate
WITH categorize AS (
	SELECT
		Country,
		COUNT(*) as TotalCustomer,
		SUM(Churned) as TotalChurn,
		ROUND(SUM(Churned)/COUNT(*)*100,2) as ChurnRate
	FROM raw_data_clean_2
	GROUP BY Country
	ORDER BY ChurnRate DESC
)
SELECT
	Country,
    TotalCustomer,
    TotalChurn,
    ChurnRate,
	CASE
		WHEN ChurnRate >= 35 THEN 'Very High Risk'
		WHEN ChurnRate >= 30 THEN 'High Risk'
		WHEN ChurnRate >= 25 THEN 'Moderate Risk'
		ELSE 'Low Risk'
	END AS Category
FROM categorize
ORDER BY ChurnRate DESC;
-- -------------------------------------------------------------------------------- --
-- Young Adult (18-29) use the application for than the others it suggest that they have more free time.
-- Young Adult (18-29) and Middle Age (40-54) have the most users and high churn rate
-- Middle Age (40-54) have the lowest average of watched hours which contributes to the churning.
WITH distribution AS (
SELECT
    CASE
        WHEN Age >= 55 THEN 'Adult (55+)'
        WHEN Age >= 40 THEN 'Middle Age (40-54)'
        WHEN Age >= 30 THEN 'Early Adult (30-39)'
        WHEN Age >= 18 THEN 'Young Adult (18-29)'
    END AS Age_Group,
    ROUND(AVG(WatchTimeHours), 2) AS AvgWatchedHrs,
    ROUND(AVG(MonthlySpend), 2) as Avg_Spending,
    COUNT(*) AS CustomerCount,
    SUM(Churned) as churn
FROM raw_data_clean_2
GROUP BY Age_Group
),
categorize AS (
SELECT
	Age_Group,
	CustomerCount,
    AvgWatchedHrs,
    Avg_Spending,
    CONCAT(ROUND(churn/SUM(churn) OVER() * 100, 1), ' %') as churn_share,
    CONCAT(ROUND(churn/CustomerCount * 100, 1), ' %') as churn_rate
FROM distribution
ORDER BY churn_share DESC
)
SELECT
	Age_Group,
    Avg_Spending,
    AvgWatchedHrs,
    churn_share,
    churn_rate,
    CASE
		WHEN churn_rate >= 35 THEN 'Very High Risk'
		WHEN churn_rate >= 30 THEN 'High Risk'
		WHEN churn_rate >= 25 THEN 'Moderate Risk'
		ELSE 'Low Risk'
	END AS Category
FROM categorize
ORDER BY churn_rate DESC;
-- -------------------------------------------------------------------------------- --
-- Age bracket with highest churn rate
WITH categorize AS (
	SELECT
		CASE
			WHEN Age >= 55 THEN 'Adult (55+)'
			WHEN Age >= 40 THEN 'Middle Age (40-54)'
			WHEN Age >= 30 THEN 'Early Adult (30-39)'
			WHEN Age >= 18 THEN 'Young Adult (18-29)'
		END AS Age_Group,
		COUNT(*) as TotalCustomer,
		SUM(Churned) as TotalChurn,
		ROUND(SUM(Churned)/COUNT(*)*100,2) as ChurnRate
	FROM raw_data_clean_2
	GROUP BY Age_Group
)
SELECT
	Age_Group,
    TotalCustomer,
    TotalChurn,
    ChurnRate,
	CASE
		WHEN ChurnRate >= 35 THEN 'Very High Risk'
		WHEN ChurnRate >= 30 THEN 'High Risk'
		WHEN ChurnRate >= 25 THEN 'Moderate Risk'
		ELSE 'Low Risk'
	END AS Category
FROM categorize
ORDER BY ChurnRate DESC;
-- -------------------------------------------------------------------------------- --
-- New User trend
WITH rt_month AS (
SELECT
	DATE_FORMAT(SignupDate, '%Y-%m') as `Month`,
    COUNT(CustomerID) as TotalCount
FROM raw_data_clean_2
WHERE SignupDate IS NOT NULL
GROUP BY `Month`
)
SELECT
	COALESCE(`Month`, 'Unknown') as `Month`,
    TotalCount,
    CONCAT(ROUND(TotalCount/LAG(TotalCount) OVER(ORDER BY `Month` IS NULL, `Month` ASC ROWS UNBOUNDED PRECEDING)* 100, 2), '%') as user_growth_pct
FROM rt_month;
-- -------------------------------------------------------------------------------- --




























