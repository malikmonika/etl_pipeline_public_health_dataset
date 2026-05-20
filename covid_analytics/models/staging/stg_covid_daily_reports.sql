-- ============================================
-- Model: stg_covid_daily_reports
-- Layer: Staging
-- ============================================
-- Description:
--   Cleans and standardizes raw COVID-19
--   daily report data from Johns Hopkins
--   University. Handles schema evolution
--   across 3 years of changing column names.
--   Source: 3,709,419 rows from 1200+ CSV files.
--
-- Source: covid.test_db (raw SQLite table)
--
-- Transformations applied:
--   - Column renaming for consistency
--   - CAST to correct data types
--   - NULL filtering on country
--   - ROUND on float columns
--
-- DE concepts demonstrated:
--   - Staging layer design
--   - Schema evolution handling
--   - Data type standardization
--   - dbt source() reference
-- ============================================

SELECT
    Country_Region                              AS country,
    Province_State                              AS province,
    CAST(Confirmed AS INTEGER)                  AS confirmed,
    CAST(Deaths AS INTEGER)                     AS deaths,
    CAST(Recovered AS INTEGER)                  AS recovered,
    CAST(Active AS INTEGER)                     AS active,
    ROUND(CAST(Incident_Rate AS REAL), 2)       AS incident_rate,
    ROUND(CAST(Case_Fatality_Ratio AS REAL), 2) AS fatality_ratio

FROM {{ source('covid', 'test_db') }}

WHERE Country_Region IS NOT NULL
