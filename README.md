# COVID-19 ETL Pipeline

An ETL pipeline that ingests Johns Hopkins University
COVID-19 daily reports, transforms and standardizes
the data, and loads it into a SQLite database.

## Architecture

GitHub API → Extract CSVs → Transform → SQLite DB

## What it does

- Fetches 1200+ daily COVID CSV files from JHU GitHub
- Standardizes column names across schema versions
- Handles schema evolution across 1200 files
- Adds missing columns as NaN for consistency
- Loads clean data into SQLite for querying

## Tech Stack

Python · pandas · SQLite · requests · numpy

## How to run

Install dependencies

    pip install pandas requests numpy

Run the pipeline

    python3 main.py

## Data Quality Handling

| Issue | How handled |
|---|---|
| Missing columns | Added as NaN |
| Inconsistent column names | Standardized via mapping |
| Schema evolution | Detected and normalized |

## What I learned

- pandas data cleaning at scale
- Schema evolution handling across 1200 files
- ETL pipeline structure in Python
- SQLite as a lightweight local data store

## SQL queries to be executed
1. Top 10 countries by confirmed cases
2. Daily death rate trend (rolling average)
3. Month over month growth by country (LAG)
4. Case fatality ratio by region (window function)
5. Countries with highest recovery rate
6. Level 1 — Aggregations & Grouping

Top 10 countries by total confirmed cases
Total deaths per country — filter only countries with more than 10,000 deaths
Countries with highest recovery rate (only countries with 50,000+ confirmed)

Level 2 — Window Functions

Rank countries by confirmed cases using DENSE_RANK
Case fatality ratio per country with global average comparison
Top 3 provinces per country by confirmed cases

Level 3 — LAG / LEAD & Rolling Averages

Month over month confirmed case growth for US, India, Brazil
7-day rolling average of deaths for US
Day over day new cases using LAG and LEAD together

Level 4 — CTEs & Advanced Patterns

Countries above global average fatality rate using 2 CTEs
Deduplicate — keep only the latest record per country
Running total of global confirmed cases over time
Find countries where deaths increased but recoveries decreased (anomaly detection)
Categorize countries by pandemic severity using CASE WHEN
Full pipeline data quality check query


Your readiness after each level
After Q1–Q3  → 70%  — Startup screening ready
After Q4–Q6  → 78%  — Mid-size phone screen ready
After Q7–Q9  → 85%  — Amazon phone screen ready
After Q10–Q15 → 95% — Amazon onsite ready
Start Q1 and paste your answer here — I'll review it exactly like before.