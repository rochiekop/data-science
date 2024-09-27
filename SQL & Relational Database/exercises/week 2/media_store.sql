SELECT * FROM "Album" a ;


--Q1
SELECT
	"BillingCountry",
	count("InvoiceId") totalInvoice
FROM
	"Invoice" i
GROUP BY
	"BillingCountry"
ORDER BY
	count("InvoiceId") DESC,
	"BillingCountry"
LIMIT 10;



--Q2
SELECT
	g."Name" "GenreName",
	sum(il."UnitPrice" * il."Quantity") "TotalSales"
FROM
	"InvoiceLine" il
JOIN "Track" t ON
	t."TrackId" = il."TrackId"
JOIN "Genre" g ON
	g."GenreId" = t."GenreId"
GROUP BY
	g."Name"
ORDER BY
	sum(il."UnitPrice" * il."Quantity") DESC
LIMIT 10;

--Q3 

SELECT
	c."FirstName" ||' '|| c."LastName" "FullName",
	c."Email" ,
	sum(i."Total") "TotalSpending"
FROM
	"Invoice" i
JOIN "Customer" c ON
	i."CustomerId" = c."CustomerId"
GROUP BY
	i."CustomerId",
	c."FirstName",
	c."LastName",
	c."Email"
ORDER BY
	sum(i."Total") DESC,
	c."FirstName"
LIMIT 10;


--Q4

SELECT
	city_rank."BillingCountry" "Country Name",
	city_rank."BillingCity" "City Name",
	city_rank.totalinvoice "Total Invoice"
FROM
	(
	SELECT
		"BillingCountry",
		"BillingCity", 
		count("InvoiceId") totalinvoice ,
		 ROW_NUMBER() OVER (PARTITION BY "BillingCountry"
	ORDER BY
		count("InvoiceId") DESC,
		"BillingCity") "Rank"
	FROM
		"Invoice" i
	GROUP BY
		"BillingCountry" ,
		"BillingCity"
	ORDER BY
		"BillingCountry",
		count("InvoiceId") DESC
) city_rank
JOIN (
	SELECT
		"BillingCountry",
		count("InvoiceId") totalInvoice
	FROM
		"Invoice" i
	GROUP BY
		"BillingCountry"
	ORDER BY
		count("InvoiceId") DESC,
		"BillingCountry"
	LIMIT 10
) top_country ON
	city_rank."BillingCountry" = top_country."BillingCountry"
WHERE
	city_rank."Rank" = 1
ORDER BY
	top_country.totalInvoice DESC 



--Q5
SELECT
	i."BillingCountry" "Country",
	count(il."Quantity") "Purchased"
,
	g."Name" g_name
FROM
	"InvoiceLine" il
JOIN "Track" t ON
	il."TrackId" = t."TrackId"
JOIN "Genre" g ON
	g."GenreId" = t."GenreId"
JOIN "Invoice" i ON
	i."InvoiceId" = il."InvoiceId"
WHERE
	i."BillingCountry" = 'United Kingdom'
GROUP BY
	i."BillingCountry",
	g."Name"
ORDER BY count(il."Quantity")
DESC 	
	
	
--Q6
SELECT
	i."BillingCountry" "Country",
	count(il."Quantity") "Purchased"
,
	a."Title" "Album Title"
FROM
	"InvoiceLine" il
JOIN "Track" t ON
	il."TrackId" = t."TrackId"
JOIN "Album" a ON a."AlbumId" = t."AlbumId" 	
JOIN "Invoice" i ON
	i."InvoiceId" = il."InvoiceId"
WHERE
	i."BillingCountry" = 'USA'
GROUP BY
	i."BillingCountry",
	a."AlbumId" 
ORDER BY count(il."Quantity")
DESC 	
LIMIT 10;

--Q7

SELECT
	data."Country",
	sum(data."T_Customer") "NumberCustomer",
	sum(DATA.total) "ValueOfSales",
	round(sum(DATA.total) / sum(data."T_Customer"), 2) "AvgValueOfSales",
	round(sum(DATA.total)/ sum(DATA.totalinvoice), 2) "AvgOrderValue"
FROM
	(
	SELECT
		CASE 
			WHEN count(DISTINCT("CustomerId")) = 1 THEN 'Others'
			ELSE 
				"BillingCountry"
		END "Country",
			count(DISTINCT("CustomerId")) "T_Customer",
			sum(i."Total") total,
			count(i."InvoiceId") totalinvoice
	FROM
		"Invoice" i
	GROUP BY
		"BillingCountry" 
	ORDER BY total desc
) DATA
GROUP BY
	data."Country"
ORDER BY sum(DATA.total) DESC ;
SELECT bFROM "Invoice" i 


--Q8

SELECT
	i."BillingCountry" "Country",
	sum(il."Quantity" * il."UnitPrice") "TotalSales",
	g."Name" "Genre"
FROM
	"Invoice" i
JOIN "InvoiceLine" il ON
	il."InvoiceId" = i."InvoiceId"
JOIN "Track" t ON
	t."TrackId" = il."TrackId"
JOIN "Genre" g ON
	g."GenreId" = t."GenreId"
WHERE
	i."BillingCountry" = 'USA'
GROUP BY
	i."BillingCountry",
	g."Name"
ORDER BY
	sum(il."Quantity" * il."UnitPrice")
LIMIT 10


-- Q9

SELECT
	customer.full_name "FullName",
	customer.total_price "TotalSpent",
	customer."Name" "Genre"
FROM
	(
	SELECT
		i."CustomerId",
		c."FirstName" || ' ' || c."LastName" full_name,
		sum(il."Quantity" * il."UnitPrice") total_price,
		g."Name",
		DENSE_RANK() OVER(PARTITION BY i."CustomerId"
	ORDER BY
		sum(il."Quantity" * il."UnitPrice") DESC) RANK
	FROM
		"Invoice" i
	JOIN "Customer" c ON
		i."CustomerId" = c."CustomerId"
	JOIN "InvoiceLine" il 
	ON
		i."InvoiceId" = il."InvoiceLineId"
	JOIN "Track" t ON
		t."TrackId" = il."TrackId"
	JOIN "Genre" g ON
		t."GenreId" = g."GenreId"
	GROUP BY
		i."CustomerId" ,
		g."Name" ,
		c."FirstName",
		c."LastName"
	ORDER BY
		i."CustomerId" ,
		sum(il."Quantity" * il."UnitPrice") DESC
	) customer
WHERE
	RANK = 1 

	
--	Q10
SELECT
	i."BillingCountry", 		
	sum(il."Quantity" * il."UnitPrice") "TotalSpent"
FROM
	"Invoice" i
JOIN "InvoiceLine" il 
	ON i."InvoiceId" = il."InvoiceId"
JOIN "Track" t ON
	t."TrackId" = il."TrackId"
GROUP BY
	i."BillingCountry"
ORDER BY
	sum(il."Quantity" * il."UnitPrice") DESC
LIMIT 10

	
	
SELECT i."BillingCountry" , sum(i."Total") FROM "Invoice" i 	
GROUP BY "BillingCountry" ORDER BY sum(i."Total") desc
	
SELECT * FROM "Track" t  

SELECT i."Total" FROM "Invoice" i WHERE "BillingCountry" = 'USA'


SELECT sum("Total") FROM "Invoice" i WHERE "BillingCountry" = 'USA';

SELECT * FROM "Genre" g 

SELECT * FROM "Invoice" i


SELECT * FROM "InvoiceLine" il 




