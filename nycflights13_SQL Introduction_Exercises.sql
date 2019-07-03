/*1 - There are 4 other tables we will be using, AIRPORTS, AIRLINES, PLANES, and WEATHER.
Write queries to select all the columns from each of these tables and examine them to understand what they contain*/


/*2- Write queries to return any 3 columns from any 2 of the above tables */


/*3- Write a query to add a column to any of the above tables that is your name, call it my_name */


/*4- Write another query to add a column to a different table that is your age, call it my_age*/


/*5- The visib variable in the WEATHER table is in miles. Write a query to add a new variable, visib_km,
that is the visibility in kms */


/*6- The temp variable in the WEATHER table is in F. Write a query to add a new variable, temp_c,
that is the temperature in celcius*/


/*7- The precip variable in the WEATHER table is in inches. Write a query that replaces the precip 
variable with the precipitation in cms, the visibl variable with visibility in kms, and the temp variable
with the temperature on celcius. Do not return the original variables.*/


/*8- Write a query to add a column to the WEATHER table that has the value 'N' if there is no
precipitation, 'Y' if there is.*/


/*9- Write a query to add a column to the WEATHER table that defines the is based on the following
visibility ranges:
Fog 	- <= 0.625 miles 
Mist 	- <= 1.2 miles
Haze 	- <= 3.1 miles
Clear 	- > 3.1 miles */


/*10- Write a query that adds a variable to the PLANES table that is a 1 when the engine has 'Turbo'
somewhere in the value, 0 otherwise.*/


/*11- Write a query that adds a variable to the AIRLINES table that is 'Y' when the name has 'lines' somewhere
in the value, 'N' otherwise. Make this case-INsensitive. */


/*12- Write a query that adds a variable to the WEATHER table that is the number of days between the weather reading
and the time the query is run (keep the time component on both values)*/



/*13- Write a query that adds a variable to the WEATHER table that is the number of whole days between the weather reading
and the first of the month*/


/*14- Write a query that adds a variable to the WEATHER table that is 'First half - windy' where the date of the reading
is before the 1st July and the wind is faster than 12mph, 'First half - not windy' for the same dates but less than
or equal to 12mph, and then 'Second half - ...' for after the 1st July.*/


/*15- Write a query that adds multiple variables to the WEATHER table. 
The first is the Monday of that week, inclusive (so Sunday 23:59 goes to the previous Monday)
The next is a date column created using TO_DATE() from the year, month, day, hour columns, and subtract time_hour from this
The final is the time of the recording, formatted as 22-00 NOV-2013-25 (that is, hour-minute month-year-day) */


/*16- Write a query to return records from the PLANES table where the year of production is less before 2002*/


/*17- Write a query to return records from the AIRPORTS table where the longitude is greater than -100 
with a latitude that is less than 50 or more than 60*/


/*18- Write a query to return records from the WEATHER table where the data was recorded between the 20th June and 
the 15th August inclusive using the time_hour column. */


/*19- Write a query to return records from the AIRPORTS table where the time zone is Denver, Chicago, or Los Angeles. 
Try to do this first using like statements, then again using IN once you know their full names.*/


/*20- Write a query to return all records from the PLANES table ordered by seats descending then engines ascending
for any ties.*/


/*21- Using the DISTINCT keyword use the planes table to get a unique list of manufacturers */ 


/*22- Using the airports table write 2 queries, 1 that has all airports in the America/Vancouver timezone, and 
1 that contains those with faa code 'WHD', '17G', and 'AVL'. Then combine them  so you get:
a) Airports that are in both queries
b) Airports that are in either query (without duplicating them)
c) Airports in the second query that are not in the first


/*23- Write a query to return the 15 oldest planes from the PLANE table. Include any extra ties if there are.*/


/*24- Write a query to return the top 5% of planes from the PLANE table with the most number of seats.*/


/*25- Create queries using the dual table to generate:
The date for the first of this month
The value of the sine of 1.2 radians (You may need to google how to evaluate sine in Oracle SQL)
Anything else you want to practise 
*/


/*26- Take your answer from question 7 and by nesting the table filter the results to just those records with precipitation above 
0.2cm of rain and temperature above 20 degrees celcius.*/


/*27- Take your answer from question 9 and using the WITH caluse filter the results to records with Mist or Haze*/


/*28- Take your answer from question 11 and using whichever method you prefer filter to just records with 'lines' somewhere
in the name. Order the resulting table by the carrier code descending.*/


/*29- Create a table called airlines_lines_temp that stores the result of your answer to question 26. Then drop the table.*/


/*30- Using an inner join, combine the flights table and the weather table, bringing back all columns. Will this keep any records
for which there isn't a matching weather record?*/


/*31- Using a left join, combine the weather and airports table to get the full name of the airport as the only extra column. What
would happen if a match couldn't be found for the airport code?*/


/*32- Using 3 joins, combine the flights, airports, and planes table to get a column for the full origin name, a column for the 
full destination name, and a column for the type of airplane. Justify what type of joins you use. */


/*33- Using the planes table, use a GROUP BY to identify how many planes each manufcaturer has, their average number of seats, and max speed*/


/*34- Using the airports table, how many airports are in each time zone, and using a CASE WHEN, how many of these are below 500m altitude?*/


/*35- Using a window function, add variables to the airports table that is the average altitutde per time zone, and the max altitude per timezone*/


/*36- Using window functions, add variables to the weather table that is are the average temperature per airport and month of the year, average temperature per
hour of the day and airport(regardless of day), and the record number (row number) of every record per airport per day*/


/*Final Exercise- Are newer planes better at making up time on a delay? For a more advanced question, which manufacturer has the most years where
their planes are best at making up time on a delay?*/