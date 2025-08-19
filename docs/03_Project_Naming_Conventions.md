# 📂 Project Naming Conventions

---

### 📜 General Guidelines
- Use **lower_snake_case** for all database objects (tables, views, columns, procedures).  
- Avoid spaces, special characters, and reserved SQL keywords.  
- Use **descriptive but concise names**.  
- Prefix objects with layer/schema indicator (`bronze_`, `silver_`, `gold_`).  

---

### 🗄️ Schemas
- **bronze** → Raw ingestion layer (no transformations).  
- **silver** → Cleansed & standardized layer.  
- **gold** → Business-ready reporting layer.  

---

### 📊 Tables
- Use the pattern:
- Examples:  
- `bronze.raw_matches` → Raw match data.  
- `silver.clean_events` → Cleaned events data.  
- `gold.fact_events` → Final fact table for event analysis.  
- `gold.dim_team` → Dimension table for team details.  

---

### 🔄 Stored Procedures
- Use **action + target** format.  
- Prefix with schema layer.  

- Examples:  
- `silver.sp_load_clean_matches` → Loads & cleans matches from bronze to silver.  
- `gold.sp_build_fact_events` → Creates fact table from silver layer.  
- `gold.sp_refresh_dimensions` → Refreshes dimension tables.  

---

### 👓 Views
- Use **vw_ prefix** to indicate views.  
- Place in **gold schema** for reporting/analytics.  

- Examples:  
- `gold.vw_team_performance` → Aggregated team stats.  
- `gold.vw_player_shot_map` → Player-level shot maps.  

---

### 🔑 Columns
- Use **clear & descriptive names**.  
- Apply consistent suffixes/prefixes:  
- IDs → `_id` (e.g., `match_id`, `player_id`).  
- Dates → `_date` (e.g., `match_date`, `start_date`).  
- Flags → `_flag` or `_is` (e.g., `is_home_team`, `active_flag`).  

---

### ✅ Example
```sql
-- Bronze Layer
bronze.raw_matches

-- Silver Layer
silver.clean_matches
silver.clean_events

-- Gold Layer
gold.fact_events
gold.dim_player
gold.dim_team
gold.dim_competition
gold.dim_season

-- Procedure
gold.sp_build_fact_events

