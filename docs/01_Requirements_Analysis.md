# 📑 Requirements Analysis Document

**Project:** StatsBomb Data Warehouse  
**Author:** Mostafa Khaled Farag  
**Date:** 2025-08-20  

---

## 1. Introduction  
The StatsBomb Data Warehouse (DWH) project aims to design and implement a scalable, multi-layered data warehouse for storing, transforming, and analyzing football (soccer) data from StatsBomb’s open-data repository.  

The purpose of this system is to provide analysts and decision-makers with clean, structured, and query-optimized data that supports advanced football analytics, including player performance, team tactics, and competition-level insights.  

---

## 2. Objectives  
- Provide a centralized data platform for StatsBomb open data.  
- Enable descriptive and diagnostic analysis (e.g., passing accuracy, possession, xG trends).  
- Support star-schema modeling for efficient BI reporting (Power BI, Tableau).  
- Ensure data integrity, consistency, and traceability from raw JSON to analytics-ready fact tables.  

---

## 3. Data Sources  
The project will use StatsBomb Open Data (JSON files) hosted on GitHub. Key files include:  

- **Competitions** → `competitions.json`  
- **Matches** → `matches/{competition_id}/{season_id}.json`  
- **Events** → `events/{match_id}.json`  
- **Lineups** → `lineups/{match_id}.json`  

Each dataset will first be ingested into the **Bronze Layer** before transformation.  

---

## 4. Scope of Analysis  

### 4.1 Business Questions  
The DWH should be able to answer:  
- Which players contribute most to chance creation (xA, key passes)?  
- How do teams perform in terms of expected goals (xG) vs. actual goals?  
- What are the possession and passing accuracy trends across competitions?  
- How do defensive metrics (pressures, interceptions, tackles) compare across teams?  
- How do match outcomes vary across competitions and seasons?  

### 4.2 KPIs / Metrics  
- **Offensive:** Goals, Shots on Target %, Expected Goals (xG), Expected Assists (xA)  
- **Passing:** Total Passes, Pass Accuracy %  
- **Possession:** Team Possession %  
- **Defensive:** Tackles, Pressures, Interceptions, xGA (Expected Goals Against)  

---

## 5. Dimensional Model Requirements  

### 5.1 Dimensions  
- **Competition** → competition_id, competition_name, country  
- **Season** → season_id, year, competition_id  
- **Match** → match_id, date, teams, venue, season_id  
- **Team** → team_id, name, country  
- **Player** → player_id, name, position, team_id  
- **Event Type** → event_id, event_category (shot, pass, pressure, etc.)  

### 5.2 Fact Tables  
- **Fact_Events** → one row per event (granularity: event level)  
- **Fact_Matches** → aggregated match-level stats (team vs. team)  

---

## 6. Constraints & Assumptions  
- Data limited to StatsBomb open-data coverage (not all leagues/competitions).  
- JSON must be parsed and stored in **bronze schema** before transformation.  
- Data freshness is static (no live feeds).  
- End visualization will be delivered in **Power BI** or **Tableau**.  

---

## 7. Deliverables  
- **Bronze Layer** → Raw landing tables for JSON data (`matches_raw`, `events_raw`, `lineups_raw`).  
- **Silver Layer** → Cleaned & normalized relational model (`matches`, `events`, `players`, `teams`).  
- **Gold Layer** → Star schema with fact and dimension tables (`fact_events`, `dim_player`, `dim_team`, etc.).  
- **Logs Schema** → ETL execution logs and metadata tables.  
- **Documentation** → ERD diagrams, transformation mapping, ETL documentation.  

---

## 8. Success Criteria  
- Analysts can query standardized KPIs across players, teams, and competitions.  
- Queries run on star schema perform within acceptable limits (<5s for typical aggregations).  
- Full lineage is traceable from raw JSON (bronze) to gold reporting tables.  
- BI dashboards (Power BI/Tableau) connect seamlessly to gold layer.  
