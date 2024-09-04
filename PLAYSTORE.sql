CREATE DATABASE case_study;
USE case_study;
SELECT * FROM playstore;
TRUNCATE TABLE playstore;

LOAD DATA INFILE "D:/SQL_CASE_STUDY/cleaned.csv"
INTO TABLE playstore
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- CASE STUDY BEGINS

-- 1. Working as a market analyst for a mobile app development company. 
-- Task is to identify the most promising categories (TOP 5) for launching new free apps based on their average ratings.

SELECT category FROM playstore WHERE type = 'Free' GROUP BY category ORDER BY AVG(rating) DESC LIMIT 5;


-- 2. As a business strategist for a mobile app company, my objective is to pinpoint the three categories that generate the most average revenue from 
-- paid apps. This calculation is based on the product of the app price and its number of installations.

SELECT category FROM playstore WHERE type = 'Paid' GROUP BY category ORDER BY AVG(installs* price) DESC LIMIT 3;


-- 3. As a data analyst for a gaming company, I'm tasked with calculating the percentage of app within each category. 
-- This information will help the company understand the distribution of gaming apps across different categories.

SELECT category, (COUNT(app)/(SELECT COUNT(app) FROM playstore))*100 As pecentage_distribution FROM playstore GROUP BY category;


-- 4. As a data analyst at a mobile app-focused market research firm I’ll recommend whether the company
-- should develop paid or free apps for each category based on the average ratings of that category.

WITH cte1 AS(
SELECT category, type, AVG(rating) AS avg_rating FROM playstore GROUP BY category,type),
cte2 AS(
SELECT category,type,avg_rating, DENSE_RANK() OVER(PARTITION BY category ORDER BY avg_rating DESC) AS rnk FROM cte1)
SELECT category, type AS app_type_to_deveop FROM cte2 WHERE rnk = 1;


-- 5. Suppose I'm a database administrator and my databases have been hacked and hackers are changing price of certain apps on the database, 
-- it is taking long for IT team to neutralize the hack, however me as a responsible manager don’t want my data to be changed, so
-- doing some measure where the changes in price can be recorded as I can’t stop hackers from making changes.

CREATE TABLE changelog (app VARCHAR(200), old_price DECIMAL(10,2), new_price DECIMAL(10,2), change_at TIMESTAMP);

DELIMITER //
CREATE TRIGGER price_change
AFTER UPDATE
ON playstore FOR EACH ROW 
BEGIN
	INSERT INTO changelog (app, old_price, new_price, change_at)
    VALUES (OLD.app, OLD.price, NEW.price, CURRENT_TIMESTAMP);
END;
// DELIMITER ;

UPDATE playstore SET price = 10 WHERE app = 'Coloring book moana';
UPDATE playstore SET price = 7 WHERE app = 'Paper flowers instructions';
UPDATE playstore SET price = 11 WHERE app = 'Garden Coloring Book';

SELECT * FROM changelog;


-- 6. My IT team have neutralized the threat; however,
-- hackers have made some changes in the prices, but because of my measure I have noted the changes,
-- now I want correct data to be inserted into the database again.

DROP TRIGGER price_change;
UPDATE playstore INNER JOIN changelog ON playstore.app = changelog.app
SET playstore.price = changelog.old_price;


-- 7. As a data person I am assigned the task of investigating the correlation between
-- two numeric factors: app ratings and the quantity of reviews.

SET @mean_rating = (SELECT ROUND(AVG(rating),2) FROM playstore);
SET @mean_reviews = (SELECT ROUND(AVG(reviews),2) FROM playstore);
SELECT 
ROUND((((SUM((rating - @mean_rating)*(reviews - @mean_reviews))) / (SQRT((SUM((rating - @mean_rating)*(rating - @mean_rating))) * 
(SUM((reviews - @mean_reviews) * (reviews - @mean_reviews))))))),2)  AS correlation
FROM playstore;


-- 8. My boss noticed  that some rows in genres columns have multiple genres in them, which was creating issue when developing the 
-- recommender system from the data. He/She assigned me the task to clean the genres column and make two genres out of it, 
-- rows that have only one genre will have other column as blank.

DELIMITER //
CREATE FUNCTION fname(a VARCHAR(200)) RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
	SET @b = LOCATE(';',a);
    SET @c = IF(@b>0, LEFT(a,@b-1),a);
    RETURN @c;
END;
// DELIMITER ;

DELIMITER //
CREATE FUNCTION lname(a VARCHAR(200)) RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
	SET @b = LOCATE(';',a);
    SET @c = IF(@b=0,' ', SUBSTRING(a,@b+1,LENGTH(a)));
    RETURN @c;
END;
// DELIMITER ;

SELECT app, fname(genres) AS genre_1, lname(genres) AS genre_2 FROM playstore;



-- 9. Display apps within each category that have ratings lower than the average rating for that specific category.
 
WITH cte1 AS( 
SELECT category, ROUND(AVG(rating),1) AS avg_rate FROM playstore GROUP BY category),
cte2 AS(
SELECT p.category, p.app, p.rating, c.avg_rate FROM playstore AS p INNER JOIN cte1 AS c ON c.category = p.category)
SELECT DISTINCT category, app FROM cte2 WHERE rating < avg_rate;


-- 10. Display those paid apps within each category which has installs more than the average installs of that category

WITH cte1 AS(
SELECT category, ROUND(AVG(installs),0) AS avg_install FROM playstore GROUP BY category),
cte2 AS(
SELECT p.category, p.app, p.installs, c.avg_install FROM playstore AS p INNER JOIN cte1 AS c ON p.category = c.category WHERE p.type = "Paid")
SELECT DISTINCT category, app FROM cte2 WHERE installs > avg_install;