-- sales analysis

-- sales by year and month

SELECT
   YEAR(order_date) AS year,MONTHNAME(order_date) AS month,MONTH(order_date),
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  allinone
GROUP BY
  YEAR(order_date) ,MONTHNAME(order_date),Month(order_date)
  ORDER BY year,month(order_date);

-- sales by quantity performance

SELECT
  product_name,
  SUM(quantity) AS total_quantity
FROM
   allinone
GROUP BY
  product_name
Order by total_quantity Desc  
Limit 10;   

-- sales by revenue performance

SELECT
  product_name,
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  allinone
GROUP BY
  product_name
order by total_revenue_USD desc limit 10;

