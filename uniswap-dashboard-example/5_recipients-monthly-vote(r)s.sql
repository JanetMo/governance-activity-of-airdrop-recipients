-- bar chart showing the unique airdrop voters and the total airdrop votes per month in the uniswap snapshot space

SELECT 
  DATE_TRUNC('month', FROM_UNIXTIME(created)) AS month,
  COUNT(*) AS vote_count,
  COUNT(DISTINCT recipient) AS unique_voters
FROM
  uniswap_ethereum.airdrop_claims c
  JOIN snapshot.votes s ON c.recipient = CAST(s.voter AS VARCHAR (255))
WHERE
  space = 'uniswap'
GROUP BY DATE_TRUNC('month', FROM_UNIXTIME(created))
ORDER BY DATE_TRUNC('month', FROM_UNIXTIME(created)) ASC;
