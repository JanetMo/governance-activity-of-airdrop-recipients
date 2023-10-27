-- bar chart showing the unique airdrop voters among the total voters per month in the uniswap snapshot space

SELECT
  t1.month,
  t1."voters per month" AS total_voters,
  COALESCE(t2.unique_voters, 0) AS airdrop_recipient_votes
FROM (
  SELECT
    DATE_TRUNC('month', FROM_UNIXTIME(created)) AS month,
    COUNT(DISTINCT voter) AS "voters per month"
  FROM snapshot.votes
  WHERE
    space = 'uniswap'
  GROUP BY
    DATE_TRUNC('month', FROM_UNIXTIME(created))
) AS t1
LEFT JOIN (
  SELECT
    DATE_TRUNC('month', FROM_UNIXTIME(created)) AS month,
    COUNT(DISTINCT recipient) AS unique_voters
  FROM ens_ethereum.airdrop_claims AS c
  JOIN snapshot.votes AS s
    ON c.recipient = s.voter
  WHERE
    space = 'uniswap'
  GROUP BY
    DATE_TRUNC('month', FROM_UNIXTIME(created))
) AS t2
  ON t1.month = t2.month
ORDER BY
  t1.month