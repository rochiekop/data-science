--Q9
WITH t_size AS (
	SELECT
			i.is_prime,
			sum(i.item_size_sqft) total_sqft,
			count(1) t_item_sqft
	FROM
			item i
	GROUP BY
			i.is_prime 
		),
	prime_area AS (
	SELECT
			ts.is_prime,
			ts.total_sqft,
			floor(600000 / ts.total_sqft) AS p_item_total, 
			(floor(60000 / ts.total_sqft)* t_item_sqft) p_item_count
	FROM 
			t_size ts
)SELECT
	CASE
		WHEN
is_prime = TRUE THEN 'prime items'
		ELSE 'non-prime items'
	END is_prime,
	CASE
		WHEN is_prime = TRUE 
	THEN (floor(600000 / total_sqft) * t_item_sqft )
		ELSE FLOOR(
            (600000 - (SELECT FLOOR(600000 / total_sqft) * total_sqft FROM prime_area WHERE is_prime = TRUE)) 
            / total_sqft) * t_item_sqft
	END item_count
FROM
		t_size
ORDER BY
	is_prime DESC
	
	
--Q10
	
WITH t_size AS (
	SELECT
			i.is_prime,
			sum(i.item_size_sqft) total_sqft,
			count(1) t_item_sqft
	FROM
			item i
	GROUP BY
			i.is_prime 
) SELECT sum(total_sqft  * 20) AS required_size FROM t_size
	