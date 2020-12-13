SELECT	S.ProductName, COUNT(ShopName) AS NumShops
FROM	[SS10_G1].[dbo].ProductInShops AS S, [SS10_G1].[dbo].Products AS P
WHERE	S.ProductName = P.ProductName AND P.Maker = 'Samsung'
GROUP BY S.ProductName;