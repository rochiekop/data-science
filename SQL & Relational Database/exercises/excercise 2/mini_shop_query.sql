--Q1.Show the product IDs and product names that have been ordered more than once! Sorted by  product ID

SELECT
	o_item.product_id,
	p.product_name,
	o_item.total_order
FROM
	(
	SELECT
		count(sales_id) total_order,
		product_id
	FROM
		sales s
	GROUP BY
		product_id 
	HAVING count(sales_id) > 1
) o_item
LEFT JOIN products p 
ON
	p.product_id = o_item.product_id
ORDER BY p.product_id 


--Q2 From question number 1, How many products have been ordered more than once

WITH product_sold AS (
	SELECT
			o_item.product_id,
			p.product_name,
			o_item.total_order
	FROM
			(
		SELECT
				count(sales_id) total_order,
				product_id
		FROM
				sales s
		GROUP BY
				product_id
		HAVING
				count(sales_id) > 1
	) o_item
	LEFT JOIN products p 
	ON
		p.product_id = o_item.product_id
	ORDER BY
		p.product_id
)	
SELECT
	count(sc.product_id) p_sold_more_once,
	count(DISTINCT sc.product_name) p_name_sold
FROM
	product_sold sc

--Q3 From question number 2, How many products have only been ordered once
WITH product_sold AS (
	SELECT
			o_item.product_id,
			p.product_name,
			o_item.total_order
	FROM
			(
		SELECT
				count(sales_id) total_order,
				product_id
		FROM
				sales s
		GROUP BY
				product_id
		HAVING
				count(sales_id) = 1
	) o_item
	LEFT JOIN products p 
	ON
		p.product_id = o_item.product_id
	ORDER BY
		p.product_id
)	
SELECT
	count(1) p_sold_once,
	count(DISTINCT sc.product_name) p_name_sold
FROM
	product_sold	sc

--Q4 list of customers who have placed orders more than twice in a single month. 	
WITH c_order AS (
	SELECT
			o_order.customer_id,
			count(o_order.order_id) t_order,
			o_order.MONTH,
			o_order.year
	FROM
			(
		SELECT
				DISTINCT 
				c.customer_id,
				o.order_id,
				o.order_date,
				o.delivery_date,
				EXTRACT(MONTH
		FROM
				to_date(o.order_date , 'YYYY-MM-DD')) AS MONTH,
				EXTRACT(YEAR
		FROM
				to_date(o.order_date , 'YYYY-MM-DD')) AS YEAR
		FROM
				customers c
		JOIN orders o ON
				c.customer_id = o.customer_id
		JOIN sales s ON
				s.order_id = o.order_id
		) o_order
	GROUP BY
		o_order.YEAR,
			o_order.customer_id,
			o_order.MONTH
	HAVING
		count(o_order.order_id) > 2
) 
SELECT
	c.customer_id,
	co.t_order AS total_order,
	co.MONTH,
	co.YEAR,
	c.customer_name,
	c.home_address
FROM
	customers c
JOIN c_order co ON
	co.customer_id = c.customer_id 

--Q5 Find the first and last order date of each customer. Show the first 10 data, sorted by customer ID
		
SELECT
	o.customer_id,
	c.customer_name,
	min(o.order_date) f_date,
	max(o.order_date) l_date
FROM
	orders o
JOIN sales s ON
		s.order_id = o.order_id
JOIN customers c ON
	c.customer_id = o.customer_id
GROUP BY
	o.customer_id,
	c.customer_name
ORDER BY
	o.customer_id 
LIMIT 10

--Q6 

WITH s_customer AS (
SELECT
		o.customer_id,
		o.order_id,
		s.sales_id,
		s.product_id,
		s.price_per_unit,
		s.quantity,
		p.product_name,
		p.product_type,
		s.price_per_unit * s.quantity amount,
		s.total_price
FROM
		orders o
JOIN sales s ON
		o.order_id = s.order_id
JOIN products p ON
		p.product_id = s.product_id
WHERE
		lower(p.product_type) = 'trousers'
),
top_five_customer AS (
SELECT
		sc.customer_id,
		c.customer_name,
		sum(sc.amount) t_amount,
		avg(sc.total_price),
		sum(quantity) t_quantity
FROM
		s_customer sc
JOIN customers c ON
		c.customer_id = sc.customer_id
GROUP BY
		sc.customer_id,
		c.customer_name
ORDER BY
		sum(sc.amount) DESC
)
SELECT
	tfc.*
FROM
	top_five_customer tfc
LIMIT 5
;





--Q7
WITH q_order AS (
	SELECT
			s.product_id,
			p.product_name,
			sum(s.quantity) t_quantity,
			EXTRACT(MONTH FROM
						to_date(o.order_date , 'YYYY-MM-DD')) AS MONTH,
						EXTRACT(YEAR
						FROM
						to_date(o.order_date , 'YYYY-MM-DD')) AS YEAR,
			ROW_NUMBER() OVER(PARTITION BY EXTRACT(MONTH
	FROM
				to_date(o.order_date , 'YYYY-MM-DD'))
	ORDER BY
		sum(s.quantity) DESC) rn
	FROM
			orders o
	JOIN sales s ON
			o.order_id = s.order_id
	JOIN products p ON
			p.product_id = s.product_id
	GROUP BY
		s.product_id ,
					p.product_name,
		YEAR,
		MONTH
	ORDER BY
		MONTH,
		YEAR
)
SELECT
	qo.product_id,
	qo.product_name,
	qo.t_quantity,
	qo.MONTH,
	qo.YEAR
FROM
	q_order qo
WHERE rn = 1




--Q8.Create a view to store a query for calculating monthly total payment.
CREATE VIEW montly_total_payment 
AS 
SELECT
	to_char(o.order_date::date, 'YYYY-MM') AS MONTH,
	sum(o.payment) total_payment
FROM
	orders o
GROUP BY
	1
ORDER BY
	1

SELECT * FROM montly_total_payment

