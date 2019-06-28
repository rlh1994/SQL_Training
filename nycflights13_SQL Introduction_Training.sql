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


*/
-- dual
-- Nesting
-- with
-- create
-- join


---------------------------------------------------------------------------------------------------
/* Part 4: Aggregation - Grouping and window functions
-- group by
-- windows function (row number and one other example)
*/

---------------------------------------------------------------------------------------------------
/* Part 5: Worked Example - Putting it all together

*/