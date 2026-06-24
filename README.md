
# 🎵 Spotify Behavioral Engagement Study (2019–2026)

**A 7-year individual streaming analysis to identify user retention patterns, listening drop-off signals, and behavioral engagement drivers**

---

## Project Overview

This project analyzes 98,876 streaming records spanning 7 years to uncover behavioral engagement patterns, retention risks, and listening habits — framed as a real-world user analytics study relevant to streaming platforms, ad tech, and consumer product teams.

The dataset was sourced from a Spotify Extended Streaming History export and processed end-to-end across three analytical stages: Python ETL, SQL analysis, and Power BI dashboard.

> **Why this project?** Skip rates, session behavior, platform migration, and seasonal engagement dips are the same signals that product and marketing analysts at companies like Spotify, Netflix, and Snowflake track to measure user retention and inform content strategy.

---

## Key Findings

| # | Finding |
|---|---------|
| 1 | **55% decline** in rolling average listening hours from peak (2022) to 2025 — sustained retention risk signal |
| 2 | **Skip rate tripled** from 16% in 2022 to 55% in 2025, indicating declining content-satisfaction alignment |
| 3 | **43% of all engagement** occurs in the Morning session (5am–12pm), pointing to habitual commute-driven listening |
| 4 | **Platform migration** from Android to iOS confirmed between 2023–2024, with iOS reaching 92% of listening by 2025 |
| 5 | **Top artists by hours ≠ top artists by skip rate** — suggesting algorithmic recommendations surface mismatched content despite artist-level familiarity |

---

## Project Architecture

```
spotify-behavioral-study/
│
├── data/
│   └── spotify_cleaned.csv          # Cleaned dataset (98,876 rows × 22 columns)
│
├── python/
│   └── spotify_etl.ipynb            # Stage 1: Data wrangling + feature engineering
│
├── sql/
│   └── spotify_analysis.sql         # Stage 2: All 15 analytical queries
│
├── dashboard/
│   └── spotify_dashboard.pbix       # Stage 3: Power BI dashboard (in progress)
│
└── README.md
```

---

## Stage 1 — Python ETL (Complete ✅)

**Tool:** Python (pandas) via Google Colab

**What was done:**
- Ingested and merged 7 raw JSON files (2019–2026) into a single dataframe
- Performed data validation, null removal, and deduplication (172 duplicates removed)
- Parsed and decomposed UTC timestamps into year, month, day, hour dimensions
- Converted milliseconds to minutes for meaningful engagement measurement
- Engineered two behavioral features:
  - `is_skip` — true skip flag (Spotify skipped = true AND ms_played < 30 seconds)
  - `session_bucket` — time-of-day segmentation (Morning / Afternoon / Evening / Night)
- Exported clean analysis-ready CSV: **98,876 rows × 22 columns, zero null values**

---

## Stage 2 — SQL Analysis (Complete ✅)

**Tool:** PostgreSQL 16 via pgAdmin

**Analytical framework:** Four-level question hierarchy mirroring real BA/DA workflows

### Level 1 — Descriptive
- YoY listening hours with LAG window function and NULLIF division guard
- Top 10 artists by total hours + % of total engagement (CTE + cross join)
- Top 10 tracks by hours and play count

### Level 2 — Diagnostic
- Skip rate by year (CASE WHEN inside COUNT)
- Listening by hour of day and session bucket
- Day of week analysis with weekday vs weekend classification
- Platform migration analysis with CASE-based standardization of raw device strings
- Offline vs online listening distribution

### Level 3 — Root Cause
- Artist-level skip rate with minimum play threshold (HAVING clause)
- Monthly listening anomaly detection
- Shuffle mode correlation with skip behavior
- Worst engagement years by average minutes per play

### Level 4 — Predictive
- Rolling 3-month average trend (window function: ROWS BETWEEN 3 PRECEDING AND CURRENT ROW)
- One-season artist obsession detection (HAVING COUNT(DISTINCT year) = 1)

---

## Stage 3 — Power BI Dashboard (In Progress 🔄)

Dashboard will include:
- Executive summary page with 5 core KPIs
- YoY engagement trend with skip rate overlay
- Artist and track engagement breakdown
- Listening behavior heatmap (hour × day of week)
- Platform migration timeline
- Monthly trend with rolling average

---

## Technical Skills Demonstrated

| Category | Skills |
|----------|--------|
| **Python** | pandas, data wrangling, ETL, feature engineering |
| **SQL** | CTEs, window functions (LAG, AVG OVER), CASE WHEN, NULLIF, HAVING, GROUP BY, subqueries |
| **Analytics** | YoY analysis, cohort behavior, anomaly detection, root cause analysis, variance analysis, behavioral segmentation |
| **BI** | Power BI (in progress) |

---

## Data Source

Spotify Extended Streaming History — personal export via Spotify Privacy Settings. Dataset covers June 2019 to February 2026.

*Raw data not included in this repository for privacy reasons. Cleaned CSV available upon request.*

---

## Author

**Malak Mehta**  
MS Business Analytics — University of Massachusetts Amherst  
[LinkedIn](#) | [GitHub](#)
