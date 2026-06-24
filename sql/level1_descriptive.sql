-- ============================================================
-- Spotify Behavioral Engagement Study (2019–2026)
-- Stage 2: SQL Analysis — PostgreSQL 16
-- Author: Malak Mehta
-- ============================================================
 
 
-- ============================================================
-- LEVEL 1: DESCRIPTIVE ANALYSIS
-- ============================================================
 
-- Query 1: Total listening hours per year + YoY growth
WITH cte AS (
    SELECT
        year,
        ROUND(SUM(minutes_played) / 60, 1) AS total_hours,
        LAG(ROUND(SUM(minutes_played) / 60, 1), 1, 0) OVER (ORDER BY year ASC) AS previous_year
    FROM streaming_history
    GROUP BY year
    ORDER BY year ASC
)
SELECT
    year,
    total_hours,
    previous_year,
    ROUND((total_hours - previous_year) * 100 / NULLIF(previous_year, 0), 2) || '%' AS yoy_growth_pct
FROM cte
ORDER BY year ASC;
 
 
-- Query 2: Top 10 artists by total listening hours + % of total engagement
WITH overall AS (
    SELECT ROUND(SUM(minutes_played) / 60, 1) AS grand_total
    FROM streaming_history
)
SELECT
    artist_name,
    ROUND(SUM(minutes_played) / 60, 1) AS total_hours,
    ROUND(SUM(minutes_played) / 60 * 100 / MAX(overall.grand_total), 2) || '%' AS pct_of_total
FROM streaming_history, overall
GROUP BY artist_name
ORDER BY total_hours DESC
LIMIT 10;
 
 
-- Query 3: Top 10 tracks by total hours and play count
SELECT
    artist_name,
    track_name,
    ROUND(SUM(minutes_played) / 60, 1) AS total_hours,
    COUNT(track_name) AS play_count
FROM streaming_history
GROUP BY track_name, artist_name
ORDER BY total_hours DESC
LIMIT 10;
 
 
