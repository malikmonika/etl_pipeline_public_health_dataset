-- ============================================
-- Model: fact_country_totals
-- Layer: Marts / Fact
-- ============================================
-- Description:
--   Peak COVID-19 metrics per country across
--   all reporting dates from Jan 2020 - Mar 2023.
--   One row per country. Grain: country level.
--
-- Source: stg_covid_daily_reports
--
-- Business questions answered:
--   - Which countries had highest confirmed cases?
--   - What is the fatality ratio per country?
--   - How do countries compare on incident rate?
--
-- DE concepts demonstrated:
--   - Fact table design (Kimball methodology)
--   - Aggregate functions (MAX per group)
--   - dbt ref() for model dependencies
-- ============================================

SELECT
    country,
    MAX(confirmed) AS   total_confirmed,
    MAX(deaths)     AS  total_deaths,
    MAX(recovered)  AS  total_recovered,
    MAX(fatality_ratio) AS  fatality_ratio,
    MAX(incident_rate)  AS  incident_rate
FROM  {{ ref('stg_covid_daily_reports') }}
WHERE confirmed > 0
Group by country
Order by total_confirmed DESC
