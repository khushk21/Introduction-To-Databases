SELECT UID, PName, PPrice
FROM [SS10_G1].[dbo].UserWithMostComplaints
WHERE PPrice >= ALL(SELECT PPrice
					FROM [SS10_G1].[dbo].UserWithMostComplaints);
SELECT TP.ProductName
FROM [SS10_G1].[dbo].TopProducts TP, [SS10_G1].[dbo].UserCount UC,[SS10_G1].[dbo].UniquePurchases UP
WHERE TP.ProductName=UP.ProductName AND NumUniquePurchases<NumUniqueUsers;
GO
SELECT DISTINCT s1.ProductName
FROM [SS10_G1].[dbo].Sales1 s1, [SS10_G1].[dbo].Sales1 s2, [SS10_G1].[dbo].Sales1 s3
WHERE s3.SaleMonth - s2.SaleMonth = 1
AND s2.SaleMonth - s1.SaleMonth = 1
AND s3.SaleQuantity > s2.SaleQuantity
AND s2.SaleMonth > s1.SaleQuantity