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