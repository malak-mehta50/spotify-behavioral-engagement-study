-- ============================================================
-- LEVEL 2: DIAGNOSTIC ANALYSIS
-- ============================================================
 
-- Query 4: Skip rate by year
SELECT
    year,
    COUNT(CASE WHEN skipped = 'true' THEN 1 ELSE NULL END) AS count_of_skips,
    COUNT(track_name) AS total_plays,
    ROUND(COUNT(CASE WHEN skipped = 'true' THEN 1 ELSE NULL END) * 100.0 / COUNT(track_name), 2) || '%' AS skip_rate
FROM streaming_history
GROUP BY year
ORDER BY year ASC;
 
 
-- Query 5: Listening volume by hour of day
SELECT
    hour,
    ROUND(SUM(minutes_played) / 60, 1) AS listening_hours
FROM streaming_history
GROUP BY hour
ORDER BY listening_hours DESC;
 
 
-- Query 6: Listening by day of week with weekday/weekend classification
SELECT
    day_of_week,
    ROUND(SUM(minutes_played) / 60, 1) AS listening_hours,
    CASE
        WHEN day_of_week IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type
FROM streaming_history
GROUP BY day_of_week
ORDER BY listening_hours DESC;
 
 
-- Query 7: Engagement by session bucket
SELECT
    session_bucket,
    ROUND(SUM(minutes_played) / 60, 1) AS listening_hours
FROM streaming_history
GROUP BY session_bucket
ORDER BY listening_hours DESC;
 
 
-- Query 8: Platform migration by year (standardized)
SELECT
    year,
    CASE
        WHEN LOWER(platform) LIKE '%android%' THEN 'Android'
        WHEN LOWER(platform) LIKE '%ios%' THEN 'iOS'
        WHEN LOWER(platform) LIKE '%ps4%' OR LOWER(platform) LIKE '%playstation%' THEN 'Playstation'
        WHEN LOWER(platform) LIKE '%windows%' THEN 'Windows'
        ELSE platform
    END AS platform_clean,
    ROUND(SUM(minutes_played) / 60, 1) AS listening_hours
FROM streaming_history
GROUP BY year, platform_clean
ORDER BY year ASC;
 
 
-- Query 9: Offline vs online listening per year
SELECT
    year,
    COUNT(CASE WHEN offline = 'true' THEN 1 ELSE NULL END) AS offline_count,
    COUNT(CASE WHEN offline = 'false' THEN 1 ELSE NULL END) AS online_count
FROM streaming_history
GROUP BY year
ORDER BY year ASC;

