-- bar chart showing the total votes per proposal in the Uniswap Snapshot space 

SELECT 
FROM_UNIXTIME(created) AS created,
SUM(votes) AS "votes per proposal"

FROM dune.shot.dataset_proposals_view
WHERE space = 'uniswap'

GROUP BY 1
ORDER BY created ASC