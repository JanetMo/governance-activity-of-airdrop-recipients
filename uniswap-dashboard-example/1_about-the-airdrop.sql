-- example queries for the uniswp airdrop
-- table featuring basic information about the airdrop (e.g. size and time frame)

SELECT 
1000000000 AS "total supply", -- fixed numbers retrieved from Uniswap (https://blog.uniswap.org/uni)
150000000 AS "total tokens reserved for airdrop",
(CAST(150000000 AS DOUBLE) / CAST(1000000000 AS DOUBLE)) * 100 AS "share of suppply airdropped",
251534 AS "total eligible addresses",
COUNT(*) AS "number of airdrop recipients",
TRY_CAST(COUNT(*) AS REAL) / 251534 * 100 AS "percentage of addresses that claimed",
SUM(amount_original) AS "total tokens claimed",
SUM(amount_original)/ 150000000 * 100 AS "percentage of tokens claimed",
SUM(amount_usd) AS "total USD airdropped",
150000000 - SUM(amount_original)  AS "total tokens unclaimed",
AVG(amount_original) AS "average claim",
MAX(amount_original) AS "maximum claim",
MIN(amount_original) AS "minimum claim",
MIN (block_time) AS "first one claimed",
MAX (block_time) AS "last one claimed"

FROM uniswap_ethereum.airdrop_claims -- table of the airdrop contract (0x090d4613473dee047c3f2706764f49e0821d256e) containing all the airdrop transactions

