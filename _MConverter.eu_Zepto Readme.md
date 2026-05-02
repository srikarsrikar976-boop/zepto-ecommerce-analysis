**Zepto E-Commerce Performance Analysis & Business Intelligence Dashboard**

This project demonstrates end-to-end data analysis capabilities, from complex SQL data manipulation to creating an interactive Business Intelligence (BI) dashboard. The goal was to analyze transactional and product data for the e-commerce platform **Zepto** to uncover key insights on sales performance, inventory health, and pricing strategy.

**Tech Stack**

| Tool                  | Purpose                                                                                                                                                    | Key Skills Demonstrated                                  |
|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| **SQL (T-SQL/MySQL)** | **Data Cleaning, Transformation, and Business Query Logic.** Used to process raw data, handle currency conversions, and create reusable database views.    | Data Modeling, Window Functions, ETL/ELT, Indexing,EDA   |
| **Power BI**          | **Data Visualization and Reporting.** Developed a comprehensive, interactive dashboard to present key performance indicators (KPIs) and business insights. | DAX, Report Design, Data Connectivity, Data Storytelling |

**Key Business Questions Answered**

The analysis focused on deriving actionable insights for management:

1.  **Revenue and Sales Performance:** Identified top-performing products and categories based on total revenue and units sold.

2.  **Inventory Health:** Created a custom view to quickly flag high-value products that are Out of Stock or in Low Stock - Urgent status.

3.  **Price Sensitivity:** Analyzed the relationship between the **Discount Percentage** offered and the **Average Units Sold** to determine the most effective promotional price bucket.

4.  **Product Segmentation:** Grouped products into logical weight categories (Low, Medium, Bulk) to assist with logistics and supply chain planning.

5.  **Pricing Value:** Calculated the **Price per Gram** for high-weight items to assess competitive value and procurement costs.

**SQL Data analysis Highlights**

The project utilized structured SQL queries and views to prepare the data for Power BI, ensuring consistency and performance:

| SQL View Name                   | Purpose                                                                                                                                                              | Key SQL Concepts                                  |
|---------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| zepto_category_performance_view | Aggregates total revenue and average discount by category.                                                                                                           | SUM(), AVG(), GROUP BY                            |
| Zepto_discount_analysis         | Classifies transactions into discount tiers (e.g., \'0-9%\', \'10-19%\').                                                                                            | CASE statements, AVG(CAST()) for metric stability |
| zepto_stock_status_view         | Applies conditional logic to availableQuantity to assign a clear Stock_Status (In Stock, Low Stock - Urgent).                                                        | CASE statements, Data Integrity Checks            |
| **Data Cleaning**               | Crucial initial steps involved cleaning out NULL and zero-priced products, and consistently converting all monetary values from **paise to rupees** by dividing by . | Data Type Conversion, WHERE Clause Filtering      |

**Power BI Dashboard Snapshot**

*(Optional: Insert a screenshot of your Power BI dashboard here or use an image link.)*

The interactive dashboard includes:

- **KPI Cards:** Total Revenue, Total Units Sold, and Overall Average Discount.

- **Visualizations:** A revenue for **Category Contribution**, a bar chart showing **Units Sold vs. Discount Bucket**, and a table highlighting **Urgent Stock Statuses**.

- **Actionable Filters:** Users can dynamically filter data by Category, Discount Bucket, and Stock Status to dive deeper into performance issues.

**Project Files and Contact**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 86%" />
</colgroup>
<thead>
<tr class="header">
<th>File</th>
<th><blockquote>
<p>Description</p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="https://drive.google.com/drive/folders/1WKQtbICb84buuTe4LnMHSbUU2vJkbGqu?usp=sharing">zepto query.sql</a></td>
<td><blockquote>
<p>Contains all the core queries, data cleaning steps, and business logic.</p>
</blockquote></td>
</tr>
<tr class="even">
<td><a href="https://drive.google.com/drive/folders/1WKQtbICb84buuTe4LnMHSbUU2vJkbGqu?usp=sharing">zepto view.sql</a></td>
<td><blockquote>
<p>Contains the T-SQL code used to create all production-ready database views.</p>
</blockquote></td>
</tr>
<tr class="odd">
<td><a href="https://drive.google.com/drive/folders/1WKQtbICb84buuTe4LnMHSbUU2vJkbGqu?usp=sharing">zepto.pbix</a></td>
<td><blockquote>
<p>The Power BI report file containing the data model, DAX measures, and final visualizations.</p>
</blockquote></td>
</tr>
</tbody>
</table>

**Google Drive link -- this is hyperlink <https://drive.google.com/drive/folders/1WKQtbICb84buuTe4LnMHSbUU2vJkbGqu?usp=sharing>**

**Connect with me:**

- **Name:** Srikar S

- **GitHub:** <https://github.com/srikarsrikar976-boop/work.git>

- **LinkedIn:** [www.linkedin.com/in/srikar412](www.linkedin.com/in/srikar412)
