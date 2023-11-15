-- table listing all proposals in the uniswap governance portal

SELECT 
evt_block_time,
startBlock,
endBlock,
contract_address,
id,
proposer,
description
FROM uniswap_v2_ethereum.GovernorAlpha_evt_ProposalCreated
UNION
SELECT 
evt_block_time,
startBlock,
endBlock,
contract_address,
id,
proposer,
description
FROM uniswap_v3_ethereum.GovernorBravoDelegate_evt_ProposalCreated