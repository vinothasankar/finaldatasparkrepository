SELECT DISTINCT gender, 
       COUNT(*) OVER (PARTITION BY gender) AS Count_gender
FROM customers;

-- Age bucketing
SELECT
    age_bucket,
    COUNT(*) AS count
FROM (
    SELECT
        *,
        CASE
            WHEN YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) <= 18 THEN '<=18'
            WHEN YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 18 AND 25 THEN '18-25'
            WHEN YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 25 AND 35 THEN '25-35'
            WHEN YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 35 AND 45 THEN '35-45'
            WHEN YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 45 AND 55 THEN '45-55'
            WHEN YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 55 AND 65 THEN '55-65'
            ELSE '>65'
        END AS age_bucket
    FROM allinone
) AS age_groups
GROUP BY age_bucket;


-- country wise customer count
SELECT 
    continent,country,state,city, 
    COUNT(customerkey) AS customer_count
FROM 
    customers
GROUP BY 
    continent,country,state,city
ORDER BY 
    customer_count DESC;

--average order value

SELECT customercountry,customerkey,round(avg(quantity*unit_price_usd),2) AS Average_order_value 
FROM 
allinone
GROUP BY
customerkey,customercountry
ORDER BY
Average_order_value DESC;

--purchase frequency

SELECT 
    customerkey,
    name,
    COUNT(DISTINCT order_number) AS TotalOrders,
    (COUNT(DISTINCT order_number)/(DATEDIFF(MAX(order_date), MIN(order_date))+1)) AS PurchaseFrequency
    FROM 
    allinone
GROUP BY 
    customerkey,
    name
ORDER BY 
	PurchaseFrequency desc;					
