-- some basic data about the uniswap on-chain governance

SELECT
  'uniswap v2 governance contract' AS description,
  MAX("number of proposals") AS "number of proposals",
  MAX("first proposal") AS "first proposal",
  MAX("most recent proposal") AS "most recent proposal",
  MAX("total votes") AS "total votes",
  MAX("average votes per proposal") AS "average votes per proposal"
FROM (
  SELECT
    COUNT(*) AS "number of proposals",
    MIN(evt_block_time) AS "first proposal",
    MAX(evt_block_time) AS "most recent proposal",
    NULL AS "total votes",
    NULL AS "average votes per proposal"
  FROM uniswap_v2_ethereum.GovernorAlpha_evt_ProposalCreated
  UNION
  SELECT
    NULL AS "number of proposals",
    NULL AS "first proposal",
    NULL AS "most recent proposal",
    COUNT(voter) AS "total votes",
    COUNT(voter) / COUNT(DISTINCT proposalId) AS "average votes per proposal"
  FROM uniswap_v2_ethereum.GovernorAlpha_evt_VoteCast
) AS subquery

UNION

SELECT
  'uniswap v3 governance contract' AS description,
  MAX("number of proposals") AS "number of proposals",
  MAX("first proposal") AS "first proposal",
  MAX("most recent proposal") AS "most recent proposal",
  MAX("total votes") AS "total votes",
  MAX("average votes per proposal") AS "average votes per proposal"
FROM (
  SELECT
    COUNT(*) AS "number of proposals",
    MIN(evt_block_time) AS "first proposal",
    MAX(evt_block_time) AS "most recent proposal",
    NULL AS "total votes",
    NULL AS "average votes per proposal"
  FROM uniswap_v3_ethereum.GovernorBravoDelegate_evt_ProposalCreated
  UNION
  SELECT
    NULL AS "number of proposals",
    NULL AS "first proposal",
    NULL AS "most recent proposal",
    COUNT(voter) AS "total votes",
    COUNT(voter) / COUNT(DISTINCT proposalId) AS "average votes per proposal"
  FROM uniswap_v3_ethereum.GovernorBravoDelegate_evt_VoteCast
) AS subquery;
