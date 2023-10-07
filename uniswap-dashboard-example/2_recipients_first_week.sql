SELECT 
    SUM("recipients per day") AS "total recipients for 7 days",
    (SELECT COUNT(DISTINCT recipient) FROM uniswap_ethereum.airdrop_claims) AS "total recipients",
    ROUND(SUM("recipients per day") * 100.0 / NULLIF((SELECT COUNT(recipient) FROM uniswap_ethereum.airdrop_claims), 0), 2) AS "claimed percentage"
FROM (
    SELECT 
        date_trunc('day', block_time) AS day, 
        COUNT(recipient) AS "recipients per day"
    FROM uniswap_ethereum.airdrop_claims
    GROUP BY 1
    ORDER BY day ASC
    LIMIT 7
) subquery;
