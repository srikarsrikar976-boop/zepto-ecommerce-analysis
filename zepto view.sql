/*******************************************************************
-------------------- Zepto Sql Views  -----------------------------
******************************************************************/



-- Base data view
create view zepot_base_view as
select 
	Category,
	name,
	mrp  as mrp,
	discountPercent,
	availableQuantity,
	discountedSellingPrice as discountedsellingprice,
	weightInGms,
	outOfStock,
	quantity
from zepto1


-----Price sensitivity / discount effectiveness (simple correlation approximate)
	-- Average quantity sold by discount bucket
create view Zepto_discount_analysis as
	SELECT
  CASE
    WHEN discountPercent BETWEEN 0 AND 9.99 THEN '0-9%'
    WHEN discountPercent BETWEEN 10 AND 19.99 THEN '10-19%'
    WHEN discountPercent BETWEEN 20 AND 29.99 THEN '20-29%'
    ELSE '30%+'
  END AS [discount_bucket],
 round( AVG(cast(quantity as float)) ,2) AS avg_units_sold,
  SUM(quantity * discountedSellingPrice) AS revenue
FROM zepto1
GROUP BY  (CASE
    WHEN discountPercent BETWEEN 0 AND 9.99 THEN '0-9%'
    WHEN discountPercent BETWEEN 10 AND 19.99 THEN '10-19%'
    WHEN discountPercent BETWEEN 20 AND 29.99 THEN '20-29%'
    ELSE '30%+'
  END )

---find price per gram for products above  100g and sort by best value
create view zepto_price_per_gram as
select distinct name,
	weightingms,
	discountedsellingPrice,
	round(discountedsellingPrice/weightingms,2) as [price per gram]
	from zepto1 
	where weightInGms >=100

	--Category performance view
	CREATE VIEW zepto_category_performance_view AS
SELECT
    Category,
    COUNT(DISTINCT name) AS total_distinct_products,
    SUM(quantity) AS total_units_sold,
    -- Total Revenue (Converted from paise)
    SUM(quantity * (discountedSellingPrice / 100.0)) AS total_revenue_in_currency,
    -- Average Discount Offered in this Category
    AVG(discountPercent) AS avg_discount_percent
FROM
    zepto1
GROUP BY
    Category;


---Top selling prosuct
	CREATE VIEW zepto_top_selling_products_view AS
SELECT
    name,
    Category,
    SUM(quantity) AS total_units_sold,
    -- Total Revenue (Converted from paise)
    SUM(quantity * (discountedSellingPrice / 100.0)) AS total_revenue_in_currency
FROM
    zepto1
GROUP BY
    name,
    Category;

---Inventory and Stock Status View
    CREATE VIEW zepto_stock_status_view AS
SELECT
    name,
    Category,
    availableQuantity,
    outOfStock,
    CASE
        WHEN outOfStock = 'TRUE' THEN 'Out of Stock'
        WHEN availableQuantity = 0 THEN 'Out of Stock (Qty=0)'
        WHEN availableQuantity BETWEEN 1 AND 5 THEN 'Low Stock - Urgent' -- Custom Threshold for low stock
        ELSE 'In Stock'
    END AS stock_status
FROM
    zepto1;


  ----product weight categorized
create view zepto_weight as
select distinct name,
Category,
	weightingms,
	case 
		when weightInGms < 500then 'Less than 500'
        when weightInGms between 500 and 1000 then '500 to 1000'
		when weightInGms between 1000 and 5000 then '1000 to  5000'
		else 'Greater than 5000'
	end as Weight_category
from zepto1
order by Weight_category

 ----------------------------------------------- Thank you ----------------------------------------------
