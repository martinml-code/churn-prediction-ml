-- schema.sql
-- Normalized schema for Customer Churn Analysis

-- Dimension Table: Demographics
CREATE TABLE IF NOT EXISTS dim_demographics (
    demographic_id INTEGER PRIMARY KEY AUTOINCREMENT,
    gender TEXT,
    education TEXT,
    marital_status TEXT,
    senior_citizen INTEGER,
    UNIQUE(gender, education, marital_status, senior_citizen)
);

-- Dimension Table: Account Info
CREATE TABLE IF NOT EXISTS dim_account_info (
    account_info_id INTEGER PRIMARY KEY AUTOINCREMENT,
    contract TEXT,
    payment_method TEXT,
    paperless_billing TEXT,
    UNIQUE(contract, payment_method, paperless_billing)
);

-- Dimension Table: Services (Junk Dimension)
CREATE TABLE IF NOT EXISTS dim_services (
    service_id INTEGER PRIMARY KEY AUTOINCREMENT,
    has_phone_service INTEGER,
    has_internet_service INTEGER,
    has_online_security INTEGER,
    has_online_backup INTEGER,
    has_device_protection INTEGER,
    has_tech_support INTEGER,
    has_streaming_tv INTEGER,
    has_streaming_movies INTEGER,
    UNIQUE(has_phone_service, has_internet_service, has_online_security, has_online_backup, 
           has_device_protection, has_tech_support, has_streaming_tv, has_streaming_movies)
);

-- Fact Table: Customers
CREATE TABLE IF NOT EXISTS fact_customers (
    customer_id TEXT PRIMARY KEY,
    signup_date TIMESTAMP,
    age INTEGER,
    annual_income REAL,
    dependents INTEGER,
    tenure INTEGER,
    
    -- Foreign Keys
    demographic_id INTEGER,
    account_info_id INTEGER,
    service_id INTEGER,
    
    -- Financials & Usage
    monthlycharges REAL,
    totalcharges REAL,
    num_services INTEGER,
    avg_monthly_gb REAL,
    
    -- Engagement & Target
    customer_satisfaction REAL,
    num_complaints REAL,
    num_service_calls INTEGER,
    late_payments INTEGER,
    days_since_last_interaction INTEGER,
    credit_score REAL,
    churn INTEGER,
    
    FOREIGN KEY(demographic_id) REFERENCES dim_demographics(demographic_id),
    FOREIGN KEY(account_info_id) REFERENCES dim_account_info(account_info_id),
    FOREIGN KEY(service_id) REFERENCES dim_services(service_id)
);

-- Indexes for efficient analytical querying
CREATE INDEX IF NOT EXISTS idx_churn ON fact_customers(churn);
CREATE INDEX IF NOT EXISTS idx_tenure ON fact_customers(tenure);
CREATE INDEX IF NOT EXISTS idx_demo_id ON fact_customers(demographic_id);
CREATE INDEX IF NOT EXISTS idx_acct_id ON fact_customers(account_info_id);
CREATE INDEX IF NOT EXISTS idx_srv_id ON fact_customers(service_id);

-- Predictions Table: Stores model outputs
CREATE TABLE IF NOT EXISTS churn_predictions (
    prediction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id TEXT,
    predicted_churn INTEGER,
    churn_probability REAL,
    prediction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(customer_id) REFERENCES fact_customers(customer_id)
);

CREATE INDEX IF NOT EXISTS idx_pred_cust ON churn_predictions(customer_id);
CREATE INDEX IF NOT EXISTS idx_pred_prob ON churn_predictions(churn_probability);
