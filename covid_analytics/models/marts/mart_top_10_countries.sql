-- ============================================
-- Model: mart_top_10_countries
-- Layer: Marts / Analytics
-- ============================================
-- Description:
--   Ranks the top 10 countries by total confirmed
--   COVID-19 cases using DENSE_RANK window function.
--   One row per country. Grain: country level.
--
-- Source: fact_country_totals
--
-- Business questions answered:
--   - Which 10 countries had the most confirmed cases?
--   - How do top countries rank by confirmed cases?
--   - What are the deaths and fatality ratios
--     for the most affected countries?
--
-- DE concepts demonstrated:
--   - Mart layer design
--   - DENSE_RANK window function
--   - CTE pattern for ranking
--   - dbt ref() chaining across layers
--   - Star schema serving layer
-- ============================================

WITH ranked AS (
    SELECT
        country,
        total_confirmed,
        total_deaths,
        fatality_ratio,
        DENSE_RANK() OVER (
            ORDER BY total_confirmed DESC
        ) AS rank
    FROM {{ ref('fact_country_totals') }}
)
SELECT *
FROM ranked
WHERE rank <= 10