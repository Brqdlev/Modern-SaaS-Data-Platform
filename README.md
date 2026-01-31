Modern SaaS Data Platform with Orchestration & Data Reliability

📌 Project Overview

This project implements a modern, production-style SaaS data platform designed to address common data engineering failure modes such as silent data issues, unreliable incremental loads, and lack of observability.

The platform ingests data from a MySQL OLTP system, performs incremental extraction using self-hosted Airbyte, loads data into a PostgreSQL OLAP / data warehouse, applies transformations using dbt with a medallion architecture, and orchestrates the entire workflow using self-hosted Apache Airflow.

Beyond standard ELT, this project focuses on data reliability, anomaly detection, and preventing silent data failures—a frequent issue in real-world SaaS pipelines.

---

🚨 Problems Addressed (Before This Architecture)

This project was designed to solve and avoid several real-world data platform problems:

❌ Silent Data Failures
- Pipelines can succeed technically while data is:
  - Incomplete
  - Duplicated
  - Stale
  - Skewed
- Business users often discover issues too late

❌ Unreliable Incremental Loads
- Full reloads do not scale
- Incorrect incremental logic can:
  - Miss events
  - Double-count usage
  - Break downstream metrics

❌ No Observability into Data Health
- Traditional pipelines lack visibility into:
  - Volume changes
  - Distribution anomalies
  - Data freshness
  - Trend breaks

❌ No Clear Separation of Concerns
- Mixing raw ingestion and transformations
- Difficult debugging
- Hard to scale transformations safely

---

🏗️ Architecture

High-level flow:


---

🗂️ Data Domain (SaaS Platform)

The datasets represent a typical SaaS application event-driven architecture:

- **accounts** – Customer and tenant information  
- **users** – End users linked to accounts  
- **subscriptions** – Plans and billing relationships  
- **billing_events** – Charges, invoices, and payments  
- **usage_events** – Product usage metrics  
- **login_events** – Authentication activity  
- **incidents** – Customer-facing incidents  
- **incident_events** – Incident lifecycle events  

---

🔄 Data Pipeline & Design Decisions

1. OLTP Source – MySQL (Dockerized)
- Simulates a production SaaS transactional database
- Event-based and append-heavy tables
- Designed to reflect real SaaS workloads

---

2. Ingestion – Self-Hosted Airbyte (Incremental)
Problem Solved: Inefficient full reloads and duplicated data  

- Incremental extraction based on event timestamps / IDs
- Minimizes load on the source system
- Ensures scalability as data volume grows
- Raw data loaded with **no transformations applied**

---

3. Data Warehouse – PostgreSQL (OLAP)
Problem Solved: Lack of a centralized analytical store  

- Acts as the analytical source of truth
- Optimized for transformations and analytics
- Decouples analytics from the OLTP system

---

🧱 dbt Medallion Architecture

🟫 Bronze Layer (Raw Ingestion)
Goal: Preserve source fidelity

- No transformations
- Duplicates allowed
- No business logic
- Used strictly for lineage and recovery

Problem Avoided: Loss of raw data and inability to reprocess

---

🧪 Staging Layer (Normalization & Validation)
Goal: Make data usable and testable

- Column renaming and standardization
- Data type conversions
- Basic normalization
- dbt tests:
  - `not_null`
  - `unique`
  - Referential integrity

Problem Avoided: Propagating bad data downstream

---

🥈 Silver Layer (Trusted & Enriched Data)
Goal: Analytics-ready, reliable datasets

- Deduplication logic
- Business-level transformations
- Clean, query-ready tables

---

📈 Data Health & Anomaly Metrics (Custom Table)
Key Differentiator of This Project**

A dedicated table was created to detect SILENT DATA FAILURES, tracking:

- Data volume per account
- Event distribution changes
- Data freshness
- Trend shifts
- Moving averages for anomaly detection

This table allows proactive monitoring of data quality even when pipelines technically succeed.

Problem Solved: Pipelines succeeding while data quality silently degrades

---

⏱️ Orchestration – Self-Hosted Apache Airflow

Problem Solved: Uncontrolled execution and dependency failures  

- Orchestrates:
  - Airbyte ingestion
  - dbt transformations
  - Data health metrics generation
- Clear task dependencies
- Retry logic and observability
- Single control plane for the entire platform

---

#🛠️ Tech Stack Summary

| Layer | Tools |
|-----|------|
| OLTP | MySQL (Dockerized) |
| Ingestion | Self-Hosted Airbyte |
| Data Warehouse | PostgreSQL |
| Transformations | dbt |
| Orchestration | Apache Airflow |
| Programming | Python, SQL |

---

🎯 Key Learnings & Outcomes

- Built a **production-style SaaS data platform**
- Implemented **incremental ingestion correctly**
- Designed a **robust medallion architecture**
- Addressed **silent data failures proactively**
- Added **data observability beyond pipeline success**
- Orchestrated a full ELT workflow end-to-end

---

🚀 Future Improvements

- Automated alerting based on anomaly thresholds
- Metadata-driven data quality checks
- Partitioning and performance optimization
- Integration with BI or metrics dashboards
- Migration to cloud-native services

---

📎 Author

Bradley Alojado
Data Engineer | Analytics Engineer  
Portfolio Project #3

---



