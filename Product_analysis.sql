-- Catagory and sub catagory analysis

SELECT
    category,subcategory,
    ROUND(SUM(unit_price_usd * quantity),2) AS total_sales
FROM allinone
GROUP BY category,subcategory
ORDER BY total_sales DESC;

-- Product Popularity: Identify the most and least popular products based on sales data.

SELECT DISTINCT 
    product_name, 
    SUM(quantity) OVER (PARTITION BY product_name) AS Quantity
FROM 
    allinone
ORDER BY 
    Quantity DESC
LIMIT 1;

select distinct(product_name),sum(quantity) as Quantity
from allinone
group by product_name
order by Quantity 
limit 1;

-- Profitability Analysis: Calculate profit margins for products by comparing  unit cost and unit price.

Select
product_name,
ROUND(Sum((unit_price_usd-unit_cost_usd)*quantity),2) as Profit_Margin
from allinone
group by product_name
order by Profit_Margin desc
limit 10;
