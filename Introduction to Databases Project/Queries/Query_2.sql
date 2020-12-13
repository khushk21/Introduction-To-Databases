SELECT	ProductName
FROM	[SS10_G1].[dbo].Feedback
WHERE	Rating = '5' AND FeedbackDate >= '2020-08-01 00:00:00' AND FeedbackDate <= '2020-08-31 23:59:59'
GROUP BY ProductName
HAVING COUNT(*) >= 100;