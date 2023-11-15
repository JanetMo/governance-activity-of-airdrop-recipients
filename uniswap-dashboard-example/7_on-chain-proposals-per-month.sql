-- bar chart showing the number of proposals per month in the Uniswap governance portal

SELECT
  DATE_TRUNC('month', block_date) AS month,
  COUNT(*) AS num_proposals
FROM uniswap_v3_ethereum.proposals
GROUP BY
  DATE_TRUNC('month', block_date)
UNION ALL
SELECT
  DATE_TRUNC('month', evt_block_time) AS month,
  COUNT(*) AS num_proposals
FROM uniswap_v2_ethereum.GovernorAlpha_evt_ProposalCreated AS pc
GROUP BY
  DATE_TRUNC('month', evt_block_time)
ORDER BY
  month