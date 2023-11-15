-- table calculating the share of delegators among all airdrop recipients
-- for three different points in time: 6 months after the airdrop, 12 months after the airdrop and currently

SELECT
  'airdrop recipients current' AS description,
  COUNT(*) AS "total delegation events",
  COUNT(DISTINCT delegator) AS "distinct delegators",
  COUNT(DISTINCT todelegate) AS "total delegates",
  COUNT(DISTINCT TRY_CAST(d.delegator AS VARCHAR)) * 100.00000 / (
    SELECT
      COUNT(DISTINCT recipient)
    FROM
      uniswap_ethereum.airdrop_claims
  ) AS "delegation ratio"
FROM
  uniswap_ethereum.UNI_evt_DelegateChanged AS d
  JOIN uniswap_ethereum.airdrop_claims AS a ON d.delegator = a.recipient
  
  UNION
  
 SELECT
  'airdrop recipients 6 months after the airdrop' AS description,
  COUNT(*) AS "total delegation events",
  COUNT(DISTINCT delegator) AS "distinct delegators",
  COUNT(DISTINCT todelegate) AS "total delegates",
  COUNT(DISTINCT TRY_CAST(d.delegator AS VARCHAR)) * 100.00000 / (
    SELECT
      COUNT(DISTINCT recipient)
    FROM
      uniswap_ethereum.airdrop_claims
  ) AS "delegation ratio"
FROM
  uniswap_ethereum.UNI_evt_DelegateChanged AS d
  JOIN uniswap_ethereum.airdrop_claims AS a ON d.delegator = a.recipient
  WHERE
TO_UNIXTIME(d.evt_block_time) BETWEEN 1600291972 AND 1600291972 + 15778458
  
  UNION
  
  SELECT
  'airdrop recipients 12 months after the airdrop' AS description,
  COUNT(*) AS "total delegation events",
  COUNT(DISTINCT delegator) AS "distinct delegators",
  COUNT(DISTINCT todelegate) AS "total delegates",
  COUNT(DISTINCT TRY_CAST(d.delegator AS VARCHAR)) * 100.00000 / (
    SELECT
      COUNT(DISTINCT recipient)
    FROM
      uniswap_ethereum.airdrop_claims
  ) AS "delegation ratio"
FROM
  uniswap_ethereum.UNI_evt_DelegateChanged AS d
  JOIN uniswap_ethereum.airdrop_claims AS a ON d.delegator = a.recipient
  WHERE TO_UNIXTIME(d.evt_block_time) BETWEEN 1600291972 AND 1600291972 + 31556916