-- table listing all proposals in the Uniswap Snapshot space

SELECT
  ROW_NUMBER() OVER (ORDER BY start) AS proposal_nr,
  space,
  FROM_UNIXTIME(created) AS created,
  FROM_UNIXTIME(start) AS start,
  FROM_UNIXTIME("end") AS "end",
  title,
  votes,
  symbol,
  author,
  choices,
  "type",
  delegation,
  quorum,
  id
FROM dune.shot.dataset_proposals_view
WHERE
  space = 'uniswap'