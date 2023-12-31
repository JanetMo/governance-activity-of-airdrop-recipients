-- table calculating the 90 and 99 percentiles according to the amounts received 
-- percentage of the tokend distributed to the top 10% of recipients

WITH PercentileRanges AS (
  SELECT
    0.0 AS percentile_start,
    0.9 AS percentile_end
  UNION ALL
  SELECT
    0.9 AS percentile_start,
    1.0 AS percentile_end
  UNION ALL
  SELECT
    0.99 AS percentile_start,
    1.0 AS percentile_end
), Percentiles AS (
  SELECT
    pr.percentile_start,
    pr.percentile_end,
    APPROX_PERCENTILE(ac.amount_original, pr.percentile_start) AS range_start,
    APPROX_PERCENTILE(ac.amount_original, pr.percentile_end) AS range_end
  FROM PercentileRanges pr
  CROSS JOIN uniswap_ethereum.airdrop_claims ac
  GROUP BY pr.percentile_start, pr.percentile_end
), TokenDistribution AS (
  SELECT
    pr.percentile_start,
    pr.percentile_end,
    pr.range_start,
    pr.range_end,
    COUNT(ac.recipient) AS count_recipients,
    SUM(ac.amount_original) AS total_tokens
  FROM Percentiles AS pr
  CROSS JOIN uniswap_ethereum.airdrop_claims AS ac
  WHERE ac.amount_original >= pr.range_start AND ac.amount_original <= pr.range_end
  GROUP BY
    pr.percentile_start,
    pr.percentile_end,
    pr.range_start,
    pr.range_end
)
SELECT
  pr.percentile_start * 100 AS percentile,
  pr.percentile_end * 100 AS next_percentile,
  pr.range_start,
  pr.range_end,
  count_recipients,
  total_tokens,
  total_tokens / (SELECT SUM(total_tokens) FROM TokenDistribution) * 100 AS token_percentage
FROM TokenDistribution AS pr
ORDER BY
  pr.percentile_start