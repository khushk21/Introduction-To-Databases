SELECT TOP 1	E.EmpName, AVG(DATEDIFF(day, C.Filed_DateTime, C.Handled_DateTime)) AS Latency
FROM	[SS10_G1].[dbo].Complaints AS C, [SS10_G1].[dbo].Employee AS E
WHERE 	C.EmpID = E.EmpID
GROUP BY E.EmpName, C.EmpID
HAVING 	AVG(DATEDIFF(day, C.Filed_DateTime, C.Handled_DateTime)) <= ALL 
									(SELECT AVG(DATEDIFF(day, C.Filed_DateTime, C.Handled_DateTime))
									 FROM 	[SS10_G1].[dbo].Complaints
									 GROUP BY Complaints.EmpID)
ORDER BY Latency;