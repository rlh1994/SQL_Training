/* Part 0: Comments, syntax, and error messages

A comment is the most important thing in any language and script; for all the complex code and 
fancy solutions, with comments then code will only be useful for a day before you forget how
it works. A comment is any text that will be ignored when the script is run, so is used to 
describe what a script, or part of a script does, how it does it, and what it returns.

A comment in SQL is achieved in one of two ways. A multi-line or in-line comment is achieved by 
placing the comment like this one, between the first symbol /* and * / (without the space). To 
comment an entire single line, you place --at the start of the comment, anything on that line after 
that symbol is treated as a comment.

Keywords in SQL are case insensitive, so the follow scripts, which will be explained shortly, are equivalent.
Table and variable (column) names, are also case insensitive, unless they were created specifically to not be,
which is rare but we will see an example of later in the session.
Strings in SQL are case sensitive, and we will see the importance of this later.

Whitespace in SQL is also not important (other than for readability), so tabs, new lines, extra spaces etc
do not change the result of a query.

For this course we will try to keep a consistent style guide of lower-case for field names, upper-case for
functions/keywords, and favour more whitespace than less. There are many variants on this style guide,
and I suggest you find you can work with and try to stick to it. Operators and code will be optimised
for Oracle SQL and readability/teachability, not ANSI SQL or ISO standards e.g. we'll use != instead of <>.
*/

-- Three equivalent queries despite case and whitespace
SELECT ORIGIN, DEST FROM FLIGHTS;

select 
	origin, 
	dest 
from 
	flights;

SeLeCt      OrIgIn,DeSt        fRoM      fLiGhTs;

/*
Error messages are important in writing any code, they will appear when you have made a mistake and the code
won't run. There are a few key error messages that you will see over and over again, usually related to 
misspelling a table or variable name, trying to access a table you don't have access to, missing a keyword,
having an extra or missing comma, etc. As you practise with the exercises you will see these error messages,
learn how to read them (given that it tells you the rough location of the error), what they mean, and
how to fix them. If in doubt, or you get a new error message you don't understand, then search for the error
code and message online (avoid Oracle documentation where you can) and see if you can find a solution. Learning
how to use error messages is as important as knowing how to write the code in the first place. 
At the end of each section you'll find some purposefully wrong queries so you can see the error messages they
produce and how to fix them

Missing values i.e. no data for a variable for a given record has a special type in SQL, it is null. null is not
a string, or NA, but a specific type of null. You cannot have a record where all variables are null.
*/

---------------------------------------------------------------------------------------------------
/* Part 1: Variables - Selecting and creating them with functions

The structure of a basic query is:
SELECT
	<COLUMNS>
FROM
	<DATABASE>.<SCHEMA>.<TABLE>;

SELECT and FROM are SQL keywords and form the basis for every query. 
<DATABASE> is the database you are querying if you have multiple connections. By default is the current connection.
	We will not use this option at all in our code.
<COLUMNS> is a comma separated list of columns, either already in the table or new columns created using functions
<SCHEMA> is the name of a schema, this is optional and will default to your schema if none are provided.
<TABLE> is the name of a table within that schema
All queries must end with a semi-colon.

The most common and basic query you can ever write, and will write often, uses a wildcard character, *, which means all.

REMEMBER: the return type of a SELECT statement is another table, it's not stored anywhere, but this will be important later.
*/

/* Return a table all rows and columns within a table */
SELECT 
	*
FROM
	schema_name.flights;


/* This is equivalent to listing out all the variables, note that the last column name isn't followed by a comma */
SELECT
	year, 
	month, 
	day, 
	dep_time, 
	sched_dep_time, 
	dep_delay, 
	arr_time, 
	sched_arr_time, 
	arr_delay, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest, 
	air_time, 
	distance, 
	hour, 
	minute, 
	time_hour
FROM
	schema_name.flights;

/* Instead we can just choose to select some of the columns in the table, say just the planned info for the flights */
SELECT
	year, 
	month, 
	day, 
	sched_dep_time,   
	sched_arr_time, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest
FROM
	schema_name.flights;


/* We can add more variables/columns into this list as well, let's start with something useless to illustrate the point */
SELECT
	year, 
	month, 
	day, 
	sched_dep_time,   
	sched_arr_time, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest,
	123
FROM
	schema_name.flights;


/* The new column name isn't very useful, so let's *alias* it as something using the AS keyword */
SELECT
	year, 
	month, 
	day, 
	sched_dep_time,   
	sched_arr_time, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest,
	123 AS new_column
FROM
	schema_name.flights;


/* You don't actually have to use the AS keyword, it can be implicit but is good practise to use it. We can also
rename existing columns in the same way */
SELECT
	year, 
	month, 
	day, 
	sched_dep_time,   
	sched_arr_time, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest destination,
	123 new_column
FROM
	schema_name.flights;

/* Importantly, if you try to select all columns from a table using *, and then additional columns you create, then you get an error. */
SELECT 
	*,
	123 as new_column
FROM
	schema_name.flights;

/* This is because * means all, so how can you have all but then there be more? The solution to this is to select all
from the table (rather than the "universe") and then add our columns as well. Technically, just like how the database name is implicit,
and the schema name can be implicit, so is the table name for all of the columns. This will become more obvious why when we look at joins
later by to show this we can write the following*/
SELECT 
	schema_name.flights.tailnum
FROM
	schema_name.flights;

/* As this is quite long, it is often useful to alias a table. Here we can't use the AS keyword but the idea is the same. For small queries,
people often use simple letters like a and b for tables, but as they grow it can be useful to give them short but informative names. */
SELECT 
	a.tailnum
FROM
	schema_name.flights a;

/* Now we can finally select all columns from our table, but still add more! */
SELECT 
	a.*,
	123 as new_column
FROM
	schema_name.flights a;


/* I mentioned that you can, but shouldn't, use spaces or lower-case in column/table names. You do this by using 
double quotes ("), which is also how you reference a column, table, or schema that would require it, such as a schema
that starts with a number. */
SELECT
	year, 
	month, 
	day, 
	sched_dep_time,   
	sched_arr_time, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest,
	123 "new column"
FROM
	schema_name.flights;

/* You can now attempt questions 1-4 */

/* We can use current columns to create new columns */
SELECT
	year, 
	month,
	month + 1 AS next_month, 
	day, 
	sched_dep_time,   
	sched_arr_time, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest
FROM
	schema_name.flights;


/* We don't need to keep the original column */
SELECT
	year, 
	month + 1 AS next_month,
	day, 
	sched_dep_time,   
	sched_arr_time, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest
FROM
	schema_name.flights;


