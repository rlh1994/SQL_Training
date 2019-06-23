/* Part 0: Comments, syntax, and error messages

A comment is the most important thing in any language and script; for all the complex code and 
fancy solutions, with comments then code will only be useful for a day before you forget how
it works. A comment is any text that will be ignored when the script is run, so is used to 
describe what a script, or part of a script does, how it does it, and what it returns.

A comment in SQL is acheived in one of two ways. A multi-line or in-line comment is achieved by 
placing the comment like this one, between the first symbol /* and * / (without the space). To 
comment an entire single line, you place --at the start of the comment, anything on that line after 
that symbol is treated as a comment.

Keywords in SQL are case insensitve, so the follow scripts, which will be explained shortly, are equivalent.
Table and variable (column) names, are also case insenitive, unless they were created specifically to not be,
which is rare but we will see an example of later in the session.
Strings in SQL are case sensitive, and we will see the importance of this later.

Whitespace in SQL is also not important (other than for readability), so tabs, new lines, extra spaces etc
do not change the result of a query.

For this course we will try to keep a consistent style guide of lowercase for field names, uppercase for
functions/keywords, and favour more whitespace than less. There are many varients on this style guide,
and I suggest you find you can work with and try to stick to it. Operators and code will be optimised
for Oracle SQL and readability/teachability, not ANSI SQL or ISO standards e.g. we'll use != instead of <>.
*/

-- Three equivelant queries despite case and whitespace
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
mispelling a table or variable name, trying to access a table you don't have access to, missing a keyword,
having an extra or missing comma, etc. As you practise with the exercises you will see these error messages,
learn how to read them (given that it tells you the rough location of the error), what they mean, and
how to fix them. If in doubt, or you get a new error message you don't understand, then search for the error
code and message online (avoid Oracle documentation where you can) and see if you can find a solution. Learning
how to use error messages is as important as knowing how to write the code in the first place.

Missing values i.e. no data for a variable for a given record has a special type in SQL, it is null. null is not
a string, or NA, but a specific type of null. You cannot have a record where all variables are null.
*/

-- TODO: Add some error examples.

---------------------------------------------------------------------------------------------------
/* Part 1: Variables - Selecting and creating them with functions

The structure of a basic query is:
SELECT
	<COLUMNS>
FROM
	<DATABASE>.<SCHEMA>.<TABLE>;

SELECT and FROM are SQL keywords and form the basis for every query. 
<DATABASE> is the database you are querying if you have mutliple connections. By default is the current connection.
	We will not use this option at all in our code.
<COLUMNS> is a comma seperated list of columns, either already in the table or new columns created using functions
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


/* You don't actually have to use the AS keyword, it can be implicit but is good practise to use it */
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
	123 new_column
FROM
	schema_name.flights;


/* I mentioned that you can, but shouldn't, use spaces or lowercase in column/table names. You do this by using 
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


/* We can use current columns to create new colums */
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


/* We CAN'T use this new column name in another column calculation, we'll see how to do it propely later */
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
	<CONDITION> is a boolean statement that evalues to TRUE or FALSE
	<VALUE> is the value that variable will take for a record satisfying the condition. They must all be the same 
		type, although Oracle may convert some automatically to match e.g. a number to a string
	ELSE <VALUE> is what is used when none of the conditions evaluate to TRUE.
	The first <CONDITION> that evalutates to TRUE for a given CASE statement is the <VALUE> returned, it will not check
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
	END AS dest_nyc_check_in
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
		WHEN dest in ('JFK', 'LGA', 'EWR') THEN 'NYC'
		ELSE 'Other'
	END AS dest_nyc_check1,
	CASE
		WHEN lower(dest) in ('JFK', 'LGA', 'EWR') THEN 'NYC'
		ELSE 'Other'
	END AS dest_nyc_check2,
	CASE
		WHEN dest in ('JFK', 'lga', 'ewr') THEN 'NYC'
		ELSE 'Other'
	END AS dest_nyc_check3,

FROM
	schema_name.flights;


/* Finally, for no reason other than to illistrate the example, let's see if the tail number of the plane contains certain characters */
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
		WHEN tail_num LIKE '%7%' THEN 1 -- Any number of character (including 0) before, and after a 7
		ELSE 0
	END AS contains_7,
	CASE 
		WHEN tail_num LIKE '%Q'	THEN 1 -- Any number of characters before a capital Q
		ELSE 0
	END AS ends_in_q,
	CASE 
		WHEN NOT (tail_num LIKE '%Q') THEN 1 -- A NOT acting on the ouput of a logical statement
		ELSE 0
	END AS ends_in_q,
	CASE WHEN tail_num NOT LIKE 'N5_5%' THEN 1 -- A NOT LIKE, speficially any record that doesn't match the pattern, slightly different to above
		ELSE 0
	END AS weird_test

FROM
	schema_name.flights;


-- to_char
-- trunc
-- dates in general

*/

---------------------------------------------------------------------------------------------------
/* Part 2: Records - Filtering and ordering
-- where
-- order by
-- distinct
-- union types
-- fetch
*/

---------------------------------------------------------------------------------------------------
/* Part 3: Tables - Reusing and joining
-- dual
-- Nesting
-- with
-- create
-- join
*/

---------------------------------------------------------------------------------------------------
/* Part 4: Aggregation - Grouping and window functions
-- group by
-- windows function (row number and one other example)
*/

---------------------------------------------------------------------------------------------------
/* Part 5: Worked Exampe - Putting it all together

*/