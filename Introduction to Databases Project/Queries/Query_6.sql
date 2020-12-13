SELECT TOP 1 Revenue.ShopName, TotalRevenue
FROM (SELECT ShopName, SUM(Price * Quantity) AS TotalRevenue
	FROM [SS10_G1].[dbo].ProductsInOrder AS P
	WHERE P.DeliveredDate >= '2020-08-01' AND P.DeliveredDate <'2020-09-01'
	GROUP BY ShopName) AS Revenue
ORDER BY TotalRevenue DESC;
