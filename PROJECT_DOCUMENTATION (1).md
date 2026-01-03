# Bank Customer Churn Prediction - SQL Analysis Project

## Project Overview
This project provides a comprehensive SQL-based analysis of bank customer churn data, helping to identify patterns, risk factors, and actionable insights for customer retention strategies.

## Dataset Information
- **Total Records:** 10,000 customers
- **Features:** 12 columns
- **Target Variable:** churn (1 = churned, 0 = retained)

### Data Dictionary

| Column | Description | Type |
|--------|-------------|------|
| customer_id | Unique customer identifier | Integer |
| credit_score | Customer's credit score (350-850) | Integer |
| country | Customer's country (France, Spain, Germany) | String |
| gender | Customer's gender (Male, Female) | String |
| age | Customer's age | Integer |
| tenure | Years with the bank (0-10) | Integer |
| balance | Account balance | Float |
| products_number | Number of bank products (1-4) | Integer |
| credit_card | Has credit card (1 = Yes, 0 = No) | Binary |
| active_member | Active member status (1 = Yes, 0 = No) | Binary |
| estimated_salary | Customer's estimated salary | Float |
| churn | Customer churned (1 = Yes, 0 = No) | Binary |

## Project Structure

```
bank_churn_analysis/
├── bank_churn.db              # SQLite database
├── sql_queries.sql            # Comprehensive SQL queries
├── bank_churn_analysis.py     # Database setup script
├── execute_analysis.py        # Analysis execution script
├── analysis_results.txt       # Detailed analysis results
└── PROJECT_DOCUMENTATION.md   # This file
```

## Key Findings

### 1. Overall Churn Statistics
- **Total Customers:** 10,000
- **Churned Customers:** 2,037 (20.37%)
- **Retained Customers:** 7,963 (79.63%)

### 2. Geographic Analysis
**Churn Rate by Country:**
- Germany: **32.4%** (HIGHEST - Requires immediate attention)
- France: 16.2%
- Spain: 16.7%

**Key Insight:** German customers are twice as likely to churn compared to other countries.

### 3. Demographic Insights

**Gender Analysis:**
- Female customers: **25.1% churn rate**
- Male customers: 16.5% churn rate
- **Finding:** Female customers are 52% more likely to churn

**Age Group Analysis:**
- 18-29: 9.6% churn rate
- 30-39: 16.9% churn rate
- 40-49: 28.8% churn rate (CRITICAL)
- 50-59: 28.2% churn rate (CRITICAL)
- 60+: 23.6% churn rate

**Key Insight:** Customers aged 40-59 have the highest churn rates (nearly 3x compared to younger customers).

### 4. Account Behavior Analysis

**Active Membership Impact:**
- Inactive Members: **26.9% churn rate** (HIGH RISK)
- Active Members: 14.3% churn rate
- **Finding:** Inactive members are 88% more likely to churn

**Product Holdings:**
- 1 Product: 27.7% churn rate
- 2 Products: 7.6% churn rate (LOWEST - Best retention)
- 3 Products: 82.7% churn rate (EXTREMELY HIGH)
- 4 Products: 100% churn rate (ALL churned)

**CRITICAL FINDING:** Customers with 3-4 products have abnormally high churn rates, suggesting possible dissatisfaction or over-selling.

**Balance Analysis:**
- Zero Balance: 27.9% churn rate
- High Balance (100-149K): 24.5% churn rate
- Very High Balance (150K+): 23.3% churn rate

**Finding:** Higher balance customers are more likely to churn (possibly seeking better returns elsewhere).

**Tenure Analysis:**
- Churn rates range from 16-24% across all tenure periods
- No significant correlation between tenure and retention
- **Insight:** Loyalty programs may not be effective

### 5. Financial Loss Analysis
- **Total Balance Lost to Churn:** $208.4 Million
- **Average Balance per Churned Customer:** $102,288
- **Germany's Balance Loss:** $68.8 Million (33% of total)

### 6. High-Risk Customer Profile

Customers most likely to churn have the following characteristics:
1. **Country:** Germany
2. **Gender:** Female
3. **Age:** 40+ years
4. **Active Status:** Inactive member
5. **Products:** 3-4 products
6. **Balance:** High (>100K)

## SQL Analysis Categories

The project includes comprehensive SQL queries organized into 10 categories:

1. **Data Overview & Basic Statistics**
2. **Churn Analysis by Demographics**
3. **Churn Analysis by Account Characteristics**
4. **Credit Score Analysis**
5. **Salary Analysis**
6. **Multi-Dimensional Analysis**
7. **Customer Segmentation**
8. **Key Insights & Risk Factors**
9. **Predictive Queries for At-Risk Customers**
10. **Business Recommendations Queries**

## Business Recommendations

