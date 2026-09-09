# Vivo Mobile Sales Analysis (SQL & Power BI)

## Project Overview
This project demonstrates an end-to-end data analytics solution created to track sales performance for **Vivo Mobile** in the Indian market.
The data was then cleaned, analysis in **MySQL** and visualized in **Microsoft Power BI** to provide actionable insights into revenue, customer behavior, and regional trends and more.

## Key Features
* **Executive KPI Tracking:** Real-time tracking of Total Sales (₹200M+), Total Transactions (5K), and Units Sold.
* **Geo-Spatial Analysis:** An interactive map visualizing sales distribution across major Indian cities (Mumbai, Delhi, Bangalore, etc.).
* **Customer Sentiment Analysis:** A Funnel Chart displaying the distribution of customer ratings to gauge brand satisfaction.
* **Payment Behavior Analysis:** A breakdown of transaction methods (UPI, Credit Card, EMI etc.) to understand financial preferences.
* **Time-Series Forecasting:** Monthly sales trend lines to identify peak seasons and performance dips.

## **SQL Analysis**
* Data validation using row counts, duplicate checks, and NULL-value analysis.
* Business KPI analysis using aggregation, GROUP BY, and calculated revenue metrics.
* Product, city, payment-method, age-group, and price-segment analysis.
* Advanced SQL using CTEs and window functions (RANK, LAG) for product ranking, city-level product performance, and YoY revenue analysis.
* Translated SQL findings into business recommendations for product prioritization, inventory allocation, pricing, and regional strategy.

## **Microsoft Power BI (Visualization)**
* **Data Modeling:** Star Schema implementation.
* **DAX (Data Analysis Expressions):** Calculated measures for Average Order Value (AOV) and Year-to-Date (YTD) sales.
* **Power Query:** ETL (Extract, Transform, Load) processes for data cleaning.
* **Interactive Visuals:** Slicers, Map Visuals, Funnel Charts, and Donut Charts.

## **Business Recommendations**
* **Prioritize high-revenue smartphone models:** Vivo X100 Pro generated the highest revenue at approximately ₹45.7M, followed by Vivo X100 (₹30.1M) and Vivo V30 Pro (₹21.4M). These models should receive stronger inventory availability, promotional visibility, and premium-store placement.
* **Use a dual strategy for revenue and volume:** Models such as Vivo Y17s (530 units), Vivo V29 (521 units), and Vivo T2x (521 units) show strong sales volume, while premium models such as the X100 Pro drive substantially higher revenue. Vivo can therefore maintain a mix of volume-focused models for market reach and premium models for revenue growth.
* **Localize product strategy by city:** The city-level analysis identifies the best-performing mobile model within each city, showing that product demand differs geographically. Vivo should use city-specific inventory allocation and promotions rather than applying the same product strategy across all markets.
* **Strengthen premium-model availability in cities where they lead:** The SQL results show Vivo X100 Pro ranking first across several cities, indicating strong premium-product demand in those markets. These locations can be targeted with premium campaigns, financing offers, and higher inventory allocation.
* **Use customer ratings to support product positioning:** Vivo V29, Y17s, X100 Pro and V29e achieved the highest average customer ratings in the analysis, with ratings above 4.11. These products can be promoted using customer-satisfaction messaging and positive reviews to support conversion.
* **Optimize pricing by customer segment:** Your SQL divides products into Budget (<₹15K), Mid-Range (₹15K–₹30K), and Premium (₹30K+) and calculates revenue and units sold for each segment. Vivo can use this analysis to balance promotional spending between high-volume segments and high-revenue premium products.
* **Optimize payment-based promotions:** Payment-method analysis tracks transactions, units sold, and revenue by payment type. Vivo can use this to design targeted offers such as EMI discounts for premium phones and instant-payment incentives for high-volume segments.
* **Use YoY trends for campaign planning:** The SQL LAG() analysis compares monthly revenue with the previous year's corresponding month and calculates YoY growth. This can be used to identify declining periods and plan promotions or inventory adjustments before demand drops.

## Project Files
| File Name | Description | Link |
| :--- | :--- | :--- |
| **mobile_sales_analysis.sql** | The MySQL file containing the sql queries . | [View File](https://github.com/deveshyadav0026/Mobile-Sales-Analysis-PowerBI/blob/main/moblie_sales_analysis.sql) |
| **Vivo_Sales_Dashboard.pbix** | The main Power BI file containing the dashboard and data model. | [View File](https://github.com/deveshyadav0026/Mobile-Sales-Analysis-PowerBI/blob/main/5k_Vivo_Transactions.xlsx) |
| **5k_vivo_transactions.csv** | The raw dataset used for analysis. | [View Data](https://github.com/deveshyadav0026/Mobile-Sales-Analysis-PowerBI/blob/main/5k_Vivo_Transactions.xlsx) |
| **dashboard_screenshot.jpg** | A high-quality preview of the final dashboard. | [View Image](https://github.com/deveshyadav0026/Mobile-Sales-Analysis-PowerBI/blob/main/Dashboard_Screenshot.png) |

## Dashboard Preview
![Dashboard Screenshot](Dashboard_Screenshot.png)

## Business Questions Answered
This dashboard provides answers to critical business questions, such as:
1.  **What is the total revenue and sales volume generated over the last year?**
2.  **Which specific mobile models (e.g., Vivo X100 vs. Y200) are driving the most revenue?**
3.  **How does sales performance vary across different cities (Tier 1 vs. Tier 2)?**
4.  **What are the preferred payment methods for high-value transactions vs. budget phones?**
5.  **How satisfied are customers based on rating distributions (1-star vs. 5-star)?**
6.  **Which months experienced the highest sales traffic, and can we correlate this with festivals?**

## How to Use
1.  **Clone the Repository:**
    Download the files to your local machine.
2.  **Open the SQl file in mysql:**
    If you have MySQL installed, run `mobile_sales_analysis.sql` to analysis the data.
3.  **Open in Power BI:**
    Open the `Vivo_Sales_Dashboard.pbix` file. If you downloaded new data, click "Refresh" in Power BI to load the new numbers.
4.  **Interact:**
    Use the City slicers and Month selectors to filter the data and uncover insights.

## Author
**Devesh Yadav**
