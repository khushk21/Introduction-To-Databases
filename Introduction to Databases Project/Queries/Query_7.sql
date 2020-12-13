CREATE VIEW UserWithMostComplaints AS
SELECT O.UserId AS UID, P.ProductName AS PName, P.Price AS PPrice
FROM [SS10_G1].[dbo].Orders AS O
INNER JOIN [SS10_G1].[dbo].ProductsInOrder AS P ON O.OrderId = P.OrderId
WHERE O.UserId = ANY(SELECT TOP 1 Total.UserId
					 FROM (SELECT UserId, MAX(TotalComplaints.TotalComplaints) AS TotalNum
					 	   FROM (SELECT UserId, COUNT(ComplaintId) AS TotalComplaints
					 	   		 FROM [SS10_G1].[dbo].Complaints
					 	   		 GROUP BY UserId) AS TotalComplaints
					 	   GROUP BY UserId) AS Total
					 ORDER BY Total.TotalNum DESC);
                     
SELECT UID, PName, PPrice
FROM [SS10_G1].[dbo].UserWithMostComplaints
WHERE PPrice >= ALL(SELECT PPrice
					FROM [SS10_G1].[dbo].UserWithMostComplaints);