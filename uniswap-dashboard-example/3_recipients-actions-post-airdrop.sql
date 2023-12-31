-- table and bar chart that show the actions recipients since the airdrop
-- which share of airdrop recipients held, transferred, partially transferred or increased their position

WITH tokens AS (
  SELECT
    contract_address,
    symbol,
    decimals
  FROM tokens.erc20
  WHERE contract_address = 0x1f9840a85d5af5bf1d1762f925bdaddc4201f984 -- contract address of UNI to get all transfers
  LIMIT 1
), addresses AS (
      SELECT DISTINCT
      (account) AS "Addresses",
      amount / CAST(POWER(10, 18) AS DOUBLE)  AS "Airdropped Amount"
    FROM
      uniswap_ethereum.MerkleDistributor_evt_Claimed -- table with the airdrop recipients
), flow AS (
  SELECT
    evt_block_time,
    "to" AS "User",
    "value" / TRY_CAST(POWER(10, decimals) AS DOUBLE) AS "Amount",
    0 AS "Withdrawn",
    "value" / TRY_CAST(POWER(10, decimals) AS DOUBLE) AS "Deposited"
  FROM erc20_ethereum.evt_Transfer AS s
  INNER JOIN tokens AS t
    ON t.contract_address = s.contract_address
  INNER JOIN addresses
    ON "to" = "Addresses"
  UNION ALL
  SELECT
    evt_block_time,
    "from" AS "User",
    "value" / TRY_CAST(POWER(10, decimals) AS DOUBLE) * -1 AS "Amount",
    "value" / TRY_CAST(POWER(10, decimals) AS DOUBLE) AS "Withdrawn",
    0 AS "Deposited"
  FROM erc20_ethereum.evt_Transfer AS s
  INNER JOIN tokens AS t
    ON t.contract_address = s.contract_address
  INNER JOIN addresses
    ON "from" = "Addresses"
), uni_agg AS (
  SELECT
    "User",
    MAX(DATE(evt_block_time)) AS "Last Active Date",
    ROUND(date_diff('day', CURRENT_DATE, DATE(MAX(evt_block_time)))) as "Net Change from Airdrop",
    SUM("Amount") AS "Balance",
    COUNT("Amount") AS "Number of Uni Transfers",
    SUM("Deposited") AS "Transferred In",
    SUM("Withdrawn") AS "Transferred Out"
  FROM flow
  GROUP BY
    "User"
), temp AS (
  SELECT
    "User",
    "Addresses",
    "Last Active Date",
    "Airdropped Amount",
    ROUND("Balance" - "Airdropped Amount") AS "Net Change from Airdrop",
    CASE WHEN "Balance" > 0 THEN "Balance" ELSE 0 END AS "Balance",
    CASE WHEN "Balance" > 1 THEN 1 ELSE 0 END AS "Posses UNI Still",
    CASE
      WHEN "Balance" < 1
      THEN 'transferred' 
      WHEN "Balance" > 1 AND "Balance" < "Airdropped Amount"
      THEN 'partially transferred'
      WHEN "Balance" > 1 AND "Balance" > "Airdropped Amount"
      THEN 'increased position'
      ELSE 'HODL'
    END AS "Position",
    "Number of Uni Transfers",
    "Transferred In",
    "Transferred Out",
    "Transferred Out" / TRY_CAST((
      "Transferred In"
    ) AS DOUBLE) AS "Withdrawal Rate"
  FROM uni_agg
  LEFT JOIN addresses
    ON "User" = "Addresses"
  ORDER BY
    "Balance" DESC
), total_k AS (
  SELECT
    COUNT(DISTINCT (
      "Addresses"
    )) AS "total",
    1 AS keys
  FROM temp
)
SELECT
  "Position",
  COUNT(DISTINCT (
    "Addresses"
  )) AS "number of Wallets",
  COUNT(DISTINCT (
    "Addresses"
  )) / TRY_CAST(AVG("total") AS DOUBLE) * 100 AS "percent of Wallets"
FROM temp
LEFT JOIN total_k
  ON 1 = keys
GROUP BY
  "Position"