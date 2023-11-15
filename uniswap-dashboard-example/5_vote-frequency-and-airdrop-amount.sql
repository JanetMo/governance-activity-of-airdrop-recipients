-- table and scatter chart displaying the airdrop amount and the Snapshot vote frequency per recipient
SELECT
  a.recipient,
  COUNT(*) AS vote_frequency,
  a.amount_original
FROM dune.shot.dataset_votes_view AS v
INNER JOIN uniswap_ethereum.airdrop_claims AS a
ON CAST(v.voter AS VARCHAR) = a.recipient
WHERE
  v.space = 'uniswap'
GROUP BY
  v.voter,
  a.recipient,
  a.amount_original
ORDER BY
  vote_frequency, amount_original DESC