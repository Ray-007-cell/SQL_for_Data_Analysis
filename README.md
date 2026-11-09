# SQL for Data Analysis – Brazilian E-Commerce (Olist) Dataset

## Project Overview

This project focuses on exploring and analyzing the Brazilian E-Commerce (Olist) dataset using **Microsoft SQL Server**. It demonstrates essential SQL skills used in data analysis, including data exploration, filtering, sorting, aggregation, joins, subqueries, views, and indexing.

The objective is to extract meaningful information from structured datasets and develop practical SQL skills for solving real-world data analysis problems.

## Dataset

The project uses the Brazilian E-Commerce Public Dataset by Olist.

**Tables used:**
- `olist_customers_dataset` – Customer details such as customer ID, city, state, and ZIP code prefix.
- `olist_orders_dataset` – Order details, including order ID, customer ID, order status, and timestamps.

**Dataset size:**
- Customers: 99,441 records
- Orders: 99,441 records

## Tools & Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL

## SQL Concepts Covered

### 1. Data Exploration
- SELECT statements
- TOP
- COUNT
- DISTINCT
- Checking table structure and records

### 2. Filtering and Sorting
- WHERE clause
- AND / OR conditions
- ORDER BY
- Filtering records using specific conditions

### 3. Aggregate Functions
- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()
- GROUP BY
- HAVING

### 4. Joins
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN

### 5. Subqueries
- Nested queries
- IN
- NOT EXISTS

### 6. Views
- Creating and querying views
- Understanding reusable SQL queries

### 7. Indexing and Query Optimization
- Creating indexes
- Understanding index usage
- Exploring query execution plans

## Repository Structure

```text
SQL_for_Data_Analysis/
│
├── Dataset/
│   ├── olist_customers_dataset.csv
│   └── olist_orders_dataset.csv
│
├── SQL/
│   └── Olist_SQL_Data_Analysis.sql
│
├── Screenshots/
│   ├── 01_Data_Exploration.png
│   ├── 02_Filtering_Grouping.png
│   ├── 03_Aggregates_Having.png
│   ├── 04_Inner_Join.png
│   ├── 05_Left_Right_Join.png
│   ├── 06_Subqueries.png
│   ├── 07_Views.png
│   └── 08_Indexes.png
│
└── README.md
```

## How to Run the Project

1. Download or clone this repository.
2. Open SQL Server Management Studio (SSMS).
3. Create a database named `Olist_Ecommerce_Analysis`.
4. Import the customer and orders CSV files into SQL Server.
5. Open `Olist_SQL_Data_Analysis.sql`.
6. Execute the queries section by section.

## Key Learning Outcomes

- Practiced writing SQL queries to retrieve and analyze structured data.
- Learned to filter, sort, and aggregate records.
- Applied different types of joins to combine related tables.
- Used subqueries to solve analytical problems.
- Created views for reusable queries.
- Explored indexing and query execution plans.

## Screenshots

The `Screenshots` folder contains generated, data-based query-result previews illustrating the SQL queries and their expected outputs. These are reference previews, not direct screenshots captured from SSMS.

## Conclusion

This project provided practical experience in SQL-based data analysis using a real-world e-commerce dataset. It strengthened my understanding of relational databases and the SQL techniques commonly used in data analyst roles.

---

**Author:** Manish Deora  
**GitHub:** [Ray-007-cell](https://github.com/Ray-007-cell)
