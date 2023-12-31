-- table calculating the vote frequency of airdrop recipients in the Uniswap Snapshot space

SELECT
  vote_frequency,
  COUNT(*) AS voters_count,
  COUNT(*) * 100.0 / (
    SELECT
      COUNT(DISTINCT avc.recipient)
    FROM dune.shot.dataset_votes_view AS sv
    JOIN uniswap_ethereum.airdrop_claims AS avc
      ON TRY_CAST(sv.voter AS VARCHAR) = avc.recipient
    WHERE
      sv.space = 'uniswap'
  ) AS voters_percentage
FROM (
  SELECT
    avc.recipient AS voter,
    COUNT(*) AS vote_frequency
  FROM dune.shot.dataset_votes_view AS sv
  JOIN uniswap_ethereum.airdrop_claims AS avc
    ON TRY_CAST(sv.voter AS VARCHAR) = avc.recipient
  WHERE
    sv.space = 'uniswap'
  GROUP BY
    avc.recipient
) AS subquery
GROUP BY
  vote_frequency
ORDER BY
  vote_frequency