-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)
INSERT INTO city (name, countrycode, district, population)
VALUES ('Smallville', 'USA', 'Kansas', 45001);

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('USA', 'Kryptonese', false, 0.0001);

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.
UPDATE countrylanguage
SET language = 'Krypto-babble'
WHERE language = 'Kryptonese';

-- 4. Set the US captial to Smallville, Kansas in the country table.
SELECT * FROM city
WHERE name = 'Smallville';

UPDATE country
SET capital = 4080
WHERE code = 'USA';

-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
DELETE FROM city
WHERE name = 'Smallville' AND district = 'Kansas';

-- 6. Return the US captial to Washington.
SELECT * FROM city
WHERE name = 'Washington';

UPDATE country
SET capital = 3813
WHERE code = 'USA';

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
DELETE FROM city
WHERE name = 'Smallville' AND district = 'Kansas';

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)
SELECT * FROM country
JOIN countrylanguage cl ON country.code = cl.countrycode
WHERE indepyear BETWEEN 1800 AND 1972;

UPDATE countrylanguage
SET isofficial = NOT isofficial
WHERE countrylanguage.countrycode IN (SELECT country.code FROM country WHERE country.indepyear BETWEEN 1800 AND 1972);
ROLLBACK;

SELECT * FROM countrylanguage
WHERE countrycode = 'USA';

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)
SELECT CEILING(population/1000) as population_1000s FROM city;

UPDATE city
SET population = population/1000;


-- 10. Assuming a country's surfacearea is expressed in square miles, convert it to 
-- square meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)
SELECT surfacearea * 1609.34 as sq_meter FROM country
JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE language = 'French' AND percentage > 20;


UPDATE country
SET surfacearea = surfacearea * 1609.34
WHERE country.code IN (SELECT countrylanguage.countrycode FROM countrylanguage WHERE countrylanguage.percentage > 20 AND language = 'French');
ROLLBACK;
