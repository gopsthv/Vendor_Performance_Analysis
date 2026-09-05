# Vendor Performance Analysis

An end-to-end data analytics project...

GitHub will render that as a proper heading, not show the #.

And things like:

## Project Overview

### Business Objectives

- Identify the vendors generating the highest sales.
- Identify the vendors generating the highest gross profit.

will automatically become proper GitHub headings and bullet points.

One correction

The README I just gave you is the content/draft. Before you paste it, I'd actually like to give you a final polished version specifically formatted for GitHub, including:

proper Markdown headings
badges if useful
project structure
clickable sections/table of contents
dashboard image embeds using your actual repository paths
Python/SQL/Power BI sections
methodology
metrics
insights
data limitation
clean professional wording

So don't paste the previous one yet.

I'll give you the final README.md as one copy-paste-ready Markdown block next.

Okay, then give me the correct version where I just copy it and paste it and it would be good in that format.

Absolutely. This is the copy-paste-ready README.md version.

Copy everything inside this single block and paste it directly into your GitHub README.md. GitHub will render the headings, tables, images, bullets, and code blocks properly.

# Vendor Performance Analysis

An end-to-end data analytics project analyzing vendor performance, product profitability, and inventory efficiency using **Python, SQL, MySQL, and Power BI**.

The project follows the complete analytics workflow — from understanding and validating raw data to transforming it into analytical datasets and building an interactive Power BI dashboard.

---

## 📌 Project Overview

Managing a large number of vendors and products requires understanding which vendors and products contribute most to revenue and profit, which areas have weaker profitability, and where inventory may be moving slowly.

This project analyzes sales, purchasing, vendor, product, and inventory data to provide insights into:

- Vendor sales performance
- Vendor profitability
- Product sales performance
- Product profitability
- Profit margins
- Inventory levels and changes
- Inventory turnover
- Slow-moving inventory

The project was developed as an **end-to-end data analytics workflow**, combining Python for data preparation and exploration, SQL for data transformation and analysis, and Power BI for visualization and reporting.

---

## 🎯 Business Objectives

The analysis aims to answer the following business questions:

1. Which vendors generate the highest sales?
2. Which vendors generate the highest gross profit?
3. Which vendors have stronger or weaker profit margins?
4. Which products generate the most revenue?
5. Which products generate the most gross profit?
6. Which products have low or negative profitability?
7. How does inventory change between the beginning and end of the year?
8. Which products have significant inventory changes?
9. Which products have low inventory turnover and may be slow-moving?
10. Which products hold the largest amount of inventory value at the end of the year?

---

# 🔄 Project Workflow

