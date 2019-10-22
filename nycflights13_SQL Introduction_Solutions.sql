/*1 - There are 4 other tables we will be using, AIRPORTS, AIRLINES, PLANES, and WEATHER.
Write queries to select all the columns from each of these tables and examine them to understand what they contain*/
SELECT 
    *
FROM
    schema_name.airports;

SELECT 
    *
FROM
   schema_name.airlines;
    
SELECT 
    *
FROM
    schema_name.planes;
    
SELECT 
    *
FROM
    schema_name.weather;
    
    
/*2- Write queries to return any 3 columns from any 2 of the above tables */
SELECT
    temp,
    origin,
    year
FROM
    schema_name.weather;

SELECT 
    name,
    lat,
    alt
FROM
    schema_name.airports;


/*3- Write a query to add a column to any of the above tables that is your name, call it my_name */
SELECT 
    a.*,
    'Ryan' AS my_name
FROM
    schema_name.planes a;


/*4- Write another query to add a column to a different table that is your age, call it my_age*/
SELECT 
    a.*,
    '25' AS my_age
FROM
    schema_name.airports a;


/*5- The visib variable in the WEATHER table is in miles. Write a query to add a new variable, visib_km,
that is the visibility in kms */
SELECT 
    a.*,
    visib * 1.60934 AS visib_km
FROM
    schema_name.weather a;


/*6- The temp variable in the WEATHER table is in F. Write a query to add a new variable, temp_c,
that is the temperature in Celsius*/
SELECT 
    a.*,
    (temp - 32) * 5/9 AS temp_c
FROM
    schema_name.weather a;


/*7- The precip variable in the WEATHER table is in inches. Write a query that replaces the precip 
variable with the precipitation in cms, the visib variable with visibility in kms, and the temp variable
with the temperature on Celsius. Do not return the original variables.*/
SELECT 
    origin,
    year,
    month,
    day,
    hour,
    (temp - 32) * 5/9 AS temp,
    dewp,
    humid,
    wind_dir,
    wind_speed,
    wind_gust,
    precip * 2.54 AS precip,
    pressure,
    visib * 0.621371 AS visib,
    time_hour
FROM 
    schema_name.weather;


/*8- Write a query to add a column to the WEATHER table that has the value 'N' if there is no
precipitation, 'Y' if there is.*/
SELECT
    a.*,
    CASE 
        WHEN precip > 0 THEN 'Y'
        ELSE 'N'
    END AS has_precip
FROM
    schema_name.weather a;


/*9- Write a query to add a column to the WEATHER table that defines the is based on the following
visibility ranges:
Fog 	- <= 0.625 miles 
Mist 	- <= 1.2 miles
Haze 	- <= 3.1 miles
Clear 	- > 3.1 miles */
SELECT
    a.*,
    CASE 
        WHEN visib <= 0.625 THEN 'Fog'
        WHEN visib <= 1.2 THEN 'Mist'
        WHEN visib <= 3.1 THEN 'Haze'
        ELSE 'Clear'
    END AS visib_desc
FROM
    schema_name.weather a;


/*10- Write a query that adds a variable to the PLANES table that is a 1 when the engine has 'Turbo'
somewhere in the value, 0 otherwise.*/
SELECT 
    a.*,
    CASE
        WHEN lower(engine) LIKE '%turbo%' then 1 
        ELSE 0
    END AS turbo_flag
FROM
    schema_name.planes a;


/*11- Write a query that adds a variable to the AIRLINES table that is 'Y' when the name has 'lines' somewhere
in the value, 'N' otherwise. Make this case-INsensitive. */
SELECT
    a.*,
    CASE
        WHEN lower(name) LIKE '%lines%' then 'Y'
        ELSE 'N'
    END AS line_flag
FROM
    schema_name.airlines a;


/*12- Write a query that adds a variable to the WEATHER table that is the number of days between the weather reading
and the time the query is run (keep the time component on both values)*/
SELECT 
    a.*,
    SYSDATE - time_hour AS days_since_record
FROM
    schema_name.weather a;


/*13- Write a query that adds a variable to the WEATHER table that is the number of whole days between the weather reading
and the first of the month the record was taken*/
SELECT 
    a.*,
    TRUNC(time_hour) - TRUNC(time_hour, 'MM') AS days_since_first_of_month
FROM
    schema_name.weather a;


/*14- Write a query that adds a variable to the WEATHER table that is 'First half - windy' where the date of the reading
is before the 1st July and the wind is faster than 12mph, 'First half - not windy' for the same dates but less than
or equal to 12mph, and then 'Second half - ...' for after the 1st July.*/
SELECT 
    a.*,
    CASE 
        WHEN time_hour < DATE '2013-07-01' and wind_speed > 12 THEN 'First half - windy'
        WHEN time_hour < DATE '2013-07-01' and wind_speed <= 12 THEN 'First half - not windy'
        WHEN time_hour > DATE '2013-07-01' and wind_speed > 12 THEN 'Second half - windy'
        WHEN time_hour > DATE '2013-07-01' and wind_speed <= 12 THEN 'Second half - not windy'
    END AS really_specific_wind_column
