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


SELECT * FROM "Track" t  


SELECT * FROM "Invoice" i WHERE i."InvoiceId" = 2;

SELECT * FROM "Genre" g 

SELECT * FROM "Invoice" i 