### Immediate Actions (High Priority)

1. **Germany Market Intervention**
   - Launch targeted retention campaign
   - Investigate root causes of high churn (32.4%)
   - Consider local competitor analysis
   - Improve customer service in Germany

2. **Female Customer Retention Program**
   - Develop gender-specific engagement strategies
   - Conduct focus groups to understand pain points
   - Create personalized communication channels

3. **Inactive Member Re-engagement**
   - Automated re-engagement campaigns
   - Special offers for inactive members
   - Mobile app push notifications
   - Quarterly check-in calls

4. **Product Portfolio Review**
   - URGENT: Investigate why 3-4 product customers churn at 80-100%
   - Review cross-selling strategies
   - Ensure products meet customer needs
   - Consider unbundling or simplifying offerings

### Medium-Term Strategies

5. **Age-Specific Programs**
   - Develop retirement planning services for 40-59 age group
   - Wealth management offerings for high-balance customers
   - Financial education programs

6. **Balance-Based Retention**
   - Competitive interest rates for high-balance accounts
   - Premium service tiers
   - Investment advisory services

7. **Active Membership Incentives**
   - Rewards for regular account usage
   - Gamification features
   - Monthly engagement challenges

### Long-Term Initiatives

8. **Predictive Analytics**
   - Machine learning model for churn prediction
   - Early warning system for at-risk customers
   - Automated retention triggers

9. **Customer Experience Enhancement**
   - Digital banking improvements
   - Personalized financial advice
   - 24/7 customer support

10. **Geographic Expansion Strategy**
    - Learn from France/Spain's lower churn rates
    - Apply best practices to Germany market

## How to Use This Project

### 1. Database Setup
```bash
python bank_churn_analysis.py
```
This creates the SQLite database from the CSV file.

### 2. Execute Analysis
```bash
python execute_analysis.py
```
This runs all SQL queries and generates the results file.

### 3. Custom Queries
Connect to the database and run custom queries:
```bash
sqlite3 bank_churn.db
```

### 4. View Results
```bash
cat analysis_results.txt
```

## Sample SQL Queries

### Query 1: Overall Churn Rate
```sql
SELECT 
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM customers;
```

### Query 2: High-Risk Customer Identification
```sql
SELECT 
    customer_id,
    country,
    gender,
    age,
    balance,
    products_number,
    active_member
FROM customers
WHERE churn = 0
    AND country = 'Germany'
    AND gender = 'Female'
    AND age >= 40
    AND active_member = 0
ORDER BY balance DESC
LIMIT 50;
```

### Query 3: Revenue at Risk
```sql
SELECT 
    country,
    COUNT(*) AS at_risk_customers,
    ROUND(SUM(balance), 2) AS balance_at_risk,
    ROUND(SUM(balance) / 1000000, 2) AS balance_at_risk_millions
FROM customers
WHERE churn = 0
    AND (
        (country = 'Germany' AND active_member = 0)
        OR products_number >= 3
        OR (age >= 50 AND active_member = 0)
    )
GROUP BY country
ORDER BY balance_at_risk DESC;
```

## Technical Requirements

- Python 3.x
- pandas
- sqlite3
- Access to the CSV file

## Installation

```bash
pip install pandas
```

## Future Enhancements

1. **Visualization Dashboard**
   - Create interactive Tableau/Power BI dashboard
   - Real-time churn monitoring

2. **Machine Learning Integration**
   - Build predictive churn model
   - Feature importance analysis
   - Model deployment

3. **Advanced Analytics**
   - Customer lifetime value analysis
   - Cohort analysis
   - Survival analysis

4. **Automation**
   - Scheduled reporting
   - Automated alerts for high-risk customers
   - Integration with CRM systems

## Key Metrics to Monitor

1. **Churn Rate:** Track monthly/quarterly trends
2. **Customer Lifetime Value (CLV):** Calculate for different segments
3. **Cost of Acquisition vs. Retention:** ROI analysis
4. **Net Promoter Score (NPS):** Customer satisfaction
5. **Product Adoption Rate:** Monitor cross-sell success

## Conclusion

This SQL analysis reveals critical insights into bank customer churn patterns. The most significant findings are:

1. Germany has a severe churn problem (32.4%)
2. Female customers and those aged 40-59 are high-risk groups
3. Inactive members have 88% higher churn rates
4. Customers with 3-4 products show abnormal churn patterns
5. Over $208 million in customer balance has been lost

**Immediate action is required** particularly in the German market and for inactive member re-engagement.

## Contact & Support

For questions or suggestions about this analysis project, please refer to the SQL queries file for detailed query documentation.

---
**Last Updated:** 2026-01-04
**Project Type:** SQL Analysis for Customer Churn Prediction
**Industry:** Banking & Financial Services
