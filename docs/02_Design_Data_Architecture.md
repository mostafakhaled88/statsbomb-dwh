# 📂 Design Data Architecture

---

### 🏗️ Overall Architecture
- Adopt a **3-Layered Data Warehouse** approach:
  1. **Bronze Layer** → Raw ingestion (StatsBomb JSON → SQL tables as-is).
  2. **Silver Layer** → Data cleaning, transformations, handling nulls & duplicates.
  3. **Gold Layer** → Business-ready fact & dimension tables for reporting.

---

### 🗄️ Schema Design
- **Bronze Schema**:  
  - Stores raw tables (competitions, matches, teams, players, events).  
  - Minimal transformation, only schema alignment.  

- **Silver Schema**:  
  - Apply cleaning rules: normalize datatypes, resolve missing values, standardize IDs.  
  - Remove duplicates and flatten nested JSON fields.  

- **Gold Schema**:  
  - Create star-schema model (Fact & Dimension tables).  
  - Facts: `FactEvents`, `FactMatches`, `FactPlayers`.  
  - Dimensions: `DimTeam`, `DimPlayer`, `DimCompetition`, `DimSeason`.  

---

### 📊 Data Flow (ETL Pipeline)
- **Extract**: Load StatsBomb JSON files into Bronze tables.  
- **Transform**: Apply business rules & cleaning in Silver layer.  
- **Load**: Build Gold layer tables for analytics & reporting.  

---

### 🗂️ Example Star Schema
- **FactEvents** → Links to player, team, competition, season.  
- **DimPlayer** → Player details (name, position, nationality).  
- **DimTeam** → Team details (team name, country).  
- **DimCompetition** → Competition details (league, cup, world cup).  
- **DimSeason** → Season metadata (year, start date, end date).  


