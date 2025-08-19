# 📂 Project Initialization

---

## 🏗️ Create Git Repository
1. Go to [GitHub](https://github.com/) → Create new repository.  
   - Repository name: **statsbomb-dwh**  
   - Description: *Data Warehouse project for StatsBomb open-data (bronze → silver → gold)*  
   - Visibility: **Public** (recommended for portfolio)  

2. Initialize with:
   - `.gitignore` → Python, SQL, VSCode (if you use it)  
   - `README.md` → Base project description  
   - License (MIT recommended)  

---

## 📁 Suggested Folder Structure

```plaintext
statsbomb-dwh/
│── 📂 docs/                     # Documentation
│   ├── Requirements Analysis/
│   ├── Project Naming Conventions/
│   ├── Project Initialization/
│   └── Design Data Architecture/
│
│── 📂 sql/                      # SQL scripts
│   ├── 01_create_database.sql
│   ├── 02_create_schemas.sql
│   ├── 03_bronze_tables.sql
│   ├── 04_silver_tables.sql
│   ├── 05_gold_tables.sql
│   └── procedures/
│
│── 📂 etl/                      # ETL jobs
│   ├── load_bronze.py
│   ├── transform_silver.py
│   ├── build_gold.py
│   └── scheduler.md
│
│── 📂 data_raw/                 # Raw StatsBomb open-data
│   ├── competitions/
│   ├── matches/
│   └── events/
│
│── 📂 data_processed/           # Cleaned datasets (optional exports)
│
│── 📂 dashboards/               # Power BI / Tableau dashboards
│
│── 📂 tests/                    # Unit tests for ETL/SQL
│
│── requirements.txt             # Python dependencies
│── README.md                    # Main project readme
