USE packt_liquor;
EXPLAIN wines;
SELECT * FROM wines;


-- Exercise #1 - Query all columns from the wine table with a limit of getting only 20 records. --
SELECT * 
FROM wines
LIMIT 20;

-- Exercise #2 - Query the following columns: Type, Name, Country, Rating from the wine table with a limit of 20 records. --
SELECT Type, Name, Country, Rating
FROM wines
LIMIT 20;

-- Exercise #3 - What are the distinct wine types? --
SELECT DISTINCT(type)
FROM wines;

-- Exercise #4 - Calculate the number of distinct wine types. --
SELECT COUNT(DISTINCT(type))
FROM wines;

-- Exercise #5 - Calculate the number of distinct countries producing Sparkling wines. --
SELECT COUNT(DISTINCT(country))
FROM wines
WHERE type = 'Sparkling';

-- Exercise #6 – List the number of wines produced per country in descending order. --
SELECT COUNT(name), country
FROM wines
GROUP BY 2
ORDER BY 1 desc;

/* Exercise #7 – What is the average price per each wine type? 
Round the number to 2 decimal places and order the average price result in ascending order (tip – use the ROUND function). */
SELECT ROUND(AVG(price),2) AS avg_price, type
FROM wines
GROUP BY 2
ORDER BY 1;

/* Exercise #8 – What is the average price by year? Order the result in ascending order based on the Year. 
Exclude NULL values in the Year column from the group-level result. */
SELECT ROUND(AVG(price),2) AS avg_price_per_year, year
FROM wines
WHERE year IS NOT NULL
GROUP BY 2
ORDER BY 2;

-- Exercise #9 – What are the average price and average rating by country? Order by the Country name. --
SELECT country, ROUND(AVG(price),2) AS avg_price, ROUND(AVG(rating), 1) AS avg_rating
FROM wines
GROUP BY 1
ORDER BY 1;

/* Exercise #10 – What are the average price and average rating by year for Italy? 
Exclude NULL values in the Year column from the raw table before grouping. */
SELECT year, ROUND(AVG(price),2) AS avg_price, ROUND(AVG(rating), 1) AS avg_rating 
FROM wines
WHERE Country = 'Italy' AND year IS NOT NULL
GROUP BY 1;

/* Exercise #11 – What is the average price by country and by region in each country for the following countries: 
Argentina, Canada, Italy, Greece? 
Order the result based on the Country ascending and secondly based on the average price in a region descending. */
SELECT Country, Region, ROUND(AVG(price),2) AS avg_price
FROM wines
WHERE Country = 'Argentina' OR Country = 'Canada' OR Country = 'Italy' OR Country = 'Greece'
GROUP BY 1, 2
ORDER BY 1 asc, 2 desc;

-- Exercise #12 – How many wines are available per each rating? --
SELECT COUNT(name), rating
FROM wines
GROUP BY 2;

-- Exercise #13 – How many wines of each wine type were produced in each country? --
SELECT COUNT(name) AS number_of_wines, type, country
FROM wines
GROUP BY 3,2
ORDER BY 3;

/* Exercise #14 – What is the maximum price per each wine type excluding the following years – 2011, 2013, 2015, 2018)? 
Order by maximum price in descending order.*/
SELECT MAX(price), type, year
FROM wines
WHERE year NOT LIKE '2011' AND year NOT LIKE '2013' AND year NOT LIKE '2015' AND year NOT LIKE '2018'
GROUP BY 2, 3
ORDER BY 1 desc;

-- Exercise #15 - What are the names and country locations of the top 10 red wines with the highest rating? --
SELECT name, country
FROM wines
WHERE type = 'Red'
ORDER BY rating desc
LIMIT 10;

-- Exercise #16 – List the 10 top Wineries in France that have the highest rating excluding wines with a number of reviews below 200. --
SELECT Winery, country, rating, NumberOfRatings
FROM wines
WHERE country = 'France' AND NumberOfRatings >= 200
ORDER BY 3 desc
LIMIT 10;

-- Exercise #17 – Which group of wine types has the highest average rating for wines that were produced between 2000 and 2010 or between 2015 and 2020. --
SELECT type, ROUND(AVG(rating), 2) as avg_rating, year
FROM wines
WHERE year BETWEEN 2000 and 2010 OR year BETWEEN 2015 and 2020
GROUP BY 1,3
ORDER BY 2 desc;

/* Exercise #18 – What are the five top countries with the highest average rating for wines 
that are above the price of 20 Euro? */
SELECT country, price, ROUND(AVG(rating),2) AS highest_avg_rating
FROM wines
WHERE price >20
GROUP BY 1, 2
ORDER BY 3 desc
LIMIT 5;

/* Exercise #19 – What are the top 20 regions that produce the highest number of wines with a minimum of 50 wines, 
where the price of a wine is below 300 EURO, and the number of rating reviews for the wine is more than 100? */
SELECT region, number_of_wines
FROM (
SELECT region, COUNT(name) AS number_of_wines
FROM wines
WHERE price < 300 AND NumberOfRatings >100
GROUP BY 1
ORDER BY 2 desc
LIMIT 20) as original
WHERE number_of_wines >50
;



