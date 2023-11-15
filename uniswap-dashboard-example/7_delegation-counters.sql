-- table calculating the share of delegators among all token holders 
-- for three different points in time: 6 months after the airdrop, 12 months after the airdrop and currently

SELECT
  'all token holders current' AS description,
  COUNT(*) AS "total delegation events",
  COUNT(DISTINCT delegator) AS "distinct delegators",
  COUNT(DISTINCT todelegate) AS "total delegates",
  COUNT(DISTINCT TRY_CAST(delegator AS VARCHAR)) * 100.00000 / (
    SELECT
      COUNT(DISTINCT "to") AS total_token_holders
    FROM
      erc20_ethereum.evt_Transfer
    WHERE
      contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
  ) AS "delegation ratio"
FROM
  uniswap_ethereum.UNI_evt_DelegateChanged
  
UNION

SELECT
  'all token holders 6 months after the airdrop' AS description,
  COUNT(*) AS "total delegation events",
  COUNT(DISTINCT delegator) AS "distinct delegators",
  COUNT(DISTINCT todelegate) AS "total delegates",
  COUNT(DISTINCT TRY_CAST(delegator AS VARCHAR)) * 100.00000 / (
    SELECT
      COUNT(DISTINCT "to") AS total_token_holders
    FROM
      erc20_ethereum.evt_Transfer
    WHERE
      contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
      AND evt_block_time BETWEEN TRY_CAST('2020-09-16' AS TIMESTAMP) AND TRY_CAST('2020-09-16' AS TIMESTAMP) + INTERVAL '6' MONTH
  ) AS "delegation ratio"
FROM
  uniswap_ethereum.UNI_evt_DelegateChanged
  WHERE
TO_UNIXTIME(evt_block_time) BETWEEN 1600291972 AND 1600291972 + 15778458
UNION
SELECT
  'all token holders 12 months after the airdrop' AS description,
  COUNT(*) AS "total delegation events",
  COUNT(DISTINCT delegator) AS "distinct delegators",
  COUNT(DISTINCT todelegate) AS "total delegates",
  COUNT(DISTINCT TRY_CAST(delegator AS VARCHAR)) * 100.00000 / (
    SELECT
      COUNT(DISTINCT "to") AS total_token_holders
    FROM
      erc20_ethereum.evt_Transfer
    WHERE
      contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
      AND evt_block_time BETWEEN TRY_CAST('2020-09-16' AS TIMESTAMP) AND TRY_CAST('2020-09-16' AS TIMESTAMP) + INTERVAL '6' MONTH
  ) AS "delegation ratio"
FROM
  uniswap_ethereum.UNI_evt_DelegateChanged
WHERE TO_UNIXTIME(evt_block_time) BETWEEN 1600291972 AND 1600291972 + 31556916