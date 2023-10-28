-- bar chart showing the unique voters and the total votes per month in the uniswap snapshot space

SELECT 
date_trunc('month',FROM_UNIXTIME(created)) AS month, 
COUNT(voter) AS "votes per month",
COUNT(DISTINCT voter) AS "voters per month"

FROM dune.shot.dataset_votes_view
WHERE space = 'uniswap'

GROUP BY 1
ORDER BY month ASC