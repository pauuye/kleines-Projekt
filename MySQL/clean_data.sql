use churn;
-- --------------------------------------------------------------- --
explain raw_data_clean;
describe raw_data_clean;
-- --------------------------------------------------------------- --
ALTER TABLE raw_data_clean
CHANGE COLUMN `ï»¿CustomerID`  CustomerID VARCHAR(255);
-- --------------------------------------------------------------- --
ALTER TABLE raw_data_clean
MODIFY COLUMN SignupDate DATE;
-- --------------------------------------------------------------- --
UPDATE raw_data_clean
SET SignupDate = STR_TO_DATE(SignupDate, '%d/%m/%Y');
-- --------------------------------------------------------------- --
UPDATE raw_data_clean
SET SignupDate = null
WHERE SignupDate = ''
	OR SignupDate IS NULL;
-- --------------------------------------------------------------- --
SELECT
	*
FROM raw_data_clean;
-- --------------------------------------------------------------- --
-- CREATING COPY OF THE DATASET FOR BACKUP --
CREATE TABLE `raw_data_clean_2` (
  `CustomerID` varchar(255) NOT NULL,
  `SignupDate` date DEFAULT NULL,
  `Country` text,
  `Age` int DEFAULT NULL,
  `MonthlySpend` double DEFAULT NULL,
  `Churned` int DEFAULT NULL,
  `WatchTimeHours` double DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- --------------------------------------------------------------- --
INSERT INTO raw_data_clean_2
SELECT
	*
FROM raw_data_clean;
-- --------------------------------------------------------------- --
DESCRIBE raw_data_clean_2;
-- --------------------------------------------------------------- --
SELECT
	*
FROM raw_data_clean_2;
-- --------------------------------------------------------------- --