/* We CAN'T use this new column name in another column calculation, we'll see how to do it properly later */
SELECT
	year, 
	month + 1 AS next_month,
	next_month + 1 AS next_next_month
FROM
	schema_name.flights;


/* Let's look at a few functions that manipulate strings. The results aren't meaningful, but are just for examples */
SELECT
	carrier, 
	lower(carrier),
	upper(lower(carrier)),
	tailnum,
	substr(tailnum, 3),
	substr(tailnum, 1, 3),
	substr(tailnum, 3, 2),
	length(tailnum)
FROM
	schema_name.flights;

/* You can now attempt questions 5-7 */

/* 
We've now seen how to create new variables based on transformations or calculations of current ones, but often
we will want to create a new variable that is based on a condition (which could be based on another variable).

Here we introduce the concept of boolean logic, that something can be either TRUE or FALSE. Logic is more
strict than human language because it needs to be well defined. We can use a boolean condition, combined using
boolean logic, that will evaluate to TRUE or FALSE and make a decision for the new variable based on this.

In SQL, the format of this is known as a CASE statement. This is a statement, not a function, but like a 
function returns a new variable/column, with one record per record in the rest of the SELECT statement. The format is:

CASE 
	WHEN <CONDITION> THEN <VALUE>
	WHEN <CONDITION> THEN <VALUE>
	...
	WHEN <CONDITION> THEN <VALUE>
	ELSE <VALUE>
END

Where:
	<CONDITION> is a boolean statement that evaluates to TRUE or FALSE
	<VALUE> is the value that variable will take for a record satisfying the condition. They must all be the same 
		type, although Oracle may convert some automatically to match e.g. a number to a string
	ELSE <VALUE> is what is used when none of the conditions evaluate to TRUE.
	The first <CONDITION> that evaluates to TRUE for a given CASE statement is the <VALUE> returned, it will not check
		if any others are also TRUE.

As a check, and likely source of errors, every CASE statement starts with a CASE and ends with a WHEN, and for every
WHEN you have there must be a matching THEN.

The comparison operators are:
(Note, [NOT] is optional)
	= 				Equal 
	!=, <>, ^=		Unequal (not equal)
	<, <= 			Less than, Less than or equal to
	>, >=			Greater than, Greater than or equal to
	[NOT] IN 		Set membership (is the element in the set/list provided). Set provided in ('Elem1', 'Elem2', ..., 'ElemN') format
	[NOT] LIKE  	Pattern match (is the element like the provided pattern). Uses % as 0-Inf character wildcard, _ for single character wildcard
	[NOT] BETWEEN 	Shorthand for x <= y and y <= z becomes y between x and z

The logical operators are:
	AND 		Logical AND, both statements must be TRUE
	OR 			Logical OR, at least one statement must be TRUE
	NOT 		Logical negation, converts TRUE to FALSE and vice versa
	()			Brackets, force the evaluation of the logical statement inside before any outside, i.e. (2+7)*5 != 2+7*5 

*/


/* Using a CASE statement to determine if the flight departed in the morning or the afternoon, we can also use functions within our conditions */
SELECT
	year, 
	month,
	day, 
	sched_dep_time,
	CASE 
		WHEN sched_dep_time < 1200 THEN 'AM'
		ELSE 'PM'
	END AS DEP_AM_PM,
	CASE 
		WHEN sched_dep_time BETWEEN 0 AND 0800 THEN 'Early Morning'
		WHEN sched_dep_time BETWEEN 0801 AND 1159 THEN 'Morning'
		WHEN sched_dep_time BETWEEN 1200 AND 1800 THEN 'Afternoon'
		WHEN sched_dep_time BETWEEN 1801 AND 2100 THEN 'Evening'
		WHEN sched_dep_time BETWEEN 2100 AND 2359 THEN 'Night'
	END AS DEP_TIME_DETAIL, -- Notice no ELSE
	sched_arr_time,
	CASE 
		WHEN substr(sched_arr_time, 1, 2) < 12 THEN 'AM'
		WHEN substr(sched_arr_time, 1, 2) > 12 THEN 'PM'
		ELSE 'Midday'
	END AS ARR_AM_PM, 
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest
FROM
	schema_name.flights;


/* Using a CASE statement to determine if the flight was internal to NYC. Notice that the string values are in single quotes. 
We can do this using ORs or more easily using IN*/
SELECT
	year, 
	month,
	day, 
	sched_dep_time,
	sched_arr_time,
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest,
	CASE
		WHEN dest in ('JFK', 'LGA', 'EWR') THEN 'NYC'
		ELSE 'Other'
	END AS dest_nyc_check_in,
	CASE
		WHEN dest = 'JFK' or dest = 'LGA' or dest = 'EWR' THEN 'NYC'
		ELSE 'Other'
	END AS dest_nyc_check_ors
FROM
	schema_name.flights;


/* String values are case sensitive on input and output. It is usually a good idea to use lower/upper to ensure a fixed case
for all of the values in a string type variable. */
SELECT
	year, 
	month,
	day, 
	sched_dep_time,
	sched_arr_time,
	carrier, 
	flight, 
	tailnum, 
	origin, 
	dest,
	CASE
		WHEN origin in ('JFK', 'LGA', 'EWR') THEN 'NYC'
		ELSE 'Other'
	END AS origin_nyc_check1,
	CASE
		WHEN lower(origin) in ('JFK', 'LGA', 'EWR') THEN 'NYC'
		ELSE 'Other'
	END AS origin_nyc_check2,
	CASE
		WHEN origin in ('JFK', 'lga', 'ewr') THEN 'NYC'
		ELSE 'Other'
	END AS origin_nyc_check3

FROM
	schema_name.flights;


/* Finally, for no reason other than to illustrate the example, let's see if the tail number of the plane contains certain characters */
SELECT
	year, 
	month,
	day, 
	sched_dep_time,
	sched_arr_time,
	carrier, 
	flight, 
	tailnum, 
	CASE
		WHEN tailnum LIKE '%7%' THEN 1 -- Any number of character (including 0) before, and after a 7
		ELSE 0
	END AS contains_7,
	CASE 
		WHEN tailnum LIKE '%Q'	THEN 1 -- Any number of characters before a capital Q
		ELSE 0
	END AS ends_in_q,
	CASE 
		WHEN NOT (tailnum LIKE '%Q') THEN 1 -- A NOT acting on the output of a logical statement
		ELSE 0
	END AS ends_in_q,
	CASE WHEN tailnum NOT LIKE 'N5_5%' THEN 1 -- A NOT LIKE, specifically any record that doesn't match the pattern, slightly different to above
		ELSE 0
	END AS weird_test

