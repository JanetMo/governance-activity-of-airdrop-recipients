-- table calculating the share of on-chain voters among all token holders
-- for three different points in time: 6 months after the airdrop, 12 months after the airdrop and currently

SELECT
  'current' AS description,
  token_holders.total_token_holders,
  voters.unique_voters,
  voters.total_votes,
  (voters.unique_voters * 100.00000) / token_holders.total_token_holders AS share_of_voters
FROM (
  SELECT
    COUNT(DISTINCT "to") AS total_token_holders
  FROM erc20_ethereum.evt_Transfer
  WHERE
    contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
) AS token_holders
CROSS JOIN (
  SELECT
    COUNT(DISTINCT voter) AS unique_voters,
    COUNT(voter) AS total_votes
  FROM query_3196977
) AS voters

UNION

SELECT
  'six months after the airdrop' AS description,
  token_holders.total_token_holders,
  voters.unique_voters,
  voters.total_votes,
  (voters.unique_voters * 100.00000) / token_holders.total_token_holders AS share_of_voters
FROM (
  SELECT
    COUNT(DISTINCT "to") AS total_token_holders
  FROM erc20_ethereum.evt_Transfer
  WHERE
    contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
    AND evt_block_time BETWEEN TRY_CAST('2020-09-16' AS TIMESTAMP) AND TRY_CAST('2020-09-16' AS TIMESTAMP) + INTERVAL '6' MONTH
) AS token_holders
CROSS JOIN (
  SELECT
    COUNT(DISTINCT voter) AS unique_voters,
    COUNT(voter) AS total_votes
  FROM query_3196977
   WHERE TO_UNIXTIME(evt_block_time) BETWEEN 1600291972 AND 1600291972 + 15778458
) AS voters

UNION

SELECT
  '12 months after the airdrop' AS description,
  token_holders.total_token_holders,
  voters.unique_voters,
  voters.total_votes,
  (voters.unique_voters * 100.00000) / token_holders.total_token_holders AS share_of_voters
FROM (
  SELECT
    COUNT(DISTINCT "to") AS total_token_holders
  FROM erc20_ethereum.evt_Transfer
  WHERE
    contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
    AND evt_block_time BETWEEN TRY_CAST('2020-09-16' AS TIMESTAMP) AND TRY_CAST('2020-09-16' AS TIMESTAMP) + INTERVAL '12' MONTH
) AS token_holders
CROSS JOIN (
  SELECT
    COUNT(DISTINCT voter) AS unique_voters,
    COUNT(voter) AS total_votes
  FROM query_3196977
   WHERE TO_UNIXTIME(evt_block_time) BETWEEN 1600291972 AND 1600291972 + 31556916
) AS voters