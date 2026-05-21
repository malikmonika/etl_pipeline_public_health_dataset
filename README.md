# COVID-19 ETL Pipeline + dbt Analytics Layer

End-to-end data platform ingesting Johns Hopkins University 
COVID-19 daily reports — Python ETL pipeline feeding a 
dbt star schema analytics layer.

## Architecture

GitHub API (1200+ CSV files)
        ↓
Python ETL (main.py)
  → Schema evolution handling
  → pandas transformation
  → SQLite loading
        ↓
SQLite database (3,709,419 rows · 157MB)
        ↓
dbt analytics layer (covid_analytics/)
  → stg_covid_daily_reports (staging)
  → fact_country_totals (fact table)
  → dim_country (dimension table)
  → mart_top_10_countries (mart)
        ↓
6 automated data quality tests passing

## What it does

- Fetches 1200+ daily COVID CSV files from JHU GitHub API
- Handles real-world schema evolution — column names 
  changed multiple times across 3 years of data
- Loads 3,709,419 rows into structured SQLite database
- Transforms raw data into Kimball star schema using dbt
- Runs automated data quality tests on every model
- Auto-generates data catalog with dbt docs

## Tech Stack

Python · pandas · SQLite · requests · numpy · dbt

## Results — Top 10 Most Affected Countries

| Rank | Country | Confirmed | Deaths |
|---|---|---|---|
| 1 | France | 38,618,509 | 161,512 |
| 2 | Korea, South | 30,615,522 | 34,093 |
| 3 | United Kingdom | 20,656,177 | 186,138 |
| 4 | Turkey | 17,042,722 | 101,492 |
| 5 | Vietnam | 11,526,994 | 43,186 |
| 6 | Argentina | 10,044,957 | 130,472 |
| 7 | Taiwan | 9,970,937 | 17,672 |
| 8 | India | 8,138,129 | 148,424 |
| 9 | Germany | 8,048,396 | 31,400 |
| 10 | Iran | 7,572,311 | 144,933 |

## How to Run

### Python ETL pipeline

pip install pandas requests numpy
python3 main.py

### dbt analytics layer

cd covid_analytics
pip install dbt-core dbt-sqlite
dbt run
dbt test
dbt docs generate && dbt docs serve

## Data Quality Handling

| Issue | How handled |
|---|---|
| Missing columns | Added as NaN |
| Inconsistent column names | Standardized via mapping |
| Schema evolution | Detected and normalized |
| Null critical fields | Filtered in staging layer |
| Duplicate countries | unique dbt test enforced |

## DE Concepts Demonstrated

- Python ETL pipeline at scale (3.7M rows)
- Schema evolution handling across 1200 files
- Kimball star schema — fact + dimension modeling
- dbt staging → fact → dimension → mart layers
- Data quality as code (dbt tests in schema.yml)
- Auto-generated data documentation (dbt docs)
- Window functions — DENSE_RANK for ranking
- CTE pattern for analytical queries

## What I Learned

- Schema evolution is a real DE challenge —
  handling it gracefully is what separates
  production pipelines from toy projects
- dbt enforces separation of concerns —
  staging cleans, facts aggregate, marts answer
- Data quality tests belong in the pipeline,
  not as an afterthought
- Kimball modeling starts with business questions,
  not technical schema design

## What I Would Do Differently at Scale

- Snowflake or BigQuery instead of SQLite
- Airflow DAG for scheduled daily runs
- Incremental dbt models — only process new data
- dbt snapshots for SCD Type 2 history tracking
- Great Expectations for anomaly detection
- Kafka for real-time ingestion instead of batch