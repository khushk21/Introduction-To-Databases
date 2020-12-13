CREATE VIEW Sales1 AS
SELECT ProductsInOrder.ProductName, SUM(ProductsInOrder.Quantity) AS SaleQuantity, DATEPART(month, Orders.Order_DateTime) AS SaleMonth
FROM [SS10_G1].[dbo].Orders, [SS10_G1].[dbo].ProductsInOrder
WHERE Orders.OrderId = ProductsInOrder.OrderId
GROUP BY ProductsInOrder.ProductName,DATEPART(month, Orders.Order_DateTime)
GO
SELECT DISTINCT s1.ProductName
FROM [SS10_G1].[dbo].Sales1 s1, [SS10_G1].[dbo].Sales1 s2, [SS10_G1].[dbo].Sales1 s3
WHERE s3.SaleMonth - s2.SaleMonth = 1
AND s2.SaleMonth - s1.SaleMonth = 1
AND s3.SaleQuantity > s2.SaleQuantity
AND s2.SaleMonth > s1.SaleQuantity