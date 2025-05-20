/* International Breweries Analysis */

/* Profit Worth of Brewery within the last 3 years in different territories */
SELECT SUM(profit) AS TotalProfit_last_3_years
FROM breweries;

/* Total profit comparison between 2 territories to aid profit maximization in the coming years */
SELECT 
    CASE
        WHEN countries IN ('Nigeria', 'Ghana') THEN 'Anglophone'
        WHEN countries IN ('Benin', 'Senegal', 'Togo') THEN 'Francophone'
    END AS region, 
    SUM(profit) AS total_profit
FROM breweries
GROUP BY region
ORDER BY total_profit DESC;

/* Alternative format */
SELECT 
    (SELECT SUM(profit) FROM breweries WHERE countries IN ('Nigeria', 'Ghana')) AS Anglophone,
    (SELECT SUM(profit) FROM breweries WHERE countries IN ('Benin', 'Senegal', 'Togo')) AS Francophone;

/* Country with the highest profit generated in 2019 */
SELECT countries, SUM(profit) AS total_profit
FROM breweries
WHERE years = 2019
GROUP BY countries
ORDER BY total_profit DESC;

/* Overall profit generated */
SELECT years, SUM(profit) AS SumOfProfit
FROM breweries
GROUP BY years
ORDER BY SumOfProfit DESC;

/* Month with the least profit number in 3 years */
SELECT months, SUM(profit) AS SumOfProfit
FROM breweries
GROUP BY months
ORDER BY SumOfProfit ASC;

/* Minimum profit generated in the month of December 2019 */
SELECT MIN(profit) AS MinProfit, months, years
FROM breweries 
WHERE months = 'December' AND years = 2019
GROUP BY months, years
ORDER BY MinProfit DESC;

/* Alternative format (Top 10 lowest profits) */
SELECT profit, months, years
FROM breweries 
WHERE months = 'December' AND years = 2019
ORDER BY profit ASC
LIMIT 10;

/* Profit in percentage for each month in 2019 */
SELECT 
    months, 
    profit_per_month, 
    (profit_per_month * 100.0 / total_profit_2019) AS profit_in_percentage
FROM (
    SELECT 
        months, 
        SUM(profit) AS profit_per_month, 
        (SELECT SUM(profit) FROM breweries WHERE years = 2019) AS total_profit_2019
    FROM breweries
    WHERE years = 2019
    GROUP BY months
) AS sub;

/* Brand with the highest profit in Senegal */
SELECT brands, SUM(profit) AS sum_of_profit
FROM breweries
WHERE countries = 'Senegal'
GROUP BY brands
ORDER BY sum_of_profit DESC
LIMIT 1;

/* SECTION B (BRAND ANALYSIS) */

/* Top 3 brands consumed in the francophone countries */
SELECT brands, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE countries IN ('Togo', 'Senegal', 'Benin') AND years IN (2018, 2019)
GROUP BY brands
ORDER BY QTYConsumed DESC
LIMIT 3;

/* Top 2 consumer brands in Ghana */
SELECT brands, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE countries = 'Ghana'
GROUP BY brands
ORDER BY QTYConsumed DESC
LIMIT 2;

/* Product brand consumption in the most oil-rich country in West Africa (Nigeria) */
SELECT brands, SUM(quantity) AS QTYConsumed, SUM(profit) AS sum_of_profit, years
FROM breweries
WHERE brands NOT LIKE '%malt%' AND countries = 'Nigeria' AND years IN (2017, 2018, 2019)
GROUP BY brands, years
ORDER BY years DESC;

/* Favourite malt brand in Anglophone region between 2018 and 2019 */
SELECT brands, SUM(quantity) AS Anglophone_QTY_Consumed
FROM breweries
WHERE brands LIKE '%malt%' AND countries IN ('Nigeria', 'Ghana') AND years IN (2018, 2019)
GROUP BY brands
ORDER BY Anglophone_QTY_Consumed DESC;

/* Highest sold brand in Nigeria in 2019 */
SELECT brands, SUM(unit_price * quantity) AS Sales 
FROM breweries
WHERE years = 2019 AND countries = 'Nigeria'
GROUP BY brands
ORDER BY Sales DESC;

/* Favourite Brand in South-South Region Nigeria */
SELECT brands, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE region = 'southsouth' AND countries = 'Nigeria'
GROUP BY brands
ORDER BY QTYConsumed DESC;

/* Beer Consumption in Nigeria */
SELECT brands, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE brands NOT LIKE '%malt%' AND countries = 'Nigeria'
GROUP BY brands
ORDER BY QTYConsumed DESC;

/* Budweiser consumption in the regions of Nigeria */
SELECT brands, region, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE brands LIKE '%budweiser%' AND countries = 'Nigeria'
GROUP BY brands, region
ORDER BY QTYConsumed DESC;

/* Budweiser consumption in the regions of Nigeria in 2019 */
SELECT brands, region, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE brands LIKE '%budweiser%' AND countries = 'Nigeria' AND years = 2019
GROUP BY brands, region
ORDER BY QTYConsumed DESC;

/* COUNTRIES ANALYSIS */

/* Country with highest consumption of Beer */
SELECT countries, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE brands NOT LIKE '%malt%'
GROUP BY countries
ORDER BY QTYConsumed DESC;

/* Highest sales personnel of Budweiser in Senegal */
SELECT sales_rep, SUM(quantity) AS QTYConsumed
FROM breweries
WHERE brands = 'budweiser' AND countries = 'Senegal'
GROUP BY sales_rep
ORDER BY QTYConsumed DESC;

/* Country with the highest profit of the fourth quarter in 2019 */
SELECT countries, SUM(profit) AS Profit_Per_4th_Quarter
FROM breweries
WHERE years = 2019 AND months IN ('October', 'November', 'December')
GROUP BY countries
ORDER BY Profit_Per_4th_Quarter DESC;
