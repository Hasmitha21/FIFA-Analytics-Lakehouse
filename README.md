# FIFA Analytics Lakehouse

An end-to-end data lakehouse pipeline built on **Databricks** and **dbt**, transforming the [European Soccer Database](https://www.kaggle.com/datasets/hugomathien/soccer) (Kaggle) into analytics-ready dimensional models — including a **Slowly Changing Dimension (SCD Type 2)** for tracking player rating history over time.



![Architecture Diagram])
<img width="300" height="144" alt="fifa_lakehouse_architecture" src="https://github.com/user-attachments/assets/80fc7cf3-16c3-4915-9dbe-3854479faf3c" />


## Overview

This project implements a **medallion (bronze/silver/gold) architecture**:

- **Bronze** — raw CSV data (extracted from a SQLite source) loaded into Delta tables, schema as-is
- **Silver** — cleaned, type-cast, deduplicated tables with irrelevant columns dropped
- **Gold** — dimensional model (star schema) built with **dbt**: dimension tables, a fact table, and a player rating history table modeled as **SCD Type 2**

The dataset covers ~25,000 European football matches and ~11,000 players across 11 leagues from 2008–2016, including 183K player attribute snapshots used to build the rating history dimension.

## Tech Stack

| Layer | Tool |
|---|---|
| Compute & storage | Databricks (Free Edition), Unity Catalog Volumes, Delta Lake |
| Ingestion & cleaning | PySpark |
| Transformation & testing | dbt (dbt-databricks adapter) |
| SCD Type 2 | PySpark window functions (historical) + dbt snapshot (live, "check" strategy) |
| Visualization | Databricks SQL dashboard |

## Architecture

```
Kaggle (SQLite) 
    -> extract_sqlite_to_csv.py (Python)
    -> Unity Catalog Volume (raw CSVs)
    -> Bronze Delta tables (PySpark, schema inference)
    -> Silver Delta tables (PySpark, cleaned & typed)
    -> Gold dbt models (staging -> dims/facts, tested)
    -> Databricks SQL Dashboard
```

A parallel branch derives `dim_player_ratings_history` — an SCD Type 2 table built from 183K dated player-attribute snapshots using `lead()` window functions to compute `valid_from` / `valid_to` / `is_current` ranges.

## Data Model (Gold Layer)

| Table | Type | Description |
|---|---|---|
| `dim_player` | Dimension | Player biographical info (name, birthday, height, weight) |
| `dim_team` | Dimension | Team names |
| `dim_league` | Dimension | League joined with country |
| `fct_match_results` | Fact | One row per match: teams, scores, result, goal difference |
| `dim_player_ratings_history` | SCD Type 2 | Player rating/attribute history with validity ranges |
| `team_snapshot` | dbt snapshot | Demonstrates dbt-native SCD2 ("check" strategy) on team data |

## SCD Type 2: Two Approaches

This project demonstrates both common patterns for Slowly Changing Dimensions:

1. **Historical data → SCD2 (PySpark)**: `silver_player_attributes` contains 183K dated snapshots of player ratings. Using `Window.partitionBy("player_api_id").orderBy("date")` and `lead()`, each snapshot is converted into a validity range (`valid_from`, `valid_to`, `is_current`). This is the correct approach when you already have historical, dated records.

2. **Live data → SCD2 (dbt snapshot)**: `team_snapshot` uses dbt's snapshot feature with a `check` strategy on `team_long_name` and `team_short_name`. This is the correct approach for a *mutable* source table where you want to capture changes going forward each time the snapshot runs.

## Data Quality

11 dbt tests covering uniqueness, null checks, referential integrity (match teams exist in `dim_team`), and accepted values (`result` in `HOME_WIN`/`AWAY_WIN`/`DRAW`) — all passing.

## Dashboard

A Databricks SQL dashboard with 4 visualizations:
- **Team standings** by season (wins/draws/losses, goals, points)
- **Top 10 players** by current overall rating
- **Player rating progression** over time (e.g. Lionel Messi's rating vs. potential, 2008–2016)
- **Goals-per-match trend** across seasons

<img width="1342" height="527" alt="Player rating progression overtime - Messi" src="https://github.com/user-attachments/assets/e6080145-5bca-4669-aa95-93bb84953e92" />
<img width="1322" height="596" alt="Goals trend per season" src="https://github.com/user-attachments/assets/53224227-0868-49ec-aaaf-bdece7036ae5" />
<img width="1324" height="555" alt="Top 10 Current Players by Overall rating" src="https://github.com/user-attachments/assets/cc73e9ac-48c5-477e-9eae-331b58f1eb14" />
<img width="1315" height="633" alt="Team Standings by Season" src="https://github.com/user-attachments/assets/0a584c59-47af-4f0f-944c-c39e00d16755" />


## Project Structure

```
.
├── extract_sqlite_to_csv.py     # Extracts Kaggle SQLite tables to CSV
├── 02_bronze_layer.py           # Databricks notebook: raw CSV -> Bronze Delta
├── 03_silver_layer.py           # Databricks notebook: clean & type -> Silver Delta
├── 04_gold_layer.py             # Databricks notebook: dims/facts + SCD2 (PySpark)
├── 05_dashboard_queries.sql     # SQL for the Databricks SQL dashboard
├── architecture_diagram.svg
└── fifa_dbt_project/
    ├── dbt_project.yml
    ├── models/
    │   ├── staging/             # 1:1 views over Silver tables
    │   └── marts/               # dim_player, dim_team, dim_league, fct_match_results + tests
    └── snapshots/
        └── team_snapshot.sql    # dbt-native SCD2 demo
```

## How to Run

1. **Extract data**: run `extract_sqlite_to_csv.py` against the Kaggle `database.sqlite` file
2. **Upload** the resulting CSVs to a Unity Catalog Volume in Databricks
3. **Run notebooks in order**: `02_bronze_layer.py` → `03_silver_layer.py` → `04_gold_layer.py`
4. **Run dbt**:
   ```bash
   cd fifa_dbt_project
   dbt run
   dbt test
   dbt snapshot
   ```
5. **Build the dashboard** using the queries in `05_dashboard_queries.sql`

## Future Improvements

- Add a parameterized player search to the dashboard
- Extend `fct_match_results` with betting odds columns for predictive modeling
- Schedule the pipeline with Databricks Workflows for daily/weekly refresh
- Migrate raw storage from Unity Catalog Volumes to S3/ADLS via external locations for production-style cloud storage
