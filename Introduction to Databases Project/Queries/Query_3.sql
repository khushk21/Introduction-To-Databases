SELECT	ProductName, AVG(DATEDIFF(day, O.Order_DateTime, P.DeliveredDate)) AS AVG_DAYS
FROM	[SS10_G1].[dbo].Orders AS O, [SS10_G1].[dbo].ProductsInOrder AS P
WHERE	P.OrderStatus = 'Delivered' AND O.Order_DateTime >= '2020-06-01 00:00:00' AND 
		O.Order_DateTime <= '2020-06-30 23:59:59' AND O.OrderId = P.OrderId
GROUP BY ProductName;