FROM
    schema_name.weather a;


/*15- Write a query that adds multiple variables to the WEATHER table. 
The first is the Monday of that week, inclusive (so Sunday 23:59 goes to the previous Monday)
The next is a date column created using TO_DATE() from the year, month, day, hour columns, and subtract time_hour from this
The final is the time of the recording, formatted as 22-00 NOV-2013-25 (that is, hour-minute month-year-day) */
SELECT 
    a.*,
    NEXT_DAY(time_hour, 'MON') -7 AS monday_of_week,
    TO_DATE(YEAR||'-'||MONTH||'-'||DAY||'-'||HOUR , 'YYYY-MM-DD-HH24')- time_hour AS second_column,
    TO_CHAR(time_hour, 'HH24-MI MON-YYYY-DD') as third_column
FROM
    schema_name.weather a;


/*16- Write a query to return records from the PLANES table where the year of production is less before 2002*/
SELECT
    *
FROM
    schema_name.planes
WHERE 
    year < 2002;


/*17- Write a query to return records from the AIRPORTS table where the longitude is greater than -100 
with a latitude that is less than 50 or more than 60*/
SELECT
    *
FROM
    schema_name.airports
WHERE 
    lon > -100 and (lat < 50 or lat > 60);


/*18- Write a query to return records from the WEATHER table where the data was recorded between the 20th June and 
the 15th August inclusive using the time_hour column. */
SELECT
    *
FROM
    schema_name.weather
WHERE
    time_hour BETWEEN DATE '2013-06-20' AND DATE '2013-08-16';


/*19- Write a query to return records from the AIRPORTS table where the time zone is Denver, Chicago, or Los Angeles. 
Try to do this first using like statements, then again using IN once you know their full names.*/
SELECT
    *
FROM
    schema_name.airports
WHERE 
    lower(tzone) LIKE '%denver%' or lower(tzone) LIKE '%chicago%' or lower(tzone) LIKE '%los%angeles%';
    
SELECT
    *
FROM
    schema_name.airports
WHERE 
    tzone in ('America/Chicago', 'America/Denver', 'America/Los_Angeles');


/*20- Write a query to return all records from the PLANES table ordered by seats descending then engines ascending
for any ties.*/
SELECT
    *
FROM
    schema_name.planes
ORDER BY 
    seats desc,
    engines;


/*21- Using the DISTINCT keyword use the planes table to get a unique list of manufacturers */ 
SELECT DISTINCT 
    manufacturer
FROM
    schema_name.planes;


/*22- Using the airports table write 2 queries, 1 that has all airports in the America/Vancouver timezone, and 
1 that contains those with faa code 'WHD', '17G', and 'AVL'. Then combine them so you get:
a) Airports that are in both queries
b) Airports that are in either query (without duplicating them)
c) Airports in the second query that are not in the first
*/
SELECT 
	*
FROM
	schema_name.airports
WHERE
	tzone = 'America/Vancouver';

SELECT 
	*
FROM
	schema_name.airports
WHERE
	faa IN ('WHD', '17G', 'AVL');

SELECT 
	*
FROM
	schema_name.airports
WHERE
	tzone = 'America/Vancouver'
INTERSECT
SELECT 
	*
FROM
	schema_name.airports
WHERE
	faa IN ('WHD', '17G', 'AVL');


SELECT 
	*
FROM
	schema_name.airports
WHERE
	tzone = 'America/Vancouver'
UNION 
SELECT 
	*
FROM
	schema_name.airports
WHERE
	faa IN ('WHD', '17G', 'AVL');

SELECT 
	*
FROM
	schema_name.airports
WHERE
	tzone = 'America/Vancouver'
MINUS
SELECT 
	*
FROM
	schema_name.airports
WHERE
	faa IN ('WHD', '17G', 'AVL');


/*23- Write a query to return the 15 oldest planes from the PLANES table. Include any extra ties if there are.*/
SELECT 
	*
FROM
	schema_name.planes
ORDER BY 
	year asc
FETCH FIRST 15 ROWS WITH TIES;


/*24- Write a query to return the top 5% of planes from the PLANES table with the most number of seats.*/
SELECT 
	*
FROM
	schema_name.planes
ORDER BY 
	seats desc
FETCH FIRST 5 PERCENT ROWS ONLY;


/*25- Create queries using the dual table to generate:
The date for the first of this month
The value of the sine of 1.2 radians (You may need to google how to evaluate sine in Oracle SQL)
Anything else you want to practise 
*/
SELECT 
	TRUNC(SYSDATE, 'MM'),
	SIN(1.2)
FROM
	dual;


/*26- Take your answer from question 7 and by nesting the table filter the results to just those records with precipitation above 
0.2cm of rain and temperature above 20 degrees celcius.*/
SELECT 
	* 
