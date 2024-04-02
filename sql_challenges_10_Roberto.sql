/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 10

*******************************************************************************
*******************************************************************************


In the exercises below you will need to use the clauses you used in the
previous SQL Challenges, plus the following clauses:
    - CASE
*/

/*******************************************************************************
CASE

https://www.w3schools.com/sql/sql_case.asp
*******************************************************************************/

/* 1. Select everything from the sales table and create a new column called 
   "sales_category" with case conditions to categorise qty:
   
		qty >= 50 high sales
		20 <= qty < 50 medium sales
		qty < 20 low sales
*/
select *,
CASE
when qty >= 50 then "high sales"
when (qty <= 20 and qty < 50) then "medium sales"
else "low sales"
end AS  sales_category
from sales;


/* 2. Given your three sales categories (high, medium, and low), 
   calculate the total number of books sold in each category. 
*/
select SUM(qty),
CASE
when qty >= 50 then "high sales"
when (qty <= 20 and qty < 50) then "medium sales"
else "low sales"
end AS  sales_category
from sales
GROUP BY sales_category;

Select sales_category, count(stor_id) from (Select *,
case 	when qty >= 50 then 'high sales'
		when qty >= 20 AND qty < 50 then 'medium sales'
        when qty < 20 then 'low sales'
end as sales_category
from sales
order by qty ASC) as new_table
group by sales_category
;


/* 3. Adding to your answer from the previous questions: output only those 
   sales categories that have a SUM(qty) greater than 100, and order them in 
   descending order */
   
/*select SUM(qty) AS Sum_qty
CASE
when qty >= 50 then "high sales"
when (qty <= 20 and qty < 50) then "medium sales"
else "low sales"
end AS  sales_category
from sales
GROUP BY Sum_qty DESC;*/
Select
CASE
when qty >= 50 then'high sales'
when qty between 20 and 50 then 'medium sales'
else'low sales'
END as sales_category,
sum(qty)
from sales 
group by sales_category
Having sum(qty)>100 
order by sum(qty) desc;

/* 4. Find out the average book price, per publisher, for the following book 
    types and price categories:
		book types: business, traditional cook and psychology
		price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high
        
    - When displaying the average prices, use ROUND() to hide decimals. */

/*select ROUND (AVG(price)) AS avg_price,pub_id,
CASE
when price <= 5 then "super_low"
when (price >5 and price <= 10) then "low"
when (price >10 and price <=15) then "medium"
else "high"
end AS  Price_lvl
from titles
where type IN ("business","trad_cook","psychology")
group by pub_id */

SELECT ROUND(AVG(price)) AS avg_price, pub_id,
    CASE
        WHEN AVG(price) <= 5 THEN 'super_low'
        WHEN (AVG(price)>5 and AVG(price) <= 10) THEN 'low'
        WHEN (AVG(price)>10 and AVG(price) <= 15) THEN 'medium'
        ELSE 'high'
    END AS Price_lvl
FROM titles
WHERE type IN ('business', 'trad_cook', 'psychology')
GROUP BY pub_id;

SELECT ROUND(AVG(price)) AS avg_price, pub_id,
    CASE
        WHEN price <= 5 THEN 'super_low'
        WHEN price <= 10 THEN 'low'
        WHEN price <= 15 THEN 'medium'
        ELSE 'high'
    END AS Price_lvl
FROM titles
WHERE type IN ('business', 'trad_cook', 'psychology')
GROUP BY pub_id, 
    CASE
        WHEN price <= 5 THEN 'super_low'
        WHEN price <= 10 THEN 'low'
        WHEN price <= 15 THEN 'medium'
        ELSE 'high'
    END;
    SELECT pub_id, type, price_category, round(AVG(price)) AS avg_price from (Select *,
	case	when price <= 5 then 'super low'
			when price > 5 and price <= 10 then 'low'
			when price > 10 and price <= 15 then 'medium'
			when price > 15 then 'high'
	end as price_category
from titles
where type in ('business', 'trad_cook', 'psychology')
)
as new_table
group by pub_id, type, price_category
order by pub_id, type, price_category;

/*PROFE */

SELECT ROUND(AVG(price)), COUNT(pub_id) ,
	CASE
		WHEN price <= 5 THEN "super low"
        WHEN price > 5 AND price <= 10 THEN "low"
        WHEN price > 10 AND price <= 15 THEN "medium"
        ELSE "high"
    END AS price_categories
FROM titles
WHERE type IN ("business", "trad_cook", "psychology")
GROUP BY price_categories, pub_id;