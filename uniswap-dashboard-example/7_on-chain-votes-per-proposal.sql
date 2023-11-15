-- bar chart showing the total votes per proposal in the uniswap Governance portal

SELECT 
DISTINCT v.proposalId AS proposal_id,
  c.evt_block_time AS block_time,
  COUNT(v.voter) AS "votes per proposal"
FROM query_3196977 AS v
JOIN uniswap_v2_ethereum.GovernorAlpha_evt_ProposalCreated AS c
  ON v.proposalId = c.id
GROUP BY
  v.proposalId,
  c.evt_block_time
UNION
SELECT DISTINCT
  v.proposalId AS proposal_id,
  c.evt_block_time AS block_time,
  COUNT(v.voter) AS "votes per proposal"
FROM query_3196977 AS v
JOIN uniswap_v3_ethereum.GovernorBravoDelegate_evt_ProposalCreated AS c
  ON v.proposalId = c.id
GROUP BY
  v.proposalId,
  c.evt_block_time
ORDER BY
  block_time