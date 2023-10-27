-- table calculating the share of airdrop recipients among all snapshot voters
-- for three different points in time: 6 months after the airdrop, 12 months after the airdrop and currently

  SELECT
  'current' AS description,
  COUNT(*) AS total_votes,
  COUNT(DISTINCT s.voter) AS total_voters,
  (
    SELECT
      COUNT(DISTINCT recipient)
    FROM
      uniswap_ethereum.airdrop_claims -- get all airdrop recipients
  ) AS airdrop_recipient_count,
  TRY_CAST(COUNT(DISTINCT s.voter) AS REAL) / TRY_CAST(
    (
      SELECT
        COUNT(DISTINCT recipient)
      FROM
        uniswap_ethereum.airdrop_claims
    ) AS REAL
  ) * 100 AS percentage_of_voters,
  COUNT(*) / COUNT(DISTINCT proposal) AS average_votes_per_proposal,
  COUNT(*) / COUNT(DISTINCT s.voter) AS average_votes_per_voter
FROM
  uniswap_ethereum.airdrop_claims AS c
  LEFT JOIN snapshot.votes AS s ON CAST(c.recipient AS varbinary) = s.voter -- join with the snapshot voters
WHERE
  space = 'uniswap'

UNION ALL

SELECT
  'six months after the airdrop' AS description,
  COUNT(*) AS total_votes,
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
  ) * 100 AS percentage_of_voters,
  COUNT(*) / COUNT(DISTINCT proposal) AS average_votes_per_proposal,
  COUNT(*) / COUNT(DISTINCT s.voter) AS average_votes_per_voter
FROM
  uniswap_ethereum.airdrop_claims AS c
  LEFT JOIN snapshot.votes AS s ON CAST(c.recipient AS varbinary) = s.voter
WHERE
  space = 'uniswap'
  AND created BETWEEN 1600291972 AND 1600291972 + 15778458 -- get the votes of airdrop recipients within six months of the airdrop (unix time)

UNION ALL

SELECT
  'twelve months after the airdrop' AS description,
  COUNT(*) AS total_votes,
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
  ) * 100 AS percentage_of_voters,
  COUNT(*) / COUNT(DISTINCT proposal) AS average_votes_per_proposal,
  COUNT(*) / COUNT(DISTINCT s.voter) AS average_votes_per_voter
FROM
  uniswap_ethereum.airdrop_claims AS c
  LEFT JOIN snapshot.votes AS s ON CAST(c.recipient AS varbinary) = s.voter
WHERE
  space = 'uniswap'
  AND created BETWEEN 1600291972 AND 1600291972 + 31556916 -- get the votes of airdrop recipients within twelve months of the airdrop (unix time)