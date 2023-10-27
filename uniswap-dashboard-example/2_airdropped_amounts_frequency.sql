-- bar chart showing the frequency of the airdropped amounts
SELECT
  "amounts airdropped",
  frequency,
  frequency * 100.0 / SUM(frequency) OVER () AS frequency_percent
FROM (
  SELECT 
    FLOOR(amount_original / 100) * 100 AS "amounts airdropped", -- adding up every 100 tokens
    COUNT(amount_original) AS frequency
  FROM uniswap_ethereum.airdrop_claims
  GROUP BY 1
) subquery
ORDER BY "amounts airdropped" ASC;






