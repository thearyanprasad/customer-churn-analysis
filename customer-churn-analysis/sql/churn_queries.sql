USE customer_churn;
SELECT COUNT(*) FROM churn;

-- Churn by Contract Type
SELECT
    Contract,
    COUNT(*) AS Customers,
    ROUND(AVG(Churn) * 100, 2) AS ChurnRate
FROM churn
GROUP BY Contract
ORDER BY ChurnRate DESC;

-- Churn by Payment Method
SELECT
    PaymentMethod,
    COUNT(*) AS Customers,
    ROUND(AVG(Churn) * 100, 2) AS ChurnRate
FROM churn
GROUP BY PaymentMethod
ORDER BY ChurnRate DESC;

-- Monthly Revenue at Risk
SELECT
    ROUND(SUM(MonthlyCharges), 2) AS MonthlyRevenueLost
FROM churn
WHERE Churn = 1;

-- Churn by Internet Service
SELECT
    InternetService,
    COUNT(*) AS Customers,
    ROUND(AVG(Churn) * 100, 2) AS ChurnRate
FROM churn
GROUP BY InternetService
ORDER BY ChurnRate DESC;

-- Churn by Tenure Group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS TenureGroup,
    COUNT(*) AS Customers,
    ROUND(AVG(Churn) * 100, 2) AS ChurnRate
FROM churn
GROUP BY TenureGroup
ORDER BY ChurnRate DESC;

-- Contract + Internet Service Risk
SELECT
    Contract,
    InternetService,
    COUNT(*) AS Customers,
    ROUND(AVG(Churn) * 100, 2) AS ChurnRate
FROM churn
GROUP BY Contract, InternetService
HAVING COUNT(*) > 50
ORDER BY ChurnRate DESC;

-- Contract + Payment Method Risk
SELECT
    Contract,
    PaymentMethod,
    COUNT(*) AS Customers,
    ROUND(AVG(Churn) * 100, 2) AS ChurnRate
FROM churn
GROUP BY Contract, PaymentMethod
HAVING COUNT(*) > 30
ORDER BY ChurnRate DESC
LIMIT 10;