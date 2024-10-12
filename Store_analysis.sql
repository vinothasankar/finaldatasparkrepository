-- store performance by age

SELECT
    CASE
        WHEN YEAR(CURDATE()) - YEAR(open_date) <= 5 THEN '0 to 5'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 6 AND  10 THEN '05 to 10'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 11 AND 15 THEN '10 to 15'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 16 AND 20 THEN '15 to 20'
    END AS store_age_bucket,
    ROUND(SUM(unit_price_usd * quantity), 2) AS total_sales
FROM allinone
GROUP BY store_age_bucket;

-- stores performance by size

SELECT
    CASE
        WHEN square_meters < 250 THEN '0 to 250'
        WHEN square_meters BETWEEN 250 AND 500 THEN '0250 to 500'
        WHEN square_meters BETWEEN 501 AND 750 THEN '0500 to 750'
        WHEN square_meters BETWEEN 751 AND 1000 THEN '0750 to 1000'
        WHEN square_meters BETWEEN 1001 AND 1250 THEN '1000 to 1250'
        WHEN square_meters BETWEEN 1251 AND 1500 THEN '1250 to 1500'
        WHEN square_meters BETWEEN 1501 AND 1750 THEN '1500 to 1750'
        WHEN square_meters BETWEEN 1751 AND 2000 THEN '1750 to 2000'
        WHEN square_meters > 2000 THEN '2000 above'
    END AS size_bucket,
    ROUND(SUM(unit_price_usd * quantity),2) AS total_sales
FROM allinone
GROUP BY size_bucket
ORDER BY size_bucket;

