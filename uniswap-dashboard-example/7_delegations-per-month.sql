-- bar chart showing the total delegations and the delegations of airdrop recipients per month

SELECT
  DATE_TRUNC('month', d.evt_block_time) AS month,
  COUNT(*) AS "total delegations",
  COUNT(a.recipient) AS "delegations of airdrop recipients"
FROM
  uniswap_ethereum.UNI_evt_DelegateChanged AS d
LEFT JOIN
  uniswap_ethereum.airdrop_claims AS a ON d.delegator = a.recipient
GROUP BY
  1
ORDER BY
  month;
