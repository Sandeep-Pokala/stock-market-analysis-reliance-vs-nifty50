/*     
   These queries are used to cross-check and validate
   insights generated using Python analysis.
    */


/* 
   1. Compare average daily returns
   Purpose:
   Check whether Reliance delivers higher daily returns
   compared to the NIFTY 50 benchmark.
    */
SELECT
    AVG(reliance_return) AS avg_reliance_return,
    AVG(nifty_return) AS avg_nifty_return
FROM market_data;


/* 
   2. Monthly average returns
   Purpose:
   Aggregate daily returns at a monthly level since
   business and investment reviews are usually done
   month-wise.
    */
SELECT
    strftime('%Y-%m', date) AS month,
    AVG(reliance_return) AS avg_reliance_return,
    AVG(nifty_return) AS avg_nifty_return
FROM market_data
GROUP BY month
ORDER BY month;


/* 
   3. Volatility comparison
   Purpose:
   Measure overall return variability to compare
   risk between Reliance and NIFTY.
    */
SELECT
    sqrt(AVG(reliance_return * reliance_return)) AS reliance_volatility,
    sqrt(AVG(nifty_return * nifty_return)) AS nifty_volatility
FROM market_data;


/* 
   4. Best performing months for Reliance
   Purpose:
   Identify periods where Reliance delivered
   strong positive performance.
    */
SELECT
    strftime('%Y-%m', date) AS month,
    AVG(reliance_return) AS avg_reliance_return
FROM market_data
GROUP BY month
ORDER BY avg_reliance_return DESC
LIMIT 5;


/* -----------------------------------------------------
   5. Worst performing month for Reliance
   Purpose:
   Identify the weakest month in terms of average
   returns to understand downside risk.
   ----------------------------------------------------- */
SELECT
    strftime('%Y-%m', date) AS month,
    AVG(reliance_return) AS avg_reliance_return
FROM market_data
GROUP BY month
ORDER BY avg_reliance_return ASC
LIMIT 1;


/* -----------------------------------------------------
   6. Volume vs price movement
   Purpose:
   Analyze whether high trading activity aligns
   with stronger price movements.
   ----------------------------------------------------- */
SELECT
    strftime('%Y-%m', date) AS month,
    AVG(reliance_volume) AS avg_volume,
    AVG(ABS(reliance_return)) AS avg_abs_return
FROM market_data
GROUP BY month
ORDER BY avg_volume DESC;
