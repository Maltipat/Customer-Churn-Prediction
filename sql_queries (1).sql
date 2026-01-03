-- ============================================================================
-- BANK CUSTOMER CHURN ANALYSIS - SQL QUERIES
-- ============================================================================
-- Database: bank_churn.db
-- Table: customers
-- Total Records: 10,000 customers
-- ============================================================================

-- ============================================================================
-- 1. DATA OVERVIEW & BASIC STATISTICS
-- ============================================================================

-- 1.1 View table structure
SELECT sql FROM sqlite_master WHERE name = 'customers';

-- 1.2 Total customers and churn overview
SELECT 
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    COUNT(*) - SUM(churn) AS retained_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers;

-- 1.3 Sample data
SELECT * FROM customers LIMIT 10;


-- ============================================================================
-- 2. CHURN ANALYSIS BY DEMOGRAPHICS
-- ============================================================================

-- 2.1 Churn rate by country
SELECT 
    country,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY country
ORDER BY churn_rate_percentage DESC;

-- 2.2 Churn rate by gender
SELECT 
    gender,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY gender
ORDER BY churn_rate_percentage DESC;

-- 2.3 Churn rate by age group
SELECT 
    CASE 
        WHEN age < 30 THEN '18-29'
        WHEN age < 40 THEN '30-39'
        WHEN age < 50 THEN '40-49'
        WHEN age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage,
    ROUND(AVG(age), 1) AS avg_age
FROM customers
GROUP BY age_group
ORDER BY 
    CASE age_group
        WHEN '18-29' THEN 1
        WHEN '30-39' THEN 2
        WHEN '40-49' THEN 3
        WHEN '50-59' THEN 4
        ELSE 5
    END;


-- ============================================================================
-- 3. CHURN ANALYSIS BY ACCOUNT CHARACTERISTICS
-- ============================================================================

-- 3.1 Churn rate by number of products
SELECT 
    products_number,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY products_number
ORDER BY products_number;

-- 3.2 Churn rate by credit card ownership
SELECT 
    CASE WHEN credit_card = 1 THEN 'Has Credit Card' ELSE 'No Credit Card' END AS credit_card_status,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY credit_card_status
ORDER BY churn_rate_percentage DESC;

-- 3.3 Churn rate by active membership
SELECT 
    CASE WHEN active_member = 1 THEN 'Active Member' ELSE 'Inactive Member' END AS membership_status,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY membership_status
ORDER BY churn_rate_percentage DESC;

-- 3.4 Churn rate by tenure (years with bank)
SELECT 
    tenure,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY tenure
ORDER BY tenure;

-- 3.5 Churn rate by balance range
SELECT 
    CASE 
        WHEN balance = 0 THEN 'Zero Balance'
        WHEN balance < 50000 THEN 'Low (1-49K)'
        WHEN balance < 100000 THEN 'Medium (50-99K)'
        WHEN balance < 150000 THEN 'High (100-149K)'
        ELSE 'Very High (150K+)'
    END AS balance_range,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage,
    ROUND(AVG(balance), 2) AS avg_balance
FROM customers
GROUP BY balance_range
ORDER BY 
    CASE balance_range
        WHEN 'Zero Balance' THEN 1
        WHEN 'Low (1-49K)' THEN 2
        WHEN 'Medium (50-99K)' THEN 3
        WHEN 'High (100-149K)' THEN 4
        ELSE 5
    END;


-- ============================================================================
-- 4. CREDIT SCORE ANALYSIS
-- ============================================================================

-- 4.1 Churn rate by credit score range
SELECT 
    CASE 
        WHEN credit_score < 500 THEN 'Poor (< 500)'
        WHEN credit_score < 600 THEN 'Fair (500-599)'
        WHEN credit_score < 700 THEN 'Good (600-699)'
        WHEN credit_score < 800 THEN 'Very Good (700-799)'
        ELSE 'Excellent (800+)'
    END AS credit_score_range,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage,
    ROUND(AVG(credit_score), 1) AS avg_credit_score