FROM
	(
	SELECT 
	    origin,
	    year,
	    month,
	    day,
	    hour,
	    (temp - 32) * 5/9 AS temp,
	    dewp,
	    humid,
	    wind_dir,
	    wind_speed,
	    wind_gust,
	    precip * 2.54 AS precip,
	    pressure,
	    visib * 0.621371 AS visib,
	    time_hour
	FROM 
	    schema_name.weather
	)
WHERE
	precip > 0.2 AND temp > 20;


/*27- Take your answer from question 9 and using the WITH clause filter the results to records with Mist or Haze*/
WITH weather2 as (
	SELECT
	    a.*,
	    CASE 
	        WHEN visib <= 0.625 THEN 'Fog'
	        WHEN visib <= 1.2 THEN 'Mist'
	        WHEN visib <= 3.1 THEN 'Haze'
	        ELSE 'Clear'
	    END AS visib_desc
	FROM
	    schema_name.weather a
)

SELECT 
	*
FROM 
	weather2
WHERE
	visib_desc IN ('Mist', 'Haze');


/*28- Take your answer from question 11 and using whichever method you prefer filter to just records with 'lines' somewhere
in the name. Order the resulting table by the carrier code descending.*/
SELECT 
	*
FROM
(
	SELECT
	    a.*,
	    CASE
	        WHEN lower(name) LIKE '%lines%' then 'Y'
	        ELSE 'N'
	    END AS line_flag
	FROM
	    schema_name.airlines a
)
WHERE 
	line_flag = 'Y'
ORDER BY
	carrier DESC;


/*29- Create a table called airlines_lines_temp that stores the result of your answer to question 28. Then drop the table.*/
CREATE TABLE airlines_lines_temp NOLOGGING AS
SELECT 
	*
FROM
(
	SELECT
	    a.*,
	    CASE
	        WHEN lower(name) LIKE '%lines%' then 'Y'
	        ELSE 'N'
	    END AS line_flag
	FROM
	    schema_name.airlines a
)
WHERE 
	line_flag = 'Y'
ORDER BY
	carrier DESC;

DROP TABLE airlines_lines_temp PURGE;


/*30- Using an inner join, combine the flights table and the weather table, bringing back all columns. Will this keep any records
for which there isn't a matching weather record?*/
SELECT
	*
FROM 
	schema_name.flights a 
INNER JOIN
	schema_name.weather b
ON a.time_hour = b.time_hour and a.origin = b.origin;
-- Will not keep records where there is no matching weather record


/*31- Using a left join, combine the weather and airports table to get the full name of the airport as the only extra column. What
would happen if a match couldn't be found for the airport code?*/
SELECT
	a.*,
	b.name
FROM 
	schema_name.weather a 
LEFT JOIN
	schema_name.airports b
ON a.origin = b.faa;
-- It would be null in the name column


/*32- Using 3 joins, combine the flights, airports, and planes table to get a column for the full origin name, a column for the 
full destination name, and a column for the type of airplane. Justify what type of joins you use. */
SELECT
	a.*,
	b.name AS origin_name,
	c.name AS dest_name,
	d.type
FROM 
	schema_name.flights a 
LEFT JOIN
	schema_name.airports b
ON a.origin = b.faa
LEFT JOIN
	schema_name.airports c
ON a.dest = c.faa
LEFT JOIN
	schema_name.planes d
ON a.tailnum = d.tailnum;
-- Used left joins because I wanted to keep all flights even if there was no matching full name or plane description.


/*33- Using the planes table, use a GROUP BY to identify how many planes each manufacturer has, their average number of seats, and max speed*/
SELECT 
	manufacturer,
	COUNT(*),
	AVG(seats),
	MAX(speed)
FROM
	schema_name.planes
GROUP BY
	manufacturer;


/*34- Using the airports table, how many airports are in each time zone, and using a CASE WHEN, how many of these are below 500m altitude?*/
SELECT
	tzone,
	COUNT(*),
	SUM(CASE WHEN alt*0.3048 < 500 THEN 1 ELSE 0 END) -- remember alt is in feet 
FROM
	schema_name.airports
GROUP BY 
	tzone;


/*35- Using a window function, add variables to the airports table that is the average altitude per time zone, and the max altitude per timezone*/
SELECT
	a.*,
	AVG(alt) OVER (PARTITION BY tzone),
	MAX(alt) OVER (PARTITION BY tzone)
FROM
	schema_name.airports a;


/*36- Using window functions, add variables to the weather table that is are the average temperature per airport and month of the year, average temperature per
hour of the day and airport(regardless of day), and the record number (row number) of every record per airport per day*/
SELECT 
	a.*,
	AVG(temp) OVER (PARTITION BY origin, month),
	AVG(temp) OVER (PARTITION BY hour, origin),
	ROW_NUMBER() OVER (PARTITION BY origin ORDER BY time_hour)
FROM
	schema_name.weather a;


/*Final Exercise- Are newer planes better at making up time on a delay? For a more advanced question, which manufacturer has the most years where
their planes are best at making up time on a delay?*/

