-- bar chart showing the number of recipients per month
SELECT 
date_trunc('month',block_time) AS month, 
COUNT(recipient) AS "recipients per month"

FROM uniswap_ethereum.airdrop_claims

GROUP BY 1
ORDER BY month DESC