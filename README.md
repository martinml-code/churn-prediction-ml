# Customer Churn Prediction: A Structured DB & ML Approach

This repository contains a rigorous, end-to-end data science pipeline for predicting customer churn. It demonstrates real-world data engineering and machine learning best practices using a 1 million record dataset.

## Architecture & Workflow

The pipeline is broken down into structured phases:

*   **Phase A & B:** Data source profiling and normalized **SQLite Database Star Schema** design (Extracting Demographics, Account Info, and a Services Junk Dimension).
*   **Phase C:** Idempotent, programmatic data ingestion into the database using Pandas and SQLite.
*   **Phase D:** SQL-driven Exploratory Data Analysis (EDA) showcasing advanced techniques like `JOIN`s, filtering, and aggregation.
*   **Machine Learning:** Data preprocessing, Feature Engineering, and training predictive models (Logistic Regression, Decision Tree, Random Forest).
*   **Evaluation:** Comprehensive model evaluation using Precision-Recall curves, ROC-AUC, and F1 scores. 
*   **Insert ML Predictions into Database:** Insert ML predictions into the database using Pandas and SQLite.

## Installation & Setup
To run the notebook locally:
1. Install dependencies: `pip install pandas numpy scikit-learn matplotlib seaborn plotly kagglehub`
2. Run all cells in `analysis.ipynb` sequentially. 
   - The dataset will be downloaded automatically via Kaggle and temporarily stored in a `data/` folder (which is created automatically).
   - The raw CSV data is then procedurally ingested and normalized into a local SQLite database (`churn_db.sqlite`), which is also generated automatically on the fly.
