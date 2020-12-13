CREATE VIEW AllProducts AS 
(SELECT ProductName, SUM(Quantity) AS TotalQuantity
FROM [SS10_G1].[dbo].ProductsInOrder
GROUP BY ProductName);
GO

CREATE VIEW NonTop1Products AS
(SELECT * 
FROM AllProducts AP1
WHERE AP1.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM Allproducts AP2));
GO

CREATE VIEW NonTop2Products AS
(SELECT * 
FROM NonTop1Products NT1
WHERE NT1.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop1Products NT2));
GO

CREATE VIEW NonTop3Products AS
(SELECT * 
FROM NonTop2Products NT1
WHERE NT1.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop2Products NT2));
GO

CREATE VIEW NonTop4Products AS
(SELECT * 
FROM NonTop3Products NT1
WHERE NT1.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop3Products NT2));
GO

CREATE VIEW NonTop5Products AS
(SELECT * 
FROM NonTop4Products NT1
WHERE NT1.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop4Products NT2));
GO

--Assume that there can be more than 5 products if products have the same order quantity.
CREATE VIEW TopProducts AS
(SELECT *
FROM AllProducts 
EXCEPT
SELECT *
FROM NonTop5Products);
GO

CREATE VIEW UserCount AS
SELECT COUNT(*) AS NumUniqueUsers
FROM [SS10_G1].[dbo].Users;
GO

CREATE VIEW UniquePurchases AS
SELECT ProductName, Count(UserID) AS NumUniquePurchases
FROM (SELECT DISTINCT U.UserId, PIO.ProductName
	  FROM [SS10_G1].[dbo].Users U,[SS10_G1].[dbo].Orders O,[SS10_G1].[dbo].ProductsInOrder PIO
	  WHERE U.UserId=O.UserId AND O.OrderId=PIO.OrderId) AS UniquePurchase
GROUP BY ProductName;
GO

SELECT TP.ProductName
FROM [SS10_G1].[dbo].TopProducts TP, [SS10_G1].[dbo].UserCount UC,[SS10_G1].[dbo].UniquePurchases UP
WHERE TP.ProductName=UP.ProductName AND NumUniquePurchases<NumUniqueUsers;
GO