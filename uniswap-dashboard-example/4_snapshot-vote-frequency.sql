-- table calculating the vote frequency and the share of voters in these frequencies in the Uniswap Snapshot space

SELECT
  vote_frequency,
  COUNT(*) AS voters_count,
  COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT voter) FROM dune.shot.dataset_votes_view WHERE space = 'uniswap') AS voters_percentage
FROM
  (
    SELECT
      voter,
      COUNT(*) AS vote_frequency
    FROM
      dune.shot.dataset_votes_view
    WHERE
      space = 'uniswap'
    GROUP BY
      voter
  ) subquery
GROUP BY
  vote_frequency
ORDER BY
  vote_frequency ASC;
