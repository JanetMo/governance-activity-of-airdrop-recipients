-- table calculating the share of addresses that delegated to themselves

SELECT 'delegating to the same address' AS description,
COUNT(evt_tx_hash) AS total_delegation_events,
COUNT(evt_tx_hash) * 100.00 / (SELECT COUNT(evt_tx_hash) FROM uniswap_ethereum.UNI_evt_DelegateChanged) AS percentage
FROM uniswap_ethereum.UNI_evt_DelegateChanged
WHERE delegator = todelegate

UNION

SELECT 
'delegating to a different address' AS description,
COUNT(evt_tx_hash) AS total_delegation_events,
COUNT(evt_tx_hash) * 100.00 / (SELECT COUNT(evt_tx_hash) FROM uniswap_ethereum.UNI_evt_DelegateChanged) AS percentage
FROM uniswap_ethereum.UNI_evt_DelegateChanged
WHERE delegator != todelegate
