use zepto_project


select * from zepto1

/***************************************************************
---------------------- creating index --------------------------
***************************************************************/
CREATE CLUSTERED columnstore INDEX idx_Zepto_cs ON zepto1;
CREATE INDEX idx_category ON zepto1(Category)
create index Idx_productname on zepto1 (name);
create index Idx_StockStatus on zepto1 (outofstock,availablequantity);
create index Idx_discount on zepto1 (discountpercent);
create index Idx_revenue on zepto1 (category,discountedsellingprice,quantity);
*/

/*
drop index Idx_productname on zepto1 --(name);
drop index Idx_StockStatus on zepto1 --(outofstock,availablequantity);
drop index Idx_discount on zepto1 ----(-discountpercent);
drop index Idx_category on zepto1 --(category,discountedsellingprice,quantity);
*/
--***********************************************************************
----------------------- data exploration -------------------------------------
--*************************************************************************
select * from zepto1

--count row
select  count(*) from zepto1     --(to conform the imported no of rows)

-- Null values
select *
from zepto1
where category is null 
or name is null 
or mrp is null 
or discountPercent is null 
or availableQuantity is null 
or discountedSellingPrice is null 
or weightInGms is null 
or outOfStock is null 
or quantity is null 

-- Analysis product category
select distinct(category),
count(*) over(partition by category order by category) as item
from zepto1

-- product in stock vs out of stock
select outofstock ,
	count(sku_id) inventory_status
from zepto1
group by outOfStock

-- Product names avilable more than ones
select name,
	count(sku_id) as [no of SKU]
from zepto1
group by name
having count(sku_id)>1
order by count(sku_id) desc;
/**************************************************************
---------------------- Data cleaning ---------------------------
**************************************************************/
-- products with price zero
select *
from zepto1
where mrp in( null,0) 
	or discountedsellingprice in(null,0);

delete from zepto1
where  mrp in( null,0) 
	or discountedsellingprice in(null,0);

-- covert MRP ( paise to rupee)
update zepto1
set mrp = mrp/100.0 ,
	discountedSellingPrice= discountedSellingPrice/100;

select mrp, discountedsellingprice
from zepto1;


/**********************************************************
----------------------Business qustion---------------------
************************************************************/

--Q1. Find top 10 best selling products
select 
	distinct top 10 name,
	mrp,
	discountpercent

from zepto1
order by discountPercent desc;

--Q2.What are the products with high MRP but out of stock
	select distinct name,	
		mrp
	from zepto1
	where outOfStock = 1 and mrp >300
	order by mrp  desc

--Q3. Calculate Estimate Revenue for each category
    select 
	category,
	sum(discountedsellingprice * quantity) as revenue,
	sum(quantity) as unit_sold
	from zepto1
	group by category
	order by sum(discountedsellingprice * quantity) desc
	;

--Q4. top 20 products by revenue
	select distinct top 20 name,
	sum(discountedsellingprice * quantity) as revenue,
	sum(quantity) as unit_sold
	from zepto1
	group by name
	order by revenue desc

--Q5. inventory value 

select 
	category,
	sum(availablequantity  * discountedsellingprice) as inventory
from zepto1
	group by Category
	order by inventory desc
  
  --total inventory value
  select 
	sum(availablequantity  * discountedsellingprice) as inventory_value
	from zepto1

 --Q6 High discounted product 
  select top 10 name,
  Category,
	discountpercent
	from zepto1 as a
	where discountPercent >0
	order by discountPercent desc;

--Q7. avgerage discount for each category and top 5 category
	select top 5
	category,
		round(avg(discountpercent),2) [avg discount]
	from zepto1
	
	group by Category
	order by [avg discount] desc

--Q8. Price sensitivity / discount effectiveness (simple correlation approximate)
	-- Average quantity sold by discount bucket
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
ORDER BY discount_bucket;

--Q9. find price per gram for products above  100g and sort by best value
select distinct name,
	weightingms,
	discountedsellingPrice,
	round(discountedsellingPrice/weightingms,2) as [price per gram]
	from zepto1 
	where weightInGms >=100
	order by [price per gram] desc

---Q10.Group the products into category like low medium, bulk
select distinct name,
Category,
	weightingms,
	case 
		when weightInGms < 1000 then 'Low'
		when weightInGms between 1000 and 5000 then 'medium'
		else 'Bulk'
	end as Weight_category
from zepto1
order by Weight_category


--Q11.What is the total inventory weight per category
 select category ,
	sum(weightInGms * availablequantity)/1000 as total_weight_in_KG
 from zepto1
 group by Category
 order by total_weight_in_KG desc


 ----------------------------------------------- Thank you ----------------------------------------------