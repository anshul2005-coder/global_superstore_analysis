# End-to-End Superstore Sales & Profitability Analytics

An end-to-end data analytics project transforming raw transactional data into actionable corporate business intelligence. This project builds a full-stack data pipeline: executing data ingestion and cleaning via Python, implementing a relational database and running deep analytical queries in MySQL Server, and deploying an interactive executive-ready dashboard in Power BI.



# 🚀 Project Deliverables & Architecture

The repository is structured to showcase clean development practices and complete tracking from raw logs to business strategy:

Python: Contains the automated Jupyter notebook handling missing value profiling, type standardization, and anomaly filtering.
SQL: Contains the production-ready script (business_analysis.sql) covering over 15+ complex aggregate and window-function queries.
Dashboard: Contains the finalized Power BI Desktop application (.pbix) utilizing decoupled custom DAX calculations.
Presentation: Features the polished executive slide deck containing embedded live system screenshots.
Superstore_Project_Report.docx: The formal 5-page corporate report detailing comprehensive methodologies and recommendations.

---

## 🛠️ Phase 1: Data Pipeline & Cleaning (Python)

Using pandas, raw transaction data was profiled to eliminate data discrepancies and establish a validated baseline dataset (clean_superstore).

Chronological Standardization: Converted arbitrary date text fields into structured datetime64 data objects to ensure precise time-series charting.
Categorical Uniformity: Sanitized string metrics across sub_category, segment, and region by trimming whitespace, standardizing case properties, and resolving duplicate entry types.
Value Safeguards: Formatted and validated numerical properties (sales, profit, discount) to ensure zero distortion during heavy aggregation steps.
Automated Injection: Programmatically exported and injected the refined dataframe into local storage environments using sqlalchemy and pymysql.

---

## 🗄️ Phase 2: Relational Database Deep-Dive (MySQL)

A comprehensive analytical framework was written to break down operational performance across categories, timelines, and customer metrics. Key focus areas include:

1. Core Financial Anchors: Aggregated multi-variable fields using mathematical functions to establish absolute performance baselines: $2.30M in Total Sales, $286.40K in Total Net Profit, and 5,000 Total Orders Processed.
2. Product Margin Diagnostics: Stack-ranked performance metrics across categorical layers. Identified Copiers and Phones as high-margin engine lines, while revealing Tables as a critical profitability leak actively draining bottom-line margins.
3. Temporal Dynamics: Extracted year-and-month segments to build chronological trends, revealing heavy, predictable revenue surges during the Third and Fourth Quarters (Q3 & Q4).
4. Customer Stratification: Tracked individual and demographic purchase habits, identifying that the Consumer Segment acts as the brand’s economic anchor, contributing over 46% ($134.12K) of net corporate profits.
5.  Discount & Margin Correlation: Used complex filters to map pricing structures, identifying a heavy negative correlation where high regional promotional discount rates directly triggered structural losses.

---

## 📊 Phase 3: Interactive Executive Dashboard (Power BI)

The analytical findings were synthesized into a unified, high-performance, single-page application focused on data density, modern layout grids, and user exploration.

### Visual Grid Architecture

Left-Hand Navigation Sidebar: Unifies all dashboard controls to optimize visual real estate. Includes text date range selectors, a category dropdown, a ship mode selector, and a premium Vertical Tile Button Slicer for immediate regional profiling.

Upper Strategic KPIs: Deployed high-impact card visuals showing Total Orders, Total Profit, and Total Sales with clean automated numerical unit scaling.

Analytical Body (Row 1): Combines a categorical Donut Chart mapping segment profit distribution, a horizontal Clustered Bar Chart tracking sub-category performance, and a Line and Stacked Column Chart mapping annual volume and margin scaling.

Operational Deep-Dive (Row 2): Integrates an active Customer Matrix Grid highlighting top buyers, a multi-variable Scatter Plot exposing the negative impact of high average discount scales, and a geographic bar chart isolating high-value states like California and New York.

### Explicit DAX Implementation
To optimize database computation speeds, raw column fields were decoupled from visual cards using explicit Data Analysis Expressions (DAX) stored inside a dedicated calculations folder:

# DAX

Total_Sales = SUM(clean_superstore[sales])

Total_Profit = SUM(clean_superstore[profit])

Total_Orders = DISTINCTCOUNT(clean_superstore[order_id])
