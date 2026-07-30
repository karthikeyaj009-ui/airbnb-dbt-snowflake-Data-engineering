# 🏠 Airbnb Analytics Engineering Project

## End-to-End Data Pipeline using AWS S3, Snowflake & dbt Core

![Architecture](https://img.shields.io/badge/Architecture-Bronze%20%7C%20Silver%20%7C%20Gold-blue)
![Cloud](https://img.shields.io/badge/Cloud-AWS-orange)
![Warehouse](https://img.shields.io/badge/Data%20Warehouse-Snowflake-blue)
![Transformation](https://img.shields.io/badge/Transformation-dbt%20Core-red)
![Language](https://img.shields.io/badge/Language-SQL%20%7C%20Jinja-green)

---

# 📌 Project Overview

This project demonstrates an end-to-end **modern data engineering and analytics engineering pipeline** built using **AWS S3, Snowflake, and dbt Core**.

The objective of this project is to ingest raw Airbnb datasets stored as CSV files in Amazon S3, load them into Snowflake, transform and model the data using dbt following a **Bronze → Silver → Gold medallion architecture**, and create analytics-ready datasets for reporting and business intelligence use cases.

The project implements real-world data engineering practices including:

* Cloud data ingestion
* Snowflake external stages
* Data warehouse modeling
* dbt transformations
* Data lineage
* Jinja-based dynamic SQL
* Reusable macros
* Slowly Changing Dimensions Type 2 using snapshots
* Fact and dimension modeling

---

# 🏗️ Architecture Overview

```
                    AWS S3
                      |
                      |
              CSV Raw Datasets
                      |
                      |
                      ▼
              Snowflake External Stage
                      |
                      |
                      ▼
              Snowflake Bronze Layer
                      |
                      |
                      ▼
                  dbt Core
                      |
        --------------------------------
        |                              |
        ▼                              ▼
   Silver Layer                   Gold Layer

 Cleaned & Standardized       Analytics Models

 Data Transformation          OBT
                              Fact Tables
                              Dimension Tables
                              Snapshots
```

---

# 🛠️ Technology Stack

| Technology               | Purpose                                 |
| ------------------------ | --------------------------------------- |
| Amazon S3                | Storage location for raw CSV datasets   |
| AWS IAM                  | Secure authentication and authorization |
| Snowflake                | Cloud data warehouse                    |
| Snowflake External Stage | Loading data from S3                    |
| Snowflake File Format    | CSV ingestion configuration             |
| dbt Core                 | Data transformation framework           |
| dbt Snowflake Adapter    | Connect dbt with Snowflake              |
| SQL                      | Data transformation logic               |
| Jinja                    | Dynamic SQL generation                  |
| YAML                     | Source definitions and documentation    |

---

# 📂 Project Data Flow

## 1. Data Storage (AWS S3)

Raw Airbnb datasets were stored in Amazon S3 as CSV files.

Datasets include:

* Bookings
* Hosts
* Listings

Example:

```
AWS S3

airbnb-data/

├── bookings.csv
├── hosts.csv
└── listings.csv
```

---

# ☁️ AWS IAM Configuration

To allow Snowflake to securely access data from Amazon S3:

Implemented:

* IAM permissions
* S3 access policies
* AWS access keys
* Secure connection between Snowflake and S3

The required permissions were configured to allow Snowflake to retrieve CSV files from the S3 bucket.

---

# ❄️ Snowflake Data Ingestion

## Database & Schema Design

Created Snowflake database and schemas following a layered architecture.

```
AIRBNB

├── BRONZE
├── SILVER
└── GOLD
```

---

# Bronze Layer

The Bronze layer stores raw data loaded from AWS S3.

Tables:

```
BRONZE

├── BOOKINGS
├── HOSTS
└── LISTINGS
```

The data maintains the original structure from the source files.

---

# Snowflake File Format

Created CSV file format to define how Snowflake reads incoming files.

Example:

```sql
CREATE FILE FORMAT csv_format
TYPE = CSV
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
SKIP_HEADER = 1;
```

---

# Snowflake External Stage

Created external stages to connect Snowflake with Amazon S3.

Example:

```sql
CREATE STAGE airbnb_stage
URL='s3://airbnb-data/'
FILE_FORMAT=csv_format;
```

External stages allow Snowflake to directly access files stored in S3.

---

# 🔄 dbt Implementation

After loading the raw data into Snowflake, dbt Core was used to transform the data.

## dbt Setup

Configured:

* dbt Core
* Snowflake adapter
* Snowflake connection profile

This enabled dbt to execute transformations directly inside Snowflake.

---

# 🔗 Source Configuration & Data Lineage

Created dbt source YAML files to define upstream Snowflake tables.

Example:

```yaml
sources:
  - name: bronze
    database: AIRBNB
    schema: BRONZE
    tables:
      - name: BOOKINGS
      - name: HOSTS
      - name: LISTINGS
```

Benefits:

* Creates lineage tracking
* Documents source dependencies
* Enables testing
* Improves maintainability

---

# 🥉 Bronze Layer (dbt)

The Bronze layer represents the raw data loaded into Snowflake.

Purpose:

* Maintain source-level data
* Provide foundation for transformations
* Preserve original datasets

---

# 🥈 Silver Layer (dbt)

The Silver layer contains cleaned and standardized datasets.

Transformations performed:

* Data cleaning
* Column standardization
* Data type conversions
* Null handling
* Business rule implementation

Example:

```
SILVER

├── stg_bookings
├── stg_hosts
└── stg_listings
```

---

# 🥇 Gold Layer Design

The Gold layer contains analytics-ready datasets.

Two different analytical modeling approaches were implemented:

1. One Big Table (OBT)
2. Dimensional Modeling (Fact & Dimension Tables)

---

# 📊 One Big Table (OBT)

The OBT was created by using **Silver layer datasets as the source**.

Silver datasets:

* Silver Bookings
* Silver Hosts
* Silver Listings

were dynamically joined together to create a single denormalized analytical table.

## OBT Benefits

* Simplifies analytics queries
* Provides a single reporting dataset
* Reduces repeated joins
* Improves analyst productivity

Dynamic SQL generation was implemented using:

* dbt Jinja
* Dynamic join logic
* Reusable SQL patterns

Example:

```
GOLD

OBT

booking information
+
host information
+
listing information
```

---

# ⭐ Dimensional Modeling

A separate dimensional model was created for scalable BI reporting.

The model follows a star schema approach.

Architecture:

```
              dim_hosts
                  |
                  |
dim_listings --- fact_bookings --- dim_bookings
```

---

# Dimension Tables

## dim_hosts

Stores host descriptive information.

Examples:

* Host ID
* Host name
* Host attributes
* Host performance details

---

## dim_listings

Stores listing information.

Examples:

* Listing ID
* Property type
* Room type
* Location information

---

## dim_bookings

Stores booking-related attributes.

Examples:

* Booking ID
* Booking details
* Booking status
* Booking dates

---

# Fact Table

The fact table contains measurable business metrics.

It combines numerical values from:

* Hosts
* Listings
* Bookings

Examples:

* Booking amount
* Revenue metrics
* Number of nights booked
* Performance measurements

The fact table enables analytical queries such as:

* Revenue analysis
* Booking trends
* Host performance
* Listing performance

---

# 📸 dbt Snapshots (SCD Type 2)

Implemented dbt snapshots to track historical changes over time.

Snapshots were used to implement:

**Slowly Changing Dimension Type 2**

Capabilities:

* Capture record changes
* Maintain historical versions
* Track validity periods

Snapshot columns:

```
dbt_valid_from
dbt_valid_to
dbt_scd_id
```

Example:

Before:

```
Host ID: 101
Location: Dallas
```

After update:

```
Host ID: 101
Location: Austin
```

Both historical versions are maintained.

---

# ⚙️ dbt Macros

Created reusable macros to improve transformation efficiency.

Benefits:

* Avoid duplicate SQL code
* Improve maintainability
* Standardize transformation logic
* Enable reusable business rules

---

# 🗂️ Project Structure

```
aws_snowflake_dbt_project

│
├── models
│   |
│   ├── bronze
│   |
│   ├── silver
│   |
│   └── gold
│
├── snapshots
│
├── macros
│
├── tests
│
├── seeds
│
├── dbt_project.yml
│
└── README.md
```

---

# 🚀 How To Run The Project

## Install dbt

```bash
pip install dbt-core
pip install dbt-snowflake
```

---

## Install Dependencies

```bash
dbt deps
```

---

## Test Connection

```bash
dbt debug
```

---

## Run Models

```bash
dbt run
```

---

## Run Tests

```bash
dbt test
```

---

## Run Snapshots

```bash
dbt snapshot
```

---

# ✅ Key Features Implemented

✔ AWS S3 data ingestion
✔ IAM security configuration
✔ Snowflake external stages
✔ Snowflake file formats
✔ Bronze-Silver-Gold architecture
✔ dbt Core implementation
✔ Source lineage
✔ SQL transformations
✔ Jinja dynamic SQL
✔ dbt macros
✔ Snapshots for SCD Type 2
✔ Fact and dimension modeling
✔ One Big Table analytics model
✔ Ephemeral models

---

# 📈 Business Value

This project demonstrates how raw cloud data can be transformed into a scalable analytics platform.

The final Gold layer provides:

* Analytics-ready datasets
* Historical data tracking
* Optimized reporting structures
* Reusable transformation logic
* Maintainable data pipelines

The architecture follows modern practices used by Data Engineers and Analytics Engineers in enterprise data platforms.

---

# 🔮 Future Enhancements

Future improvements:

* Add automated CI/CD using GitHub Actions
* Add dbt documentation deployment
* Add Airflow orchestration
* Add Power BI dashboards
* Implement incremental models
* Add automated data quality monitoring
* Implement Snowflake Streams and Tasks

```
```
