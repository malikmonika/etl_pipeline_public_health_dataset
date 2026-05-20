-- Staging model: clean and standardize raw COVID data
-- Source: Johns Hopkins University daily reports
-- 3.7M rows across 200+ countries

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
