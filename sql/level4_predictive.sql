- ============================================================
-- LEVEL 4: PREDICTIVE / TREND ANALYSIS
-- ============================================================
 
-- Query 14: Rolling 3-month average listening trend (excluding incomplete 2026)
WITH monthly AS (
    SELECT
        year,
        month,
        ROUND(SUM(minutes_played) / 60, 1) AS monthly_hours
    FROM streaming_history
    WHERE year != 2026
    GROUP BY year, month
)
SELECT
    year,
    month,
    monthly_hours,
    ROUND(AVG(monthly_hours) OVER (ORDER BY year, month ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 1) AS rolling_3m_avg
FROM monthly
ORDER BY year, month;
 
 
-- Query 15: One-season artist obsessions (active in only 1 year, 50+ plays)
WITH artist_years AS (
    SELECT
        artist_name,
        year,
        COUNT(*) AS play_count
    FROM streaming_history
    WHERE year != 2026
    GROUP BY artist_name, year
)
SELECT
    artist_name,
    COUNT(DISTINCT year) AS years_active,
    SUM(play_count) AS total_plays,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM artist_years
GROUP BY artist_name
HAVING COUNT(DISTINCT year) = 1 AND SUM(play_count) > 50
ORDER BY total_plays DESC
LIMIT 10;
 
