-- ============================================
-- Model: dim_country
-- Layer: Marts / Dimension
-- ============================================
-- Description:
--   Unique list of all countries present in
--   the COVID-19 dataset. Serves as the
--   primary dimension for filtering and
--   joining to fact tables.
--   One row per country. Grain: country level.
--
-- Source: stg_covid_daily_reports
--
-- Business questions answered:
--   - What countries are in the dataset?
--   - Used as JOIN key to fact_country_totals
--
-- DE concepts demonstrated:
--   - Dimension table design (Kimball)
--   - DISTINCT deduplication
--   - Star schema dimension
-- ============================================

SELECT DISTINCT  country
FROM  {{ ref('stg_covid_daily_reports') }}
WHERE country IS NOT NULL