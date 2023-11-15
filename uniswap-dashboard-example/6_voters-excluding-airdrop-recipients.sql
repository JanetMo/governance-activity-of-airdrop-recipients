-- table calculating the share of Snapshot voters among all token holders excluding the airdrop recipients

WITH TokenHoldersWithoutAirdrop AS (
  SELECT DISTINCT
    et."to"
  FROM erc20_ethereum.evt_Transfer AS et
  LEFT OUTER JOIN uniswap_ethereum.airdrop_claims AS ac
    ON TRY_CAST(et."to" AS VARCHAR) = TRY_CAST(ac.recipient AS VARCHAR)
  WHERE
    et.contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
    AND ac.recipient IS NULL -- exclude airdrop recipients 
), AllTokenHolders AS (
  SELECT DISTINCT
    et."to"
  FROM erc20_ethereum.evt_Transfer AS et
  WHERE
    et.contract_address = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
)
SELECT
  (
    SELECT
      COUNT(*)
    FROM TokenHoldersWithoutAirdrop
  ) AS token_holder_without_airdrop,
  COUNT(DISTINCT CASE WHEN ac.recipient IS NULL THEN v.voter END) AS voters_excluding_airdrop_recipients,
  TRY_CAST(COUNT(DISTINCT CASE WHEN ac.recipient IS NULL THEN v.voter END) AS REAL) / (
    SELECT
      COUNT(*)
    FROM TokenHoldersWithoutAirdrop
  ) * 100 AS percentage_voters
FROM AllTokenHolders AS th
LEFT JOIN dune.shot.dataset_votes_view AS v
  ON th."to" = v.voter
LEFT OUTER JOIN uniswap_ethereum.airdrop_claims AS ac
  ON TRY_CAST(th."to" AS VARCHAR) = TRY_CAST(ac.recipient AS VARCHAR)
WHERE
  v.space = 'uniswap'