```text
Raw Data
    │
    ▼
Python / Pandas
Data Understanding
Data Cleaning
Data Exploration
Data Validation
    │
    ▼
MySQL / SQL
Database Setup
Joins
Aggregations
Business Calculations
Analytical Tables
    │
    ▼
Power BI
Data Model
DAX Measures
KPIs
Visualizations
    │
    ▼
Business Insights
🗂️ Repository Structure
Vendor_Performance_Analysis/
│
├── Dashboard/
│   └── vendor performance analysis.pbix
│
├── Images/
│   ├── Executive_overview.png
│   ├── Vendor_performance.png
│   ├── product performance.png
│   └── Inventory_performance.png
│
├── Notebook/
│   └── 01_data_understanding.ipynb
│
├── Sql/
│   └── vendor_performance_analysis.sql
│
└── README.md

The original raw and processed datasets are not included in this repository because of their large file sizes. The datasets, their structure, and the analytical workflow are documented throughout the project.

📊 Dataset

The project uses multiple datasets representing sales, purchasing, vendors, products, and inventory.

Main datasets
Dataset	Description
Sales	Transaction-level sales information
Purchases	Vendor purchase transactions
Beginning Inventory	Inventory position at the beginning of the period
Ending Inventory	Inventory position at the end of the period
Purchase Prices	Product-level purchase price information
Vendor Invoice	Vendor invoice and freight-related information

The sales dataset contains more than 12.8 million records, providing a large dataset for demonstrating practical data-processing and analytical techniques.

🐍 Python — Data Understanding & Exploration

Python and Pandas were used as the first stage of the project.

The 01_data_understanding.ipynb notebook contains the initial data analysis and validation performed before moving the data into SQL.

Data Loading

The source datasets were loaded and inspected using Pandas.

Data Understanding

The datasets were examined to understand:

Number of rows and columns
Column names
Data types
Date ranges
Unique vendors
Unique products
Missing values
Duplicate records
Numerical fields and distributions
Data Quality Checks

Several validation checks were performed, including:

Missing-value analysis
Duplicate detection
Data-type validation
Quantity and price validation
Purchase amount validation
Vendor and product consistency checks
Matching sales products with purchase-price data
Exploratory Data Analysis

The data was explored to identify:

Top vendors by sales
Vendor sales distribution
Product sales performance
Purchase patterns
Inventory characteristics
Vendor and product relationships

Python was primarily used for data understanding, cleaning, exploration, and validation before performing the main analytical transformations in SQL.

🗄️ SQL / MySQL — Data Transformation & Analysis

After understanding and validating the datasets in Python, the data was loaded into a MySQL database.

Database
vendor_performance_analysis
Main Tables
sales
purchases
begin_inventory
end_inventory
purchase_prices
vendor_invoice

SQL was used for:

Database and table creation
Joining datasets
Aggregating transaction-level data
Vendor-level analysis
Product-level analysis
Inventory analysis
Profitability calculations
Inventory turnover calculations
Creating analytical datasets
📐 Key Business Metrics
Gross Profit

Gross profit was calculated as:

Gross Profit = Sales Revenue - Cost of Goods Sold

For product-level analysis, Cost of Goods Sold was calculated using:

COGS = Sales Quantity × Purchase Price

Purchase prices were matched to sales using the product Brand.

Profit Margin
Profit Margin = Gross Profit / Sales Revenue × 100

Profit margin was used to compare profitability across vendors and products independently of their overall sales volume.

Average Inventory
Average Inventory =
(Beginning Inventory + Ending Inventory) / 2

Average inventory provides the inventory base used when calculating inventory turnover.

Inventory Turnover
Inventory Turnover =
COGS / Average Inventory

A lower inventory turnover indicates that inventory is moving more slowly relative to the amount of inventory being held.

📋 Analytical Datasets

Three main analytical datasets were created for the Power BI dashboard.

vendor_performance

Contains vendor-level performance metrics such as:

Vendor Number
Vendor Name
Total Sales
Total Purchase Cost
Gross Profit
Profit Margin
product_performance

Contains product-level performance metrics such as:

Brand
Product Description
Total Sales
Total Purchase Cost
Gross Profit
Profit Margin
inventory_performance

Contains inventory-level performance metrics such as:

Brand
Product Description
Beginning Inventory Value
Ending Inventory Value
Inventory Change
Average Inventory
COGS
Inventory Turnover
📊 Power BI Dashboard

The final analytical datasets were imported into Power BI to create a four-page interactive dashboard.

The dashboard uses DAX measures, KPI cards, filters, and multiple visualization types to present the analysis.

1️⃣ Executive Overview

The Executive Overview provides a high-level summary of vendor, product, sales, profitability, and inventory performance.

KPI Cards
Total Sales
Total Gross Profit
Overall Profit Margin
Total Vendors
Total Products
Visualizations
Top vendors by sales
Top vendors by gross profit
Top products by sales
Beginning vs Ending Inventory
Dashboard Preview

2️⃣ Vendor Performance

This page focuses on vendor-level sales and profitability.

KPI Cards
Total Sales
Total Gross Profit
Overall Profit Margin
Total Vendors
Analysis
Total sales by vendor
Gross profit by vendor
Profit margin by vendor
Top vendors by sales compared with gross profit
Bottom-performing vendors by gross profit
Dashboard Preview

3️⃣ Product Performance

This page analyzes product-level revenue and profitability.

KPI Cards
Total Sales
Total Gross Profit
Total Products
Analysis
Top products by sales
Top products by gross profit
Sales vs Gross Profit comparison
Bottom products by gross profit
Dashboard Preview

4️⃣ Inventory Performance

This page focuses on inventory levels and inventory efficiency.

KPI Cards
Total Beginning Inventory
Total Ending Inventory
Total Inventory Change
Average Inventory Turnover
Analysis
Beginning vs Ending Inventory
Products with the largest inventory changes
Slow-moving products based on inventory turnover
Products with the highest ending inventory values
Dashboard Preview

🔎 Key Insights

The analysis provides several useful business insights.

Vendor Performance

High sales volume does not necessarily mean high profitability. Comparing vendor sales with gross profit and profit margin helps identify vendors that generate significant revenue while operating at different levels of profitability.

Product Performance

A relatively small group of products contributes significantly to overall sales and gross profit, making these products important contributors to business performance.

Profitability

Profit margin provides additional context beyond revenue by identifying vendors and products that generate stronger or weaker returns.

Inventory

Comparing beginning and ending inventory highlights changes in the amount of capital tied up in inventory.

Products with low inventory turnover may indicate slow-moving inventory, which can increase holding costs and tie up working capital.

🛠️ Tools & Technologies
Programming & Data Analysis
Python
Pandas
Jupyter Notebook
Database & Data Transformation
MySQL
SQL
Business Intelligence
Microsoft Power BI
DAX
Version Control
Git
GitHub
💡 Skills Demonstrated

This project demonstrates practical experience with:

Data cleaning
Data exploration
Exploratory data analysis
Data validation
Large dataset processing
Pandas
SQL joins
SQL aggregations
Database design
Data transformation
Business metric development
Vendor performance analysis
Product profitability analysis
Inventory analysis
Inventory turnover analysis
DAX
Power BI data modelling
KPI development
Dashboard design
Business insight generation
🚀 Project Outcome

The project transformed raw sales, purchasing, vendor, product, and inventory data into structured analytical datasets and an interactive Power BI dashboard.

The final solution provides a consolidated view of:

Vendor Performance
        │
        ├── Sales
        ├── Gross Profit
        └── Profit Margin
              │
              ▼
Product Performance
        │
        ├── Sales
        ├── Gross Profit
        └── Profit Margin
              │
              ▼
Inventory Performance
        │
        ├── Inventory Change
        ├── Ending Inventory
        └── Inventory Turnover

This project demonstrates an end-to-end data analytics workflow, from raw data understanding and preparation through SQL-based transformation and analysis to business intelligence reporting in Power BI.

📁 Data Availability

The original raw and processed datasets are not included in this repository because of their large file sizes.

The repository contains the Python notebook, SQL analysis scripts, Power BI dashboard, dashboard screenshots, and project documentation required to understand the workflow and analytical approach.
