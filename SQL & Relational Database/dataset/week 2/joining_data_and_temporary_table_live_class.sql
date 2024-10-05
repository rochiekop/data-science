
--Case 1.1 Product That Never Bought by Customers
SELECT
	p.*
FROM
	products p
LEFT JOIN orderdetails o ON
	o.productcode = p.productcode
WHERE
	o.productcode IS NULL ;
	


-- Case 1.2
WITH product_item AS (
	SELECT
		p.*,
		CASE
			WHEN i_sold.n_of_items_sold IS NULL THEN 0
		ELSE i_sold.n_of_items_sold
	END
FROM
		products p
LEFT JOIN (
	SELECT
			productcode ,
			sum(quantityordered) n_of_items_sold
	FROM
			orderdetails o
	GROUP BY
			productcode 
	) i_sold ON
		i_sold.productcode = p.productcode 
)
SELECT
	productname ,
	quantityinstock ,
	n_of_items_sold,
	quantityinstock + n_of_items_sold AS total_stock,
	((n_of_items_sold::decimal) / (quantityinstock + n_of_items_sold)) * 100 percent_items_sold
FROM
	product_item
WHERE
	((n_of_items_sold::decimal) / (quantityinstock + n_of_items_sold)) * 100 < 20
ORDER BY
	((n_of_items_sold::decimal) / (quantityinstock + n_of_items_sold)) * 100 



--Case 1.3
	
SELECT
	p.productname,
	p.msrp,
	min_price.m_priceeach,
	 min_price.m_priceeach/p.msrp::decimal * 100 percent_msrp 
FROM
	products p
JOIN (
	SELECT
		productcode,
		min(priceeach) m_priceeach
	FROM
		orderdetails o
	GROUP BY
		productcode 
) min_price ON
	min_price.productcode = p.productcode 
	WHERE 	 min_price.m_priceeach/p.msrp::decimal * 100  < 80
	
	
	
--Case 1.4

WITH t_sales_cat AS (
SELECT
	p.productline ,
	sum(d.total_sales) sum_every_category
FROM
	products p
JOIN (
	SELECT
		o.productcode ,
		sum(o.quantityordered * o.priceeach) total_sales
	FROM
		orderdetails o
	GROUP BY
		o.productcode 
) d ON
	d.productcode = p.productcode
GROUP BY
	p.productline 
)
SELECT
	*
FROM
	t_sales_cat
WHERE
	sum_every_category > 
	(
	SELECT
		avg(sum_every_category)
	FROM
		t_sales_cat)
	
		
		
		
SELECT * FROM products p 

SELECT * FROM orderdetails o 

SELECT * FROM orders o 

SELECT * FROM payments p 