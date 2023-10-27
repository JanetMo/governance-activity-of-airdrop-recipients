-- bar chart showing the total votes per proposal in the uniswap snapshot space 

SELECT 
FROM_UNIXTIME(created) AS created,
SUM(votes) AS "votes per proposal"

FROM snapshot.proposals
WHERE space = 'uniswap'

GROUP BY 1
ORDER BY created ASC