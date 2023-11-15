-- table calculating the share of airdrop recipients among all on-chain voters
-- for three different points in time: 6 months after the airdrop, 12 months after the airdrop and currently

SELECT
  'current' AS description, 
  COUNT(s.voter) AS total_votes,
  COUNT(DISTINCT s.voter) AS total_voters,
  (
    SELECT
      COUNT(DISTINCT recipient)
    FROM
      uniswap_ethereum.airdrop_claims
  ) AS airdrop_recipient_count,
  TRY_CAST(COUNT(DISTINCT s.voter) AS REAL) / TRY_CAST(
    (
      SELECT
        COUNT(DISTINCT recipient)
      FROM
        uniswap_ethereum.airdrop_claims
    ) AS REAL
  ) * 100 AS percentage_of_voters
FROM
  uniswap_ethereum.airdrop_claims AS c
  LEFT JOIN query_3196977 AS s ON c.recipient = s.voter

UNION ALL

SELECT
  'six months after the airdrop' AS description,
  COUNT(s.voter) AS total_votes,
  COUNT(DISTINCT s.voter) AS total_voters,
  (
    SELECT
      COUNT(DISTINCT recipient)
    FROM
      uniswap_ethereum.airdrop_claims
  ) AS airdrop_recipient_count,
  TRY_CAST(COUNT(DISTINCT s.voter) AS REAL) / TRY_CAST(
    (
      SELECT
        COUNT(DISTINCT recipient)
      FROM
        uniswap_ethereum.airdrop_claims
    ) AS REAL
  ) * 100 AS percentage_of_voters
FROM
  uniswap_ethereum.airdrop_claims AS c
  LEFT JOIN query_3196977 AS s ON c.recipient = s.voter
WHERE
TO_UNIXTIME(s.evt_block_time) BETWEEN 1600291972 AND 1600291972 + 15778458


UNION ALL

SELECT
  'twelve months after the airdrop' AS description,
  COUNT(s.voter) AS total_votes,
  COUNT(DISTINCT s.voter) AS total_voters,
  (
    SELECT
      COUNT(DISTINCT recipient)
    FROM
      uniswap_ethereum.airdrop_claims
  ) AS airdrop_recipient_count,
  TRY_CAST(COUNT(DISTINCT s.voter) AS REAL) / TRY_CAST(
    (
      SELECT
        COUNT(DISTINCT recipient)
      FROM
        uniswap_ethereum.airdrop_claims
    ) AS REAL
  ) * 100 AS percentage_of_voters
FROM
  uniswap_ethereum.airdrop_claims AS c
  LEFT JOIN query_3196977 AS s ON c.recipient = s.voter
WHERE
TO_UNIXTIME(s.evt_block_time) BETWEEN 1600291972 AND 1600291972 + 31556916