FROM customers
GROUP BY credit_score_range
ORDER BY 
    CASE credit_score_range
        WHEN 'Poor (< 500)' THEN 1
        WHEN 'Fair (500-599)' THEN 2
        WHEN 'Good (600-699)' THEN 3
        WHEN 'Very Good (700-799)' THEN 4
        ELSE 5
    END;

-- 4.2 Average credit score by churn status
SELECT 
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS customer_status,
    ROUND(AVG(credit_score), 1) AS avg_credit_score,
    MIN(credit_score) AS min_credit_score,
    MAX(credit_score) AS max_credit_score
FROM customers
GROUP BY churn;


-- ============================================================================
-- 5. SALARY ANALYSIS
-- ============================================================================

-- 5.1 Churn rate by salary range
SELECT 
    CASE 
        WHEN estimated_salary < 50000 THEN 'Low (< 50K)'
        WHEN estimated_salary < 100000 THEN 'Medium (50-100K)'
        WHEN estimated_salary < 150000 THEN 'High (100-150K)'
        ELSE 'Very High (150K+)'
    END AS salary_range,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage,
    ROUND(AVG(estimated_salary), 2) AS avg_salary
FROM customers
GROUP BY salary_range
ORDER BY 
    CASE salary_range
        WHEN 'Low (< 50K)' THEN 1
        WHEN 'Medium (50-100K)' THEN 2
        WHEN 'High (100-150K)' THEN 3
        ELSE 4
    END;


-- ============================================================================
-- 6. MULTI-DIMENSIONAL ANALYSIS
-- ============================================================================

-- 6.1 Churn rate by country and gender
SELECT 
    country,
    gender,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY country, gender
ORDER BY country, churn_rate_percentage DESC;

-- 6.2 Churn rate by products and active membership
SELECT 
    products_number,
    CASE WHEN active_member = 1 THEN 'Active' ELSE 'Inactive' END AS membership_status,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
GROUP BY products_number, membership_status
ORDER BY products_number, churn_rate_percentage DESC;

-- 6.3 High-risk customer profile (Germany, Female, Age 40+, Inactive)
SELECT 
    COUNT(*) AS high_risk_customers,
    SUM(churn) AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
WHERE country = 'Germany' 
    AND gender = 'Female' 
    AND age >= 40 
    AND active_member = 0;


-- ============================================================================
-- 7. CUSTOMER SEGMENTATION
-- ============================================================================

-- 7.1 Customers with zero balance
SELECT 
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS status,
    COUNT(*) AS customers_with_zero_balance,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers WHERE balance = 0), 2) AS percentage_of_zero_balance
FROM customers
WHERE balance = 0
GROUP BY churn;

-- 7.2 Customers with 3+ products (potential upsell targets or at-risk)
SELECT 
    products_number,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers
WHERE products_number >= 3
GROUP BY products_number
ORDER BY products_number;

-- 7.3 Long-tenure customers (10 years)
SELECT 
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS status,
    COUNT(*) AS long_tenure_customers,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(balance), 2) AS avg_balance
FROM customers
WHERE tenure = 10
GROUP BY churn;


-- ============================================================================
-- 8. KEY INSIGHTS & RISK FACTORS
-- ============================================================================

-- 8.1 Top 10 characteristics of churned customers
SELECT 
    'Germany customers' AS characteristic,
    ROUND(SUM(CASE WHEN country = 'Germany' THEN 1 ELSE 0 END) * 100.0 / SUM(churn), 2) AS percentage_of_churned
FROM customers
WHERE churn = 1
UNION ALL
SELECT 
    'Female customers',
    ROUND(SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) * 100.0 / SUM(churn), 2)
FROM customers
WHERE churn = 1
UNION ALL
SELECT 
    'Inactive members',
    ROUND(SUM(CASE WHEN active_member = 0 THEN 1 ELSE 0 END) * 100.0 / SUM(churn), 2)
