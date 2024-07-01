# Sales and Customer Insight Analysis
A comprehensive sales and customer insight analysis which will be helpful for optimized marketing strategy

## Table of Content
- [Project Overview](project-overview)
- [Data Source](#data-source)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning-and-preparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Recommendations](#recommendations)
- [Results](#results)
- [Limitations](#limitations)
- [References](#references)
 
### Project Overview
This project involves analyzing sales data from an e-commerce store that specializes in selling designer sneakers. The objective is to clean the data, identify and exclude fraudulent transactions, categorize orders based on size, analyze customer demographics, and calculate week-over-week growth in order values. The insights gained from this analysis will guide business decisions, improve marketing strategies, and enhance overall sales performance.

### Data Source
The dataset includes two CSV files: Orders and Customers. The Orders file contains information about individual orders, including order amount, total items, payment method, and order date. The Customers file contains demographic information about customers, including user ID, age group, and state.

### Tools
- csvfiddle.io: For importing and querying CSV data.
- SQL: For data cleaning, transformation, and analysis.

### Data Cleaning and Preparation
For the data preparation phase, it involved the following steps;
- data loading and inspection
- handling missing values (involved removing duplicate entries from the 'Customers' table)
- handling outliers(filtering out fraudulent transactions identified by extreme order values)
  ``` sql
    SELECT 
        order_id,
        user_id,
        order_amount,
        total_items,
        payment_method,
        created_at
    FROM 
        orders
    WHERE 
        order_amount < 700000 -- Excluding the fraudulent order amount of 704000
  ```
- data validation (data types were validated and converted to ensure consistency across the dataset).

### Exploratory Data Analysis
The Exploratory Data Analysis phase involves exploring the datasets used to answer key questions, such as:
- What is the Average Order Value (AOV) on the platform after excluding outliers and fraudulent transactions?
- Which order size category is most prevalent among customers, and how does it compare to other order size frequencies?
- Which geographic location houses the majority of our customer base, and what are the characteristics of this demographic?
- Who are our top 10 customers in terms of total spending, and what are their demographic profiles including age group and location?

### Data Analysis 
- The frequency and percentage of each order size category were calculated to understand the distribution of order sizes.
- The distribution of customers by state and the identification of the state with the majority of customers were analyzed.
- The top 10 customers based on total spend were identified, and their demographic information was analyzed to determine their common locations and age groups.
- The growth in total order values from one week to the next was calculated to identify trends in sales performance.

### Recommendations
- Target Marketing: Focus marketing efforts on California (CA) and customers in the 40-50 age group, as they represent the majority of top customers.
- Inventory Management: Maintain a balanced inventory with a higher emphasis on items that are commonly part of small orders (1-2 items).
- Fraud Detection: Implement stricter validation checks to prevent and identify fraudulent transactions early.

### Results
- Correct AOV: After excluding fraudulent transactions, the correct Average Order Value (AOV) was calculated to be $754.09.
- Order Size Distribution: Small orders (1-2 items) were the most frequent, accounting for 73.49% of all orders.
- Customer Demographics: California (CA) had the highest number of customers, with 159 customers, predominantly in the 40-50 age group.
- Top Customers: The majority of the top 10 customers based on total spend were located in California and belonged to the 40-50 age group.
- Week-over-Week Growth: Detailed weekly sales performance and growth trends were identified, allowing for better sales tracking and forecasting going forward.
![Week-Over-Week Table](![Week-Over-Week Table](https://github.com/Feyisayo0g/Comprehensive-Sales-and-Customer-Insight-Analysis-/blob/main/week-over-week.png)

### Limitations
- Data Quality: The presence of fraudulent transactions and data entry errors (e.g., order amount of $704,000 instead of $704) impacted initial analysis results and required data cleansing. 
- Data Completeness: The analysis is limited to the available data and may not account for other influential factors such as seasonal trends or promotions.
