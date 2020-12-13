SELECT	ProductName, AVG(Price) AS AveragePrice
FROM	[SS10_G1].[dbo].PriceHistory
WHERE	ProductName = 'Iphone X' AND
StartDate >= '2020-08-01' AND EndDate <= '2020-08-31' 
GROUP BY ProductName;