-- table listing all airdrop recipients 
SELECT 
project,
token_symbol,
recipient,
amount_original,
amount_usd,
block_time,
blockchain,
tx_hash,
contract_address

FROM uniswap_ethereum.airdrop_claims

ORDER BY block_time ASC