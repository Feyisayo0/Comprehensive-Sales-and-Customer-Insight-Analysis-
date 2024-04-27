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
The project entailed analyzing a Shopify store's sales data to filter out fraudulent transactions, identify the prime customer demographics, and track sales trends. Aimed at enhancing marketing efforts and operational strategy, this deep-dive into customer and sales data provides a robust foundation for informed decision-making.

### Data Source
The primary data sources included two CSV files: 
'Orders', containing transaction details such as order ID, user ID, and order amount
'Customers', housing customer-specific information like IDs and demographics.

### Tools
- csvfiddle.io: Used for initial data upload and SQL query testing.
- SQL: Employed for all data manipulation tasks including filtering, aggregation, and analysis.

### Data Cleaning and Preparation
For the data preparation phase, it involved the following steps;
- data loading and inspection
- handling missing values (involved removing duplicate entries from the 'Customers' table)
- handling outliers(filtering out fraudulent transactions identified by extreme order values)
  ``` sql
  DELETE FROM orders
  WHERE order_amount = 704000;
  ```
- data validation (data types were validated and converted to ensure consistency across the dataset.

### Exploratory Data Analysis
The Exploratory Data Analysis phase involves exploring the datasets used to answer key questions, such as:
- What is the true Average Order Value (AOV) on the platform after excluding outliers and potential fraudulent transactions?
- Which order size category is most prevalent among customers, and how does it compare to other order size frequencies?
- Which geographic location houses the majority of our customer base, and what are the characteristics of this demographic?
- Who are our top 10 customers in terms of total spending, and what are their demographic profiles including age group and location?

### Data Analysis 
The data analysis phase leveraged SQL to:
- Compute the AOV, revealing an initial overestimation due to outliers.
- Employ CTEs to efficiently segment order sizes, refining the focus on the most frequent categories.
- Merge sales with customer demographics, unraveling the profile of top spenders.

### Recommendations
The Analysis results are summarized as follows;
The analysis results are summarized as follows:
- The corrected AOV stood at $754.09, a more accurate reflection of customer spending.
- Small orders (1-2 items) emerged as the majority, suggesting a customer preference for selective, potentially high-value items.
- California surfaced as a key customer hub, indicating a strong market presence that could be further cultivated.

### Results
Based on the analysis, the following  actions are recommended:
- Focus on the younger demographic of 20-29-year-olds, as suggested by their higher AOV and order frequency.
- Explore cross-selling and upselling strategies to increase the average size of orders.
- Capitalize on the customer density in California with region-specific promotions.

### Limitations
The analysis was limited by the data provided and may not account for all factors influencing sales trends, such as seasonal variability or broader economic conditions. The data cleaning process assumed that extreme values were anomalies without further contextual data, which could potentially exclude valid high-value transactions.

### References
Smart SQL
