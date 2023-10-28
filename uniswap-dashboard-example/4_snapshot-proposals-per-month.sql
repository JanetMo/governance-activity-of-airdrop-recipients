-- bar chart showing the number proposals created per month

SELECT 
date_trunc('month',FROM_UNIXTIME(created)) AS month, 
COUNT(*) AS "proposals per month"

FROM dune.shot.dataset_proposals_view
WHERE space = 'uniswap'

GROUP BY 1
ORDER BY month ASC