FROM
	schema_name.flights;

/* You can now attempt questions 8-11 */

/* The final thing we will talk about in this section is Dates. For clarity, we are talking specifically about date type 
variables here but much of it also works with the timestamp data type. A date variable, much like in excel, is able to be manipulated 
as if it were a number, where 1 is equivalent to 24 hours. Dates are not pure numbers though, they are very much a data type and have 
specific functions that work just with them. 

As a reminder, Oracle has no date data type without a time component.

A few of the key date functions are:
	TO_DATE(<variable>, <fmt>)		Converts the variable (or string) into a date by giving it the format the variable is in
	TRUNC(<date> [, fmt])			Sets the time component of the date to 00:00:00 by default, or will round down to the format if provided
	sysdate							A system variable that is the current (local) date and time
	NEXT_DAY(<date>, <day>)			Returns the next date of the given day, after the date provided e.g. takes a Saturday at 00:00:01 to the NEXT Saturday
	TO_CHAR(<variable>, fmt)		Converts the variable (usually a date or a number) into the given format. This is the method to format a date in a given way NOT substr
	EXTRACT(<value> FROM <date>)	Returns the given value e.g. year from the date and returns it as a number. To extract units less than a day you must use a timestamp
	TO_TIMESTAMP(<variable>, <fmt>)	Converts the variable (or string) into a timestamp by giving it the format the variable is in

I'll also introduce the concatenate operator here, ||, which just pastes two strings together
*/
SELECT 
	time_hour,
	time_hour + 1, -- add 1 day
	time_hour + 5/24/60, -- add 5 minutes
	TRUNC(time_hour), -- set time component to 0
	TRUNC(time_hour, 'MM'), -- set to first of month TODO: check if strips time as well
	NEXT_DAY(time_hour, 'Saturday') - 1, -- Set to Friday inclusive for a week
	TO_CHAR(time_hour, 'HH24:MI DAY DD MONTH YYYY'), -- format date in a specific format
	TO_CHAR(time_hour, 'HH24:MI Day dd month yyyy'), -- notice how case changes the output
	EXTRACT(MONTH FROM time_hour), -- get the month
	(year||'-'||month||'-'||day||' '||hour||':'||minute, -- demonstrate || operator
	TO_DATE(year||'-'||month||'-'||day||' '||hour||':'||minute, 'YYYY-MM-DD HH24:MI') -- convert our columns into a date
FROM
	schema_name.flights;


/* There's two other ways to input dates rather than using TO_DATE(), which for simply writing in a fixed date can be a bit much,
the first method uses the DATE keyword and is the correct approach to use as it allows the database to optimise a query and is consistent. 
To use this one you must input the date, as a string, following the DATE keyword in the format YYYY-MM-DD as this is an industry standard.

The other method you may see but I must discourage the use of is to not use the DATE keyword and instead write the string in the DD-MON-YY format. 
I only mention it for completeness and in case you come across it. */
SELECT
	tailnum,
	DATE '2019-01-20' AS correct_method,
	'20-JAN-2019' AS incorrect_method
FROM
	schema_name.flights;


/* The reason I said not to use substr() for date formatting is because it is dependant on local settings so could change
depending on the machine running your scripts */

-- Set a specific date format for your local session and sub-string our dates
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
SELECT 
	time_hour,
	substr(time_hour, 9, 2)
FROM
	schema_name.flights;

-- Change the format and check the results
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-DD-MM HH24:MI:SS';
SELECT 
	time_hour,
	substr(time_hour, 9, 2)
FROM
	schema_name.flights;

-- Reset our format to the suggested course default
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

/* You can now attempt questions 12-15 */

/* That concludes the section on variables. You have seen how to select all or just specific columns from a table,
how to create and add your own columns to the output table that are returned by functions, as well as ones that 
are generated based on a condition. You've seen some of the main functions for working with strings, and how to 
correctly work with dates. You've learnt how to alias/rename columns, and how to alias a table as well. 
Importantly, you've learnt that all select queries return a table, and that everything between the SELECT
and FROM keywords are columns (or something that returns a column). 

Finally, here are some common mistakes you might make while using what you have learnt, check the error messages 
and understand the cause and how to fix it: */

-- TODO: Add some error examples.

-- missing comma
-- missing end
-- misspelt column
-- misspelt table
-- misspelt keyword

---------------------------------------------------------------------------------------------------
/* Part 2: Records - Filtering and ordering

Now we know how to work with our variables (columns) we can next start learning how to work with our records (rows).
In this section we'll learn how to filter our records to only those that meet a certain condition, how to order
our records based on specific variables, how to return only unique records, how to combine the records of multiple
queries together, and how to only return a specific number of records. 

We'll start by learning how to filter our records as this is one of the most common things you will want to do 
with your data. We filter our records by using a WHERE clause in the query, which is placed after the FROM statement and
tables. 

SELECT
	<COLUMNS>
FROM
	<TABLES>
WHERE
	<CONDITION>;

Exactly like in the case statement our condition is written as a boolean expression, and only records that return TRUE will be 
returned in the output table of the query. Let's start by just returning flights that departed and arrived perfectly on time:
*/
SELECT 
	*
FROM
	schema_name.flights
WHERE
	arr_delay = 0
	AND dep_delay = 0;


/* A small trick when writing queries is to make the first condition of your WHERE clause something that always evaluates to 
TRUE, that way you can comment out any of the actual conditions easily without it causing an error or having to fiddle around with ANDs */
SELECT 
	*
FROM
	schema_name.flights
WHERE
	1 = 1
	--AND arr_delay = 0
	AND dep_delay = 0;


/* Boolean logic is still the same in a WHERE clause, so we can mix AND/OR/NOT. It is still important to reduce confusion and 
the likelihood of errors to use brackets whenever using a NOT or OR connection.*/
SELECT
	*
FROM
	schema_name.flights
WHERE
	1 = 1
	AND (hour < 5 or hour > 19) -- flights scheduled to depart in the first or last 5 hours of a day
	AND dep_delay = 0; -- left on time


/* Another useful filter is whether something IS NULL or IS NOT NULL. Let's see how many of our flights don't have any delay data: */
SELECT 
	*
FROM 
	schema_name.flights
WHERE
	dep_delay IS NULL;


/* If we try to use a variable we create (or rename) in the SELECT clause of our query then we will get an error */
SELECT 
	TRUNC(time_hour) AS flight_day
FROM
	schema_name.flights
WHERE
	flight_day > DATE '2013-06-01';

SELECT 
	tailnum AS tailnumber
FROM
	schema_name.flights
WHERE
	tailnumber LIKE 'N%';

/* The reason for this is because even though we physically write the WHERE clause after the SELECT clause, the database
actually runs the WHERE clause first, so it will filter our records THEN it will select/create/rename our variables. We will see a 
more powerful method to deal with this later, but for now it's acceptable to simply repeat the variable calculation in the WHERE statement */
SELECT 
	TRUNC(time_hour) AS flight_day
FROM
	schema_name.flights
WHERE
	TRUNC(time_hour)  > DATE '2013-06-01';

SELECT 
	tailnum AS tailnumber
FROM
	schema_name.flights
WHERE
	tailnum LIKE 'N%';


/* An upside of this is you can filter the records on a variable that you don't actually include at the end */ 
SELECT 
	tailnum 
FROM
	schema_name.flights
WHERE
	origin = 'JFK'; -- only flights out of JFK airport

/* You can now attempt questions 16-19 */

/* Now we have our filtered records, we might want to sort them so they are returned to us in a given order. Sorting is a very
computationally expensive operation, so it should always be the last thing to be written and not used unless absolutely necessary 
(in particular, it may sometimes be quicker to actually order your data in another software e.g. Excel). Helpfully to enforce this point
the ORDER by clause is the last thing to be written in the ordering of a query

SELECT
	<COLUMNS>
FROM
	<TABLES>
WHERE
	<CONDITION>
ORDER BY 
	<COLUMNS>;

Let's see an example where we order by the flights least delayed on departure, after first filtering to 
flights that were delayed (so there are less records to sort) */

SELECT 
	*
FROM
	schema_name.flights
WHERE 
	dep_delay > 0
ORDER BY 
	dep_delay;

/* We can also tell the database how to order ties, by providing more columns separated my a comma, if there is a 
tie on the first it will compare the second and so on. */
SELECT 
	*
FROM
	schema_name.flights
WHERE 
	dep_delay > 0
ORDER BY 
	dep_delay, arr_delay; -- sort by departure delay THEN arrival delay if there is a tie.

/* If instead we wanted to see the most delayed flights, then we use the DESC keyword after each column we want to see in a descending order */
SELECT 
	*
FROM
	schema_name.flights
WHERE 
	dep_delay > 0
ORDER BY 
	dep_delay DESC, arr_delay; -- Most delayed departing, ties are sorted by least delayed when arriving.

SELECT 
	*
FROM
	schema_name.flights
WHERE 
	dep_delay > 0
ORDER BY 
	dep_delay DESC, arr_delay DESC; --Most delayed departing AND arriving

/* Finally, unlike the WHERE clause, the ORDER BY clause is (almost) the last thing to be run by the database, so we CAN
use new/renamed variables, but this does mean we HAVE to include that variable in our SELECT clause. It also means we can 
use a trick; instead of having to write out the full column names, because the order of our columns are now fixed we can
just use the number that column is! Be careful though, if you change your SELECT clause you might end up changing your 
sorting as well! */
SELECT 
	flight,
	dep_delay,
	arr_delay
FROM
	schema_name.flights
WHERE 
	dep_delay > 0
ORDER BY 
	2 desc, 3; -- Most delayed departing, ties are sorted by least delayed when arriving.


/* Now you can sort your data you might start to notice that you have the same records more than once, or that by removing
some variables your records look identical. Unless there are duplicates in your original data table, this can be a hint at an error 
in your script, usually duplicates get introduced by incorrect joins (which we'll come to later). If you've removed some variables 
that now gives you identical records you may need to ask yourself if you actually need some variables you removed. If you've done
this on purpose and want to get a unique set of records for your remaining variables, you can use the DISTINCT keyword. This
takes every record of your data and removes any duplicates using just the variables in your SELECT clause. Importantly there is
no way to apply the distinct to just a single variable, it is applied to every variable. 

A common example is getting a list of unique values in a variable, or a collection of variables. So we could 
get a list of all the values in the origin variable (so all the airport codes in NYC), and then all the combinations 
of origin and destination*/

SELECT DISTINCT 
	origin
FROM
	schema_name.flights;

SELECT DISTINCT 
	origin,
	dest
FROM
	schema_name.flights;

/* Next, let's discuss how we can combine the records that our queries return. Sometimes you might have some different
queries but the output has the same columns. Sometimes these could be combined into 1 by clever uses of WHERE clauses and 
CASE statements, but this isn't always possible and can lead to confusing code that is more error prone. There are 3 things
you want might to do with the records return by multiple queries:
1) Combine them, with or without duplicates, by just returning all records from both outputs. This is done using UNION [ALL] keyword.
2) Find overlap between the two sets of records, returning only the records that exist in both outputs. This is done using INTERSECT keyword.
3) Find records in the first output that aren't in the second. This is done using the MINUS keyword.
/*
TODO: add UNION/UNION ALL/INTERSECT/MINUS examples

/*
Finally, while it is rare, you might want to only return a certain number of rows once the records have been ordered. We'll see later that it is 
possible to add a row number based on an order, and you could then filter on that using a WHERE statement but this is more work than necessary.
You can achieve this using the FETCH keyword and associated terms. The FETCH statement truly is the last part that the database will run as it 
must complete all sorting first, so it won't run faster just because you only want 5 records returned. Again conveniently this is again
the last part of the physically written query.

SELECT
	<COLUMNS>
FROM
	<TABLES>
WHERE
	<CONDITION>
ORDER BY 
	<COLUMNS>
[OFFSET <NUMBER> ROWS]
FETCH NEXT <NUMBER> [PERCENT] ROWS ONLY/WITH TIES;

Where <NUMBER> is the number of rows you first optionally offset by (maybe you only want the 6th-10th rows, rather than 1st-5th), 
and then the second <NUMBER> is how many rows, or the percentage of rows you wish to return.
PERCENT is an optional keyword, to return a percentage of all records as opposed to an absolute number of records
ONLY vs WITH TIES is what it sounds like, if you return 5 records and the 5th and 6th rows ties on what is in your ORDER BY, it will actually return 6 rows.

The following example returns the 6th-10th most delayed departing flights, with any ties shown as well.
*/

SELECT 
	*
FROM
	schema_name.flights
ORDER BY 
	distance desc
OFFSET 5 ROWS
FETCH NEXT 5 ROWS WITH TIES;

SELECT 
	*
FROM
	schema_name.flights
ORDER BY 
	distance desc
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;

/* You can now attempt questions 20-22 */

/* That is the end of our section on records. We've covered how to filter the records based on conditions,
how to order the records in the output and only return a selected number of them, how to remove duplicates from our data, 
and finally how to combine the records that come from multiple queries in a variety of ways. Combined with the section on 
variables you can do the vast majority of things you can do with single tables. Next we'll learn how to combine multiple tables
so we can bring more variables and records in and show off the real power of relational databases over other tools and software.

Finally, here are some common mistakes you might make while using what you have learnt, check the error messages 
and understand the cause and how to fix it: */

--TODO: Add Error examples
---------------------------------------------------------------------------------------------------
/* Part 3: Tables - Reusing and joining

Having now covered most of what you can do with variables and records, the next logical step is to see what we can do 
with the tables themselves. This section will start off my introducing a new useful table that is always available,
then we'll look at ways to use the output of your query within the same or another query. Finally we'll spend time looking at 
one of the key features of relations databases - joins.

The first thing we introduce is the dual table. This is what's known as the dummy table, because it has only 1 row, only column,
and the single value of 'X'. The purpose of it is that, because pretty much everything in Oracle SQL expects a table/variable as an input,
you can use this to be that table, or just test things out quickly.
*/
SELECT
	* 
FROM
	dual;

SELECT
	TRUNC(SYSDATE) - 5 + 1/24 + 14/24/60, --Some random date manipulation as a test
	NEXT_DAY(TRUNC(SYSDATE), 'SAT') - 1 AS week_end_date -- should return Friday
FROM
	dual;

SELECT
	USER -- special keyword that is the current user/schema
FROM
	dual;

/* You can now attempt question 23 */

/*
We saw earlier that we can't use a newly created variable in a WHERE clause due to the order of execution. Beyond this, there are many situations
where we want to use the output of a table within another query, or keep the table for a later date. Sometimes it can just be more clear to
organise a query in multiple stages to make it easier to follow and think through. The first method for doing this known as nesting a query, because you
nest one query within another to use the output table of the inner query as the input table of the outer query.

SELECT
	<COLUMNS>
FROM
	(SELECT
		<COLUMNS>
	FROM
		<TABLES>
	WHERE
		<CONDITION>
	)
WHERE
	<CONDITION>;

We can do as deep with this nesting as we like, however it does force the database to run the inner query completely first, before any work is done 
on the outer query. This can lead to inefficiencies, so you should always try to filter as much as possible as early as possible, and never do any 
sorting until the outer-most query (if at all)!

It is usually good practise (and saves a lot of time) to alias the nested query so it is easier to refer to elsewhere in the query. While technically
possible to use the same alias as any table within the inner query it can lead to confusion and make it hard to debug your code, so I recommend never 
using the same alias for any 2 tables in the same query. 
*/

SELECT
	b.*
FROM
	(
	SELECT
		a.*,
		distance * 1.60934 AS distance_km
	FROM
		schema_name.flights a
	) b
WHERE
	distance_km > 1000;


/*
This is great when we want to just use the inner query once, but sometimes we might want to use it multiple times, or just want to write our 
queries in an easier to read format. To do with we can use a WITH statement, this allows you to alias a query's output without having to nest it 
in a query. We can alias as many query output tables as we want this way, and can even use any previous aliased tables in the next query in the WITH clause.

WITH alias AS (<QUERY>),

alias2 AS (<QUERY>)

SELECT
	<COLUMNS>
FROM
	<TABLES>
WHERE
	<CONDITION>;

From a database point of view, sometimes it will store the result of a WITH statement as a temporary table, and sometimes it will just run the query when it 
is used within another query. 
*/
WITH km_table as 
(
	SELECT
		a.*,
		distance * 1.60934 AS distance_km
	FROM
		schema_name.flights a
)

SELECT
	*
FROM
	 km_table
WHERE
	distance_km > 1000
UNION
SELECT
	*
FROM
	 km_table
WHERE
	distance_km < 1000;

/* You can now attempt questions 24-26 */

/*
The final way we can use the output of our queries is to store the resulting table permanently(ish) in a table within your schema. To do this
we use a CREATE TABLE statement. Whilst it is possible to create an empty table by specifying the variables and their type we will not cover 
that in this course. Instead, we will just cover how to create a table from a SELECT statement.

CREATE TABLE <TABLE> NOLOGGING AS
<QUERY>;

The NOLOGGING keyword just removed logs of this creation from the database to slightly improve speed.
*/
CREATE TABLE flights_km NOLOGGING AS
SELECT
	a.*,
	 * 1.60934 AS distance_km
FROM
	schema_name.flights a;

SELECT
	*
FROM 
	flights_km; -- notice the lack of a schema name as this was created in your own schema

/* 
Once we are done with the table we want to remove it so we could reuse the name and free up space in the database. We do this using a 
DROP TABLE statement.

DROP TABLE <TABLE> PURGE;

Where PURGE is a keyword to remove it from the recycling bin immediately.
*/
DROP TABLE flights_km PURGE;

SELECT
	*
FROM 
	flights_km; -- the table no longer exist.

/* You can now attempt question 27 */

/*
There are also ways to empty a table using the TRUNCATE TABLE statement, add new records to a table using the INSERT statement, remove
specific records using a DELETE statement, or change some values of existing records using an UPDATE statement. However these are not 
covered in this course but if you find yourself regularly dropping and recreating the same table with new/similar data then I recommend
looking into these as a TRUNCATE and INSERT is often quicker and better for the database than a DROP and CREATE.

Finally we come to the main feature of relational databases, joins! Joins allow us to return and use variables from multiple tables
within the same query. They are written in the following way

SELECT
	<COLUMNS>
FROM
	<TABLE1> 
	<JOIN_TYPE> JOIN <TABLE2>
	ON <CONDITION>;

There are 4 main types of joins:
INNER JOIN - Only return records where they exist in both tables 
LEFT/RIGHT JOIN - Return all records in the left/right table and any match in the right/left one if it exists
FULL OUTER JOIN - Return all records in both tables and any match if it exists
CROSS JOIN - Return all combinations of rows across both tables (the Cartesian product of the rows). Not often useful.

Note that the CROSS JOIN does not have an ON condition. Sometimes it is possible to choose to have a condition in either
the join statement or the where statement. Both are equally fine and the database will optimise for what is best. 

Let's look at a few examples, but first let's create a smaller version of the PLANES table to help illustrate the different types
*/
CREATE TABLE planes_short NOLOGGING AS
SELECT
	* 
FROM 
	schema_name.planes
WHERE
	tailnum = 'N108UW';

-- Only return rows where data is in both tables
-- Notice that because we have returned all columns from both tables, the join column is returned twice despite being the exact same
SELECT 
	a.*,
	b.*
FROM 
	schema_name.flights a
	INNER JOIN schema_name.planes_short b
	ON a.tailnum = b.tailnum; -- In this case the columns had the same names, but that won't always (in fact will rarely) be the case


-- Return all rows in the left table, matching where exists in right table
SELECT 
	a.*,
	b.*
FROM 
	schema_name.flights a
	LEFT JOIN schema_name.planes_short b
	ON a.tailnum = b.tailnum;

-- Return all rows in the right table, matching where exists in right table
-- Notice that in this case despite planes_short only having 1 row, this returns multiple rows because there are multiple matches
SELECT 
	a.*,
	b.*
FROM 
	schema_name.flights a
	RIGHT JOIN schema_name.planes_short b
	ON a.tailnum = b.tailnum;

-- Return all rows in either table whether they match or not
-- To illustrate this we use a dummy table with a non-existent tail number
SELECT 
	a.*,
	b.*
FROM 
	schema_name.flights a
	FULL OUTER JOIN (SELECT 'FAKETAIL' AS tailnum FROM dual) b
	ON a.tailnum = b.tailnum
ORDER BY b.tailnum; -- Defaults to nulls last for ascending.

-- Returns all possible combinations of rows
-- We create some small tables using UNION and dual to illustrate this. Each has 3 rows so we return 9 rows (3x3)
SELECT
	*
FROM 
	(SELECT '1' AS NUM FROM DUAL
		UNION
	SELECT '2' AS NUM FROM DUAL
		UNION
	SELECT '3' AS NUM FROM DUAL) A
CROSS JOIN
	(SELECT 'A' AS LET FROM DUAL
		UNION
	SELECT 'B' AS LET FROM DUAL
		UNION
	SELECT 'C' AS LET FROM DUAL) B;

-- Remove our table as we no longer need it.
DROP TABLE planes_short PURGE;


/* That is the end of our section on tables. We've covered the dummy table which we've seen some uses for already. We covered
3 methods to use the output of a query in another query; by nesting, using WITH statements, and creating a permanent table in our schema.
Finally we saw how to join multiple tables together and all the different types that we could use in this join and the types of rows they return. 

Next we'll learn how to aggregate the data within our data by grouping our data by specific variables and then summarising the data for each group
using a multitude of functions. 

Finally, here are some common mistakes you might make while using what you have learnt, check the error messages 
and understand the cause and how to fix it: */

--TODO: Add Error examples
-- not sure which table referencing
-- didn't alias table
-- table already exists
-- table doesn't exist

---------------------------------------------------------------------------------------------------
/* Part 4: Aggregation - Grouping and window functions

The final section of learning will focus on the aggregation of data i.e. information about multiple records of our data. This information
might be the count of records, the max, min, mean, sum etc. We will first look at it via summaries of specific groups of data, and then 
aggregated information that is not summarised. 

We'll start with group summaries, these have the output form where each unique grouping of variable values is one row, with its summary
information as new variables. This is the same type of output format you'll get from using a PivotTable in Excel.

To tell the database which variables identify our groups, we use a GROUP BY clause. This clause is written
and executed after the WHERE clause, but before the ORDER BY.

SELECT
	<GROUP COLUMNS>,
	<SUMMARY COLUMNS>
FROM
	<TABLES>
WHERE
	<CONDITION>
GROUP BY 
	<GROUP COLUMNS>
ORDER BY 
	<COLUMNS>;

Any non-summarised variable MUST appear in the GROUP BY clause, but the inverse is not true; you can group by a variable you don't return in the output,
however this is likely to be very confusing so is not recommended. There are many aggregating functions but the most common are:

COUNT(*) 		- The total number of records per group
COUNT(<COLUMN>)	- The total number of records that are non-null in that variable
SUM(<COLUMN>)	- The sum of that variable, must be numeric
AVG(<COLUMN>)	- The mean of that variable, must be numeric
MAX(<COLUMN>)	- The maximum of that variable
MIN(<COLUMN>)	- The minimum of that variable

MAX and MIN don't have to be numeric but can lead to unexpected behaviour if you are not aware of how text is ordered. 

*/
--Summary information of flights out of each NYC airport
SELECT
	origin,
	COUNT(*) AS num_flights,
	COUNT(dep_time) as num_departed_flights, -- doesn't count records with a null departure time
	SUM(air_time) AS total_airtime,
	AVG(air_time) AS mean_airtime,
	MAX(dep_delay) AS latest_dep,
	MIN(dep_delay) AS earliest_dep
FROM 
	schema_name.flights
GROUP BY 
	origin;

--Summary information of flights out of each NYC airport to each destination airport
SELECT
	origin,
	dest,
	COUNT(*) AS num_flights,
	COUNT(dep_time) as num_departed_flights,
	SUM(air_time) AS total_airtime,
	AVG(air_time) AS mean_airtime,
	MAX(dep_delay) AS latest_dep,
	MIN(dep_delay) AS earliest_dep
FROM 
	schema_name.flights
GROUP BY 
	origin,
	dest;

/* Note that we don't have to provide a GROUP BY clause when we are aggregating the whole table */
SELECT 
	COUNT(*) AS num_flights,
	MAX(dep_delay) AS latest_dep,
	MIN(dep_delay) AS earliest_dep
FROM
	schema_name.flights;

/* Finally, it is possible to combine CASE statements and aggregate functions to convert text flags into numeric values like so */
SELECT 
	origin,
	SUM(
		CASE WHEN dep_delay = 0 AND arr_delay = 0 THEN 1 ELSE 0 END -- SUM uses 1 and 0 as the values
		) AS perfect_flights,
	COUNT(
		CASE WHEN dep_delay = 0 AND arr_delay = 0 THEN 1 ELSE null END -- COUNT uses anything and null as the values
		) AS perfect_flights2 
FROM
	schema_name.flights
GROUP BY
	origin;


/*
Sometimes we may not want to summarise the data, but still return and use aggregated information, such as adding a row number
per group to identify the nth flight per carrier per day, or the average departure delay so we can filter records to only return
those that have above average delays. 

To do this we use what are known as window functions, and they usually have the following form:

<WINDOW FUNCTION>(<COLUMN>) OVER (PARTITION BY <COLUMNS> ORDER BY <COLUMNS>)

The function takes the column to act on, and the columns that follow PARITION BY define the group to aggregate the data by,
the same as using a GROUP BY. If no PARTITION BY is specified then all records are used, again the same as a GROUP BY. ORDER BY is
used in certain functions to define the order to use when calculating the information, many functions do not need it but we will see
at least one example. 

Many of the functions  are the same as the GROUP BY functions e.g COUNT(<COLUMN>), AVG(COLUMN) etc, but there are two/three 
additional functions that are often useful

ROW_NUMBER() OVER (PARTITION BY <COLUMNS> ORDER BY <COLUMNS>)
RANK(<COLUMN>) OVER (PARTITION BY <COLUMNS> ORDER BY <COLUMNS>)
DENSE_RANK(<COLUMN>) OVER (PARTITION BY <COLUMNS> ORDER BY <COLUMNS>)

ROW_NUMBER returns a column that is, unsurprisingly, the row number starting at 1 and increasing based on the ORDER BY provided. 
RANK returns a column that is the rank of the provided column, and will return the same value for ties.
DENSE_RANK returns a column that is the rank of the provided column, and will return the same value for ties, but will not skip values when there are ties.
*/


/*Add which flight of the day it was for a given carrier, how many there are on that day, and the average departure delay */
SELECT
	a.*,
	ROW_NUMBER() OVER (PARTITION BY year, month, day, carrier ORDER BY sched_dep_time) AS day_carrier_flight,
	COUNT(*) OVER (PARTITION BY year, month, day, carrier) AS day_carrier_flight_total,
	AVG(dep_delay) OVER (PARTITION BY year, month, day, carrier) AS day_carrier_avg_dep_delay
FROM
	schema_name.flights;

/* Note that again we can't use these columns in a WHERE clause as they are created within the SELECT clause.
There are more window functions available in Oracle SQL that will not be covered here, but could be useful if needed including
ones to tell you what percentile of a groups value that record is in, the first value, the last value etc. */

/* 
That concludes the section on aggregation; you learnt how to summarise data by groups in a PivotTable type output, 
and how to add aggregated information as a new column while keeping all original records. You now know the vast majority
of what you need to know in Oracle SQL to write most queries you will ever write. There are a lot more irregularly used and specific
quirks, functions, keywords etc that you may encounter as you solve more and more problems using SQL, but for most work this is more
than enough.

The final section covers an example of the kind of steps you might take and queries you might write to answer a 
seemingly simple data science question.

Finally, here are some examples of common errors you might encounter with these types of queries:*/

--TODO: add error queries
--  not a group by expression
-- forgetting a partition/order by 

---------------------------------------------------------------------------------------------------
/* Part 5: Worked Example - Putting it all together

This final section examines the process you might take to answer what might be asked a simple question. We'll
work through some pre-checks that are worth doing on your data, and then the steps to building a query that 
provides the data to answer the question. In reality you would likely build the main query a single query,
but here I keep them separate for demonstration. It is also important to point out that this is just one way
to answer a question, and just one way to write a query to return this data. There may be other solutions that
are just as good.

The question we will answer is this - Does precipitation make a plane more likely to be delayed departing, and 
are specific airports worse than others at dealing with rain?

We'll need to start by checking for any missing data and removing any incomplete data. Then we'll need to bring 
in the weather data for each flight and have replaced the precipitation column with a decile value instead (which 10% of 
precipitation is it in). Finally, we'll summarise the departure delay information by precip decile and then 
bring in airport names for each of reading.
*/

-- Check if we have any missing departure delay data
SELECT 
	*
FROM 
	schema_name.flights
WHERE
	dep_delay IS NULL;

/* We do have missing data. This could mean that the flight was cancelled, or that it wasn't but we don't have data for it. 
In reality we might ask the data owner what this meant, as we cannot assume what it is and one is a very different meaning than
the other. For now we will exclude this from our data going forward. */

-- Next let's check if we have any time periods with no precip data 
SELECT 
	* 
FROM 
	schema_name.weather
WHERE 
	precip IS NULL;

/* No missing data that's good. */

-- Next let's check if we have any time period for flights where we are missing weather data
SELECT 
	* 
FROM 
	schema_name.flights fli
	LEFT JOIN schema_name.weather weath
	ON fli.time_hour = weath.time_hour AND fli.origin = weath.origin
WHERE 
	weath.origin IS NULL;

/* We are missing some data so we will want to make sure to use an inner join to avoid including any flights we don't have weather
data for. However this combined with the flights that we don't have departure info for should be extracted and provided as a caveat 
with the answer to the question */
CREATE TABLE missing_flight_info NOLOGGING AS
SELECT 
	year,
	month,
	day,
	flight
FROM 
	schema_name.flights
WHERE
	dep_delay IS NULL
UNION
SELECT 
	fli.year,
	fli.month,
	fli.day,
	fli.flight
FROM 
	schema_name.flights fli
	LEFT JOIN schema_name.weather weath
	ON fli.time_hour = weath.time_hour AND fli.origin = weath.origin
WHERE 
	weath.origin IS NULL;

/* Now we have recorded the flights we are going to exclude from the data, we can start to actually answer the question. First let
us create our decile column in the weather data. You could make a case for this being created per ORIGIN however if we want to compare
which airport handles rain better on a purely volume measure, then the deciles should be consistent across all airports.

To create our decile we could find the maximum precip value, divide that records precip value by it, times by 10 and round down up to 
a whole number. We would need to Google how to round up, but doing so tells us that the function is CEIL. To get the maximum of a column
and use it per record we'd want to use a window function. */

-- Add precipitation decile variable
SELECT 
	*,
	CEIL(
		(precip/(MAX(precip) OVER () )*10 -- no partition needed as we want to use the whole data
		) AS precip_decile
FROM 
	schema_name.weather;

/* This is a little messy and feels like there should be a better way to do this. Google searching "how to calculate decile Oracle SQL" returns
pages relating to the NTILE window function. After looking at a few examples online hopefully we understand it enough to apply it to our work so 
the above query becomes */

-- Add precipitation decile variable version 2
SELECT 
	*,
	NTILE(10) OVER (ORDER BY precip ASC) as precip_decile
FROM 
	schema_name.weather;

/* Next we'll want to join this onto our flights table. At this point it's a good idea to think about what columns we actually want 
from the weather table as our output table is going to start getting quite wide otherwise. In an ideal world you would think about this to start
with and remove any unnecessary columns right from the start, but in reality it is often the case that you use * until a point where it becomes
too much to look at and only then do you select the variables you actually need/want to keep.

In this case we only really need the time_hour variable for our join, the origin variable also for our join, and our new precip_decile variable */

--Only select the columns we need
SELECT 
	time_hour,
	origin,
	NTILE(10) OVER (ORDER BY precip ASC) AS precip_decile
FROM 
	schema_name.weather;

/* We now have the choice to join this as a nested query, create it as a table, or use a WITH clause. As we are unlikely to need this table 
long-term then creating a table seems a little excessive, and the choice between the other two is mostly personal preference (as we are not
going to need to use the table multiple times in the same query). I choose to use WITH as I find it helps keep the query looking neat */

WITH new_weather AS (
	SELECT 
		time_hour,
		origin,
		NTILE(10) OVER (ORDER BY precip ASC) AS precip_decile
	FROM 
		schema_name.weather
)

SELECT
	*
FROM 
	schema_name.flights fli
	INNER JOIN new_weather weath
	ON fli.time_hour = weath.time_hour AND fli.origin = weath.origin
WHERE
	dep_delay IS NOT NULL;  -- remember to remove records without a dep delay value

/* Now we have our combined data we need to group our data together so that we can get the average departure delay. We could do this in 
a few different ways; for example do we want to look at the mean or the median as our measure for average? Do we just want to look at 
delayed flights or should be include early departures as well? Finally, should we include the standard deviation (a measure of spread)
in our results. 

Let's return the mean, median, and standard deviation. We'll also exclude flights that departed early (but include those on time) but 
this is something that should be clarified with the person asking the question, and is easy enough to change later (just remove the condition
in the WHERE clause). */

WITH new_weather AS (
	SELECT 
		time_hour,
		origin,
		NTILE(10) OVER (ORDER BY precip ASC) AS precip_decile
	FROM 
		schema_name.weather
)

SELECT
	origin, 
	precip_decile,
	AVG(dep_delay) AS mean_dep_delay,
	MEDIAN(dep_delay) AS median_dep_delay,
	STDDEV(dep_delay) AS std_dep_delay,
	COUNT(*) AS volume -- good idea to always include counts as people will ask about the volume of data used.
FROM 
	schema_name.flights fli
	INNER JOIN new_weather weath
	ON fli.time_hour = weath.time_hour AND fli.origin = weath.origin
WHERE
	fli.dep_delay >=0 -- automatically removes the nulls when applying a numeric or equals filter
GROUP BY 
	origin,
	precip_decile
;

/* Finally, let's use the AIRPORTS table to make the output a little bit nicer to read with the full airport names. 
As I know that the output of the previous query is only 30 rows, and that the flights table contains hundreds of thousands of rows, 
I am going to do the join by nesting this query - the database should optimise it but just to force it to do the join after 
doing the grouping of the data first. */


WITH new_weather AS (
	SELECT 
		time_hour,
		origin,
		NTILE(10) OVER (ORDER BY precip ASC) as precip_decile
	FROM 
		schema_name.weather
)

SELECT 
	b.name,
	a.*
FROM
	(SELECT
		origin, 
		precip_decile,
		AVG(dep_delay) AS mean_dep_delay,
		MEDIAN(dep_delay) AS median_dep_delay,
		STDDEV(dep_delay) AS std_dep_delay,
		COUNT(*) AS volume 
	FROM 
		schema_name.flights fli
		INNER JOIN new_weather weath
		ON fli.time_hour = weath.time_hour AND fli.origin = weath.origin
	WHERE
		fli.dep_delay >=0 -- automatically removes the nulls when applying a numeric or equals filter
	GROUP BY 
		origin,
		precip_decile
	) a
	LEFT JOIN schema_name.airports b
	ON a.origin = b.name
;

/* The last things to do are to optionally order the output for ease of viewing, and save the output as a table. The order of
this depends on what part of the question we want to answer; do higher deciles have a higher delay answers the first part of the
question so we would want to order by decile (and in fact may want to have no grouped by origin at all, again this is easy to remove
and create another table but for simplicity I'll leave it for now). For the second part, which airport deals with rain better we may want to 
order by the airport to see how they each trend with heavier rainfall. In the end it doesn't really matter as there are relatively few rows 
so sorting will be quick in the future, and there isn't really a need to order the data in the output at all until you present it to someone. */

CREATE TABLE delay_precip_decile NOLOGGING AS 
WITH new_weather AS (
	SELECT 
		time_hour,
		origin,
		NTILE(10) OVER (ORDER BY precip ASC) AS precip_decile
	FROM 
		schema_name.weather
)

SELECT 
	b.name,
	a.*
FROM
	(SELECT
		origin, 
		precip_decile,
		AVG(dep_delay) AS mean_dep_delay,
		MEDIAN(dep_delay) AS median_dep_delay,
		STDDEV(dep_delay) AS std_dep_delay,
		COUNT(*) AS volume
	FROM 
		schema_name.flights fli
		INNER JOIN new_weather weath
		ON fli.time_hour = weath.time_hour AND fli.origin = weath.origin
	WHERE
		fli.dep_delay >=0 -- automatically removes the nulls when applying a numeric or equals filter
	GROUP BY 
		origin,
		precip_decile
	) a
	LEFT JOIN schema_name.airports b
	ON a.origin = b.name
ORDER BY 
	precip_decile, 
	origin 
;

/* Now we have this table we can answer the question ... TODO - answer the question 

We can also work much quicker on the data now, we can look at just the first and tenth decile, we could look at just one airport etc.
But we have lost information as well, we have no way to know what the range of each decile is, we can't identify the type of plane,
or the time of year for the flights any more. We have no way, from this table, to repeat the analysis ignoring which airport they came from.
In creating this output we have removed many variables from our data and combined many records. It's always important to think about what information
is relevant, and what can safely be ignored. 

It is also important that we save this query, if someone asks us in a month to reproduce the analysis on 2014's data we would have to write
the whole script over again, and we might not remember what we did with the missing values, or if we included early departures or not. .SQL files are 
tiny, so the rule is "There is no such thing as a one off script". Save every script you use, and where sensible include it with any analysis you output;
comment your code so not just others but also future you can understand not only what the code does but why it does it, and finally try to name your 
tables and files something clear and sensible, the more descriptive the better. 

That was an example of how we might develop a script to answer a question. In the end we used 3 different tables, have 2 output tables,
had to look up a new function, mixed nesting and WITH clauses, and much more for what seemed like a simple question!
There's also a lot we didn't use. There was no date filtering, no LIKE conditions etc. 
It is rare you'll need to use everything you've learnt in one query, but you could need anything you've learnt in any query. 

Of course the work is not done, most people won't be very happy with a small table as an answer to a question. We might want to export this to an Excel 
file for easier consumption, we might want to create slides/a report based on our findings, we may wish to produce graphs in Excel or something like R, but 
the important thing is that the heavy lifting of the data cleaning and crunching was done in the database - a system designed to do those things.

This concludes the learning for this training. There is one final exercise similar to the above example where there is a question you are given and you 
are expected to come out with an answer, or at least the data to help support an answer. There are hints if needed and as always an example solution provided,
but much like here we had to make some choices, you will have to there as well and there is no right answer so long as you can justify your reasoning. 

If you have any comments or feedback about the scripts for the course please get in touch.
*/