FROM customers
WHERE churn = 1
UNION ALL
SELECT 
    'Age 40+',
    ROUND(SUM(CASE WHEN age >= 40 THEN 1 ELSE 0 END) * 100.0 / SUM(churn), 2)
FROM customers
WHERE churn = 1
UNION ALL
SELECT 
    'Balance > 100K',
    ROUND(SUM(CASE WHEN balance > 100000 THEN 1 ELSE 0 END) * 100.0 / SUM(churn), 2)
FROM customers
WHERE churn = 1;

-- 8.2 Customer retention comparison (Active vs Inactive members)
SELECT 
    CASE WHEN active_member = 1 THEN 'Active Members' ELSE 'Inactive Members' END AS membership_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) AS retained,
    SUM(churn) AS churned,
    ROUND(SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS retention_rate,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY active_member;

-- 8.3 Average metrics comparison: Churned vs Retained
SELECT 
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS customer_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(credit_score), 1) AS avg_credit_score,
    ROUND(AVG(balance), 2) AS avg_balance,
    ROUND(AVG(products_number), 2) AS avg_products,
    ROUND(AVG(tenure), 1) AS avg_tenure,
    ROUND(AVG(estimated_salary), 2) AS avg_salary
FROM customers
GROUP BY churn;


-- ============================================================================
-- 9. PREDICTIVE QUERIES FOR AT-RISK CUSTOMERS
-- ============================================================================

-- 9.1 High-risk customers (Multiple risk factors)
SELECT 
    customer_id,
    country,
    gender,
    age,
    balance,
    products_number,
    active_member,
    tenure,
    CASE 
        WHEN country = 'Germany' THEN 1 ELSE 0 
    END +
    CASE 
        WHEN gender = 'Female' THEN 1 ELSE 0 
    END +
    CASE 
        WHEN active_member = 0 THEN 1 ELSE 0 
    END +
    CASE 
        WHEN age >= 40 THEN 1 ELSE 0 
    END +
    CASE 
        WHEN products_number >= 3 THEN 1 ELSE 0 
    END AS risk_score
FROM customers
WHERE churn = 0  -- Only current customers
    AND (
        (country = 'Germany' AND gender = 'Female' AND active_member = 0)
        OR (products_number >= 3)
        OR (age >= 50 AND active_member = 0)
    )
ORDER BY risk_score DESC
LIMIT 20;

-- 9.2 Customers to target for retention campaigns
SELECT 
    customer_id,
    country,
    age,
    balance,
    tenure,
    active_member,
    products_number
FROM customers
WHERE churn = 0
    AND active_member = 0
    AND balance > 50000
    AND age >= 35
ORDER BY balance DESC
LIMIT 50;


-- ============================================================================
-- 10. BUSINESS RECOMMENDATIONS QUERIES
-- ============================================================================

-- 10.1 Calculate potential revenue loss from churn
SELECT 
    COUNT(*) AS churned_customers,
    ROUND(SUM(balance), 2) AS total_balance_lost,
    ROUND(AVG(balance), 2) AS avg_balance_per_churned_customer,
    ROUND(SUM(balance) / 1000000, 2) AS balance_lost_in_millions
FROM customers
WHERE churn = 1;

-- 10.2 Countries requiring immediate attention
SELECT 
    country,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(SUM(CASE WHEN churn = 1 THEN balance ELSE 0 END), 2) AS balance_lost,
    ROUND(SUM(CASE WHEN churn = 1 THEN balance ELSE 0 END) / 1000000, 2) AS balance_lost_millions
FROM customers
GROUP BY country
ORDER BY churn_rate DESC;

-- 10.3 Success metrics - Low churn customer profiles to replicate
SELECT 
    country,
    gender,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(products_number), 1) AS avg_products,
    ROUND(AVG(CASE WHEN active_member = 1 THEN 1.0 ELSE 0.0 END) * 100, 1) AS active_member_percentage,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY country, gender
HAVING COUNT(*) > 500
ORDER BY churn_rate ASC
LIMIT 5;
