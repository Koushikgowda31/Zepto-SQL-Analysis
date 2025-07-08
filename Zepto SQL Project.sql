create database Zepto;
use zepto;

select count(*) from zepto_v2
limit 10;

select * from zepto_v2;

# looking after the null values

select * from zepto_v2
where name is null
or
Category is null
or
mrp is null
or
discountPercent is null
or
availableQuantity is null
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null;

select category, count(distinct name)
from zepto_v2
group by category
order by count(distinct name) desc;

select name, category
from zepto_v2 where category = 'Meats, Fish & Eggs';

select name, category
from zepto_v2 where category = 'Cooking Essentials';

---- products in stock v/s outofstock

select outofstock,count(outofstock)
from zepto_v2
group by outofstock;

--- product names present multiple times

select name, count(name) as "Number of SKU"
from zepto_v2
group by name
having count(name) > 1
order by count(name) desc;

--- Data cleaning
--- product with the price = 0

select * from zepto_v2
where mrp = 0 or discountedsellingprice = 0;

--- deleting the null row

delete from zepto_v2
where mrp = 0;

select * from zepto_v2;

--- converting the paise to rupees

update zepto_v2 set mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

select mrp, discountedsellingprice from zepto_v2;

--- Q1. Find the top 10 best-value products based on the discount percentage?

select distinct name, mrp, discountpercent from zepto_v2
order by discountpercent desc
limit 10;

--- Q2. What are the products with high MRP but out of stock

select distinct name, mrp, outofstock
from zepto_v2
where mrp > 300  and outOfStock = TRUE 
order by mrp desc;

--- Q3. Calculate the estimated revenue for each category

select category, sum(discountedsellingprice * availablequantity) as total_revenue
from zepto_v2
group by category
order by total_revenue;

select sum(discountedsellingprice * availablequantity) as revenue
from zepto_v2;

--- Q4. Find all products where MRP is greater than ₹500 and discounted is less than 10%

select name,mrp,discountpercent
from zepto_v2
where mrp > 500 and discountpercent < 10
order by mrp desc, discountpercent desc;

--- Q5. Identify the top 5 categories offering the highest average discount percentage

select category, 
round(avg(discountpercent),2) as Avg_discount
from zepto_v2 
group by category
order by avg_discount desc
limit 5;

--- Q6. Find the price per gram for products above 100g and sort by best value

select distinct name,mrp,weightingms, discountedsellingprice,
round(discountedsellingprice/weightingms,2) as price_per_gm
from zepto_v2
where weightingms >= 100
order by price_per_gm desc;

--- Q7. group the products into categories like low, medium, bulk

select distinct name, weightingms, case when weightingms < 1000 then 'Low'
	when weightingms < 5000 then 'Medium'
    else 'Bulk'
    end as weight_category
from zepto_v2;

--- Q8. What is the total Inventory weight per category

select category,
sum(weightingms * availablequantity) as total_weight
from zepto_v2
group by category
order by total_weight desc;