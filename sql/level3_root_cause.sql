- ============================================================
-- LEVEL 3: ROOT CAUSE ANALYSIS
-- ============================================================
 
-- Query 10: Artists with highest skip rate (min 50 plays)
SELECT
    artist_name,
    COUNT(CASE WHEN skipped = 'true' THEN 1 ELSE NULL END) AS skip_count,
    COUNT(track_name) AS total_plays,
    ROUND(COUNT(CASE WHEN skipped = 'true' THEN 1 ELSE NULL END) * 100.0 / COUNT(track_name), 2) AS skip_rate_pct
FROM streaming_history
GROUP BY artist_name
HAVING COUNT(track_name) > 50
ORDER BY skip_rate_pct DESC;
 
 
-- Query 11: Monthly listening anomaly detection
SELECT
    year,
    month,
    month_name,
    ROUND(SUM(minutes_played) / 60, 2) AS listening_hours
FROM streaming_history
GROUP BY year, month, month_name
ORDER BY year, month ASC;
 
 
-- Query 12: Does shuffle mode affect skip rate?
SELECT
    shuffle,
    ROUND(COUNT(CASE WHEN skipped = 'true' THEN 1 ELSE NULL END) * 100.0 / COUNT(track_name), 2) AS skip_rate_pct
FROM streaming_history
GROUP BY shuffle;
 
 
-- Query 13: Worst engagement years by average minutes per play
SELECT
    year,
    ROUND(AVG(minutes_played), 2) AS avg_min_per_play
FROM streaming_history
GROUP BY year
ORDER BY avg_min_per_play ASC;
 
