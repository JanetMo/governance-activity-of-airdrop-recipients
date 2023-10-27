-- table calculating the share of snapshot voters among all token holders
-- for three different points in time: 6 months after the airdrop, 12 months after the airdrop and currently

SELECT
  'current' AS description,
  token_holders.total_token_holders,
  voters.unique_voters,
  voters.total_votes,
  voters.average_votes_per_voter,
  (voters.unique_voters * 100.00000) / token_holders.total_token_holders AS share_of_voters -- unique voters / all token holders = share of voters
FROM (
  SELECT
    COUNT(DISTINCT "to") AS total_token_holders
  FROM erc20_ethereum.evt_Transfer
  WHERE
    contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984 -- get all UNI token holders
) AS token_holders
CROSS JOIN (
  SELECT
    COUNT(DISTINCT voter) AS unique_voters,
    COUNT(voter) AS total_votes,
    COUNT(voter) / COUNT(DISTINCT voter) AS average_votes_per_voter
  FROM snapshot.votes -- join with the snapshot voters
  WHERE
    space = 'uniswap'
) AS voters

UNION ALL 

SELECT
  'six months after the airdrop' AS description,
  token_holders.total_token_holders,
  voters.unique_voters,
  voters.total_votes,
  voters.average_votes_per_voter,
  (voters.unique_voters * 100.00000) / token_holders.total_token_holders AS share_of_voters
FROM (
  SELECT
    COUNT(DISTINCT "to") AS total_token_holders
  FROM erc20_ethereum.evt_Transfer
  WHERE
    contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
    AND evt_block_time BETWEEN TRY_CAST('2020-09-16' AS TIMESTAMP) AND TRY_CAST('2020-09-16' AS TIMESTAMP) + INTERVAL '6' MONTH -- get all token holders within 6 months of the airdrop
) AS token_holders
CROSS JOIN (
  SELECT
    COUNT(DISTINCT voter) AS unique_voters,
    COUNT(voter) AS total_votes,
    COUNT(voter) / COUNT(DISTINCT voter) AS average_votes_per_voter
  FROM snapshot.votes
  WHERE
    space = 'uniswap'
    AND created BETWEEN 1600291972 AND 1600291972 + 15778458 -- get all votes within six months of the airdrop (unix time)
) AS voters

UNION ALL 

SELECT
  'twelve months after the airdrop' AS description,
  token_holders.total_token_holders,
  voters.unique_voters,
  voters.total_votes,
  voters.average_votes_per_voter,
  (voters.unique_voters * 100.00000) / token_holders.total_token_holders AS share_of_voters
FROM (
  SELECT
    COUNT(DISTINCT "to") AS total_token_holders
  FROM erc20_ethereum.evt_Transfer
  WHERE
    contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
    AND evt_block_time BETWEEN TRY_CAST('2020-09-16' AS TIMESTAMP) AND TRY_CAST('2020-09-16' AS TIMESTAMP) + INTERVAL '12' MONTH -- all token holders within 12 months of the airdrop
) AS token_holders
CROSS JOIN (
  SELECT
    COUNT(DISTINCT voter) AS unique_voters,
    COUNT(voter) AS total_votes,
    COUNT(voter) / COUNT(DISTINCT voter) AS average_votes_per_voter
  FROM snapshot.votes
  WHERE
    space = 'uniswap'
    AND created BETWEEN 1600291972 AND 1600291972 + 31556916 -- get all votes within twelve months of the airdrop (unix time)
) AS voters
