-- some basic data about the uniswap snapshot space

SELECT
 COUNT (*) AS "number of proposals",
 MIN(FROM_UNIXTIME(created)) AS "first proposal",
 MAX(FROM_UNIXTIME(created)) AS "most recent proposal",
 SUM(votes) AS "total votes",
 SUM(votes) / COUNT (*) AS "average votes per proposal",
 MIN(votes) AS "minimum of votes",
 MAX(votes) AS "maximum of votes"

FROM dune.shot.dataset_proposals_view
WHERE space = 'uniswap'