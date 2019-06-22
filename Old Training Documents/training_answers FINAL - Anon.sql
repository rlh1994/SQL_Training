--------------------------------------------------------
--  File created - Wednesday-February-27-2019   
--  All data is randomly generated. Any resemblance to actual persons, living or dead, or actual events is purely coincidental.
-- 	Data created by Ryan Hill (rlh1994) for use in an Oracle SQL Training session. 
--------------------------------------------------------

--This is how you write a comment, comments are lines that don't do anything when you run the script
/*
You can do a 
multi line comment like this
*/

-- This is how you view the entirety of a table

SELECT * FROM SCHEMA_NAME.MV_CUSTOMERS;

--You end each query with a semi colon, this tells the computer when one command stops

--The layout really doesn't matter (although there are preferred style guides/you will get a personal preference)
SELECT 
* 
FROM
SCHEMA_NAME.MV_CUSTOMERS;

-- * means everything, if we just want certain columns we have to specifiy them
SELECT 
	FIRST_NAME, 
	ADDRESS, 
	START_DATE 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS;

--This is how you filter to search for specific things 

SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    LAST_NAME = 'Rathmell';

--String matching is case sensitive 
SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    LAST_NAME = 'RaThmEll';

--You can always use UPPER/LOWER to alter text to make the match easier
SELECT 
    LAST_NAME, 
    LOWER(LAST_NAME) 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    LOWER(LAST_NAME) = 'rathmell'
--You can also filter to anything within a list
SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    LAST_NAME IN ('Rathmell', 'Kennsley', 'Nyssens');

--You can also do filters on numbers, or dates
SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    PHONE_NUMBER >= 02084463462;

SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    START_DATE >= DATE '2017-12-01';

--You may see dates formatted like this however this is worse from a performance/speed level so please avoid doing it.
SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	START_DATE >= '01-DEC-2017';

--And finally you can check if something is null or not
SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	END_DATE IS NULL;

--You can combine where statements using AND/OR/NOT
SELECT 
    ACCOUNT_NUMBER, END_DATE 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    END_DATE IS NOT NULL OR ACCOUNT_NUMBER < 200;

--What about if you want to get values between a certain range?
SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    ACCOUNT_NUMBER >=100 
    AND ACCOUNT_NUMBER < 200;

SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
WHERE 
    ACCOUNT_NUMBER BETWEEN 100 AND 200;
--Between is the same as lower_value <= column <= upper_value
--This means when you do it for dates it includes anything with the upper date ONLY at midnight, nothing during that day.

--Next we'll learn order by terms - to get results in a certain order
--These take longer to run and should only be done at the end of a query (or in excel or R)
SELECT 
    * 
FROM 
    SCHEMA_NAME.MV_CUSTOMERS
ORDER BY 
    LAST_NAME;

--The default order is ascending, if you want to have it descending you have to specify this
SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
ORDER BY 
	PHONE_NUMBER DESC;

---------------Exercise 1-------------------------------
/*
Create queries that answer the below questions using the tools you have learnt so far
TIP: the order by is always the last line of a query
1) What is the earliest join date of a customer who is still with us?
2) What is the name of the customer who most recently closed their account?
3) What's the biggest phone number of the customer who has a bill due on 3rd april, with a monthly bill of £44.99
4) What's the name of the customer who joined in march 2017, pays the most, with the lowest account number
Hint: if you want to order by multiple columns put a comma between the column names (which one does it order by first?)
*/

SELECT 
	START_DATE 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	END_DATE IS NULL
ORDER BY 
	START_DATE ASC;

SELECT 
	FIRST_NAME, 
	LAST_NAME, 
	END_DATE 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	END_DATE IS NOT NULL
ORDER BY 
	END_DATE DESC;

SELECT 
	PHONE_NUMBER, 
	NEXT_BILL_DATE, 
	MONTHLY_BILL 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	NEXT_BILL_DATE = DATE '2018-04-03' 
	AND MONTHLY_BILL = 44.99
ORDER BY 
	PHONE_NUMBER DESC;

SELECT 
	FIRST_NAME, 
	LAST_NAME, 
	MONTHLY_BILL, 
	ACCOUNT_NUMBER 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	START_DATE >= DATE '2017-03-01' 
	AND START_DATE < DATE '2017-04-01'
ORDER BY 
	MONTHLY_BILL DESC, 
	ACCOUNT_NUMBER ASC;

-------------------------------------------------------

--You can search for sort of matching data by using a like statement 
SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	LAST_NAME LIKE 'An%';

--the % sign gives you any number of characters, of an type (upper/lower case, spaces, numbers etc)
SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	LAST_NAME LIKE '%na%';

SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	LAST_NAME LIKE '_ne__';
--The _ is a single character space only 
--You can do more fancy stuff with regular expressions but we will not cover that here

--There any many funcitons in SQL, some of which we will cover, one of them is the substr function
SELECT 
	SUBSTR(PHONE_NUMBER, 1, 4) 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS;

--Sometimes you might want to create a column based on other columns, for this you use a case when statement
SELECT 
	CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes' 
	END AS SLOW_CHECK
FROM 
	SCHEMA_NAME.MV_CUSTOMERS;
--The "AS SLOW_CHECK" aliases/nicknames that column to be called SLOW_CHECK, you can do this for any column

--The default if it doesn't match is to make it null, you can change this, and you can do multiple options in one go
SELECT 
	CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes'
		 WHEN PRODUCT = 'Bolt fast' THEN 'Rich people' 
	     ELSE 'Normal People' 
	END AS PEOPLE_STATUS
FROM 
	SCHEMA_NAME.MV_CUSTOMERS;

--If you want to select all columns and add another one, you have to also alias the table (you can't ask for all columns AND another one, what's infinity +1?)
--You also don't have to write the word AS to alias a column, but I tend to to make it easier to read.
SELECT 
	A.*, 
	CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes'
		 WHEN PRODUCT = 'Bolt fast' THEN 'Rich people' 
		 ELSE 'Normal People' 
	END PEOPLE_STATUS
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A;


--Note that you cannot use a named column you "create" in a select statement directly in a where statement
-------INCORRECT----------
SELECT 
	A.*, 
	CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes'
		 WHEN PRODUCT = 'Bolt fast' THEN 'Rich people' 
		 ELSE 'Normal People' 
	END as PEOPLE_STATUS
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A
WHERE 
	PEOPLE_STATUS = 'Rich people';

-- You have to either supply the full column definition (without the alias)
-------CORRECT----------
SELECT 
	A.*, 
	CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes'
		 WHEN PRODUCT = 'Bolt fast' THEN 'Rich people' 
		 ELSE 'Normal People' 
	END as PEOPLE_STATUS
FROM SCHEMA_NAME.MV_CUSTOMERS A
WHERE 
	CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes'
		WHEN PRODUCT = 'Bolt fast' THEN 'Rich people' 
		ELSE 'Normal People' 
	END = 'Rich people'
;

--OR *nest* the query
--The key to nested queires is that every query returns a table, so you can query THAT table 
SELECT 
	B.*
FROM
	(SELECT 
		A.*, 
		CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes'
			 WHEN PRODUCT = 'Bolt fast' THEN 'Rich people' 
			 ELSE 'Normal People' 
		END as PEOPLE_STATUS
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A) B
WHERE 
	B.PEOPLE_STATUS = 'Rich people';



--If you want to remove duplicate rows from the data you can run a distinct query (this is distinct rows over all columns)
SELECT 
	DISTINCT PRODUCT
FROM 
	SCHEMA_NAME.MV_CUSTOMERS;



---------------Exercise 2-------------------------------
/*
Create queries that answer the below questions using the tools you have learnt so far
1) What are the area codes that we serve (the first 4 digits of the phone number)
2) Create a column that has the name of the area for each area code using
https://www.thephonebook.bt.com/area/
Note: some area codes are 5 or 3 digits long. For 5 use the first one. Also 03 numbers don't have an area so make it up!
3) Using this new column, how many customers in Lampeter have bolt fast broadband? Who joined first and who's bill is due next? (do this separately)
Hint: you have to put the case statement in the where if you want to use it (and not alias it)
4) Using the table SCHEMA_NAME.MV_AVAIL, how many houses that start with the number 1 have pretty fast broadband available?
*/


SELECT 
	DISTINCT SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS;

SELECT 
	A.*, 
	CASE WHEN PHONE_NUMBER like '0157%' THEN 'LAMPETER'
        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0132 THEN 'FORT AUGUSTUS'
        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0208 THEN 'LONDON'
        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0386 THEN 'MADEUP LAND'
    END AS AREA
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A;

SELECT 
	A.*
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A
WHERE 
	CASE WHEN PHONE_NUMBER like '0157%' THEN 'LAMPETER'
        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0132 THEN 'FORT AUGUSTUS'
        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0208 THEN 'LONDON'
        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0386 THEN 'MADEUP LAND'
    END = 'LAMPETER' 
    AND UPPER(PRODUCT) = 'BOLT FAST'
ORDER BY 
	START_DATE;

	--ALTERATIVELY
	SELECT 
		* 
	FROM
		(SELECT 
			A.*, 
			CASE WHEN PHONE_NUMBER like '0157%' THEN 'LAMPETER'
		        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0132 THEN 'FORT AUGUSTUS'
		        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0208 THEN 'LONDON'
		        WHEN SUBSTR(PHONE_NUMBER, 1, 4) = 0386 THEN 'MADEUP LAND'
		    END AS AREA
		FROM 
			SCHEMA_NAME.MV_CUSTOMERS A) B
	WHERE 
		AREA = 'LAMPETER' 
		AND UPPER(PRODUCT) = 'BOLT FAST'
	ORDER BY 
		START_DATE;


SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_AVAIL
WHERE 
	SUBSTR(ADDRESS, 1, 1) = '1' 
	AND PRETTY_FAST_AVAIL = 'Y';


----------------------------------------------------------------------------------
--Some bonus stuff--

--DATE MANIPULATION AND SYSDATE
SELECT 
	SYSDATE, 
	TRUNC(SYSDATE),
	TRUNC(SYSDATE) + +7/24 + 15/60/24,
	TRUNC(SYSDATE) + +7.25/24,
	TO_CHAR(SYSDATE, 'dd-mon'), 
	TO_CHAR(SYSDATE, 'HH24:MI') 
FROM 
	MV_CUSTOMERS;

--A 1X1 DUMMY TABLE
SELECT 
	* 
FROM 
	DUAL;

--COMBINE EXCLUDING DUPLICATES
SELECT 
	* 
FROM 
	MV_PRODUCTS
UNION
SELECT 
	* 
FROM 
	MV_PRODUCTS;

--COMBINE INCLUDING DUPLICATES
SELECT 
	* 
FROM 
	MV_PRODUCTS
UNION ALL
SELECT 
	* 
FROM 
	MV_PRODUCTS;

--RETURNING A SPECIFIED NUMBER OF ROWS
SELECT 
	* 
FROM 
	MV_PRODUCTS 
WHERE 
	UP_SPEED > 10
ORDER BY 
	UP_SPEED DESC
FETCH NEXT 3 ROWS ONLY;

SELECT 
	* 
FROM 
	MV_PRODUCTS 
WHERE 
	UP_SPEED > 10
ORDER BY 
	UP_SPEED DESC
OFFSET 1 ROWS FETCH NEXT 3 ROWS ONLY;


--Another (pointless) nested query example
SELECT 
	* 
FROM 
	(
	SELECT 
		A.*, 
		CASE WHEN PRODUCT = 'Kinda Fast' THEN 'Slowpokes'
			WHEN PRODUCT = 'Bolt fast' THEN 'Rich people' ELSE 'Normal People' 
		END AS PEOPLE_STATUS,
		START_DATE + 15 AS ALTERED_START
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A 
	)
WHERE 
	PEOPLE_STATUS = 'Normal People' 
	AND ALTERED_START > DATE '2018-01-01' -15;

--------------


--Nested queries are really useful when you have group bys, let's build them bit by bit

--Let's get summarised information about customers in a given area code
--create an area code column
SELECT 
	A.*, 
	SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A; 

--group the data by area code using a nested query. Note that each area code is returned only once.
SELECT 
	AREA_CODE
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE;

--any non-summary column in the select MUST be in the group by
--INCORRECT
SELECT 
	AREA_CODE, 
	MONTHLY_BILL
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE;

--CORRECT
SELECT 
	AREA_CODE,
	MONTHLY_BILL
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE,
	MONTHLY_BILL;


--Whilst you don't NEED to have everything in your group by in the select, it is best practise as otherwise it can be confusing
--e.g. what are these groups? You can't tell
SELECT 
	AREA_CODE
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE, 
	MONTHLY_BILL;

--Next let's add some summary information
SELECT 
	AREA_CODE, 
	COUNT(*), 
	MAX(PHONE_NUMBER), 
	MIN(PHONE_NUMBER), 
	AVG(MONTHLY_BILL), 
	STDDEV(MONTHLY_BILL)
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE;

--The average montly bill column has too many decimal places, and it would be nice to have a £ in it so
-- we use the round function, and the || operator which means concatinate (stick strings together)
SELECT 
	AREA_CODE, 
	COUNT(*), 
	MAX(PHONE_NUMBER), 
	MIN(PHONE_NUMBER), 
	AVG(MONTHLY_BILL), 
	STDDEV(MONTHLY_BILL),
	'£' || ROUND(AVG(MONTHLY_BILL), 2) AS AVG_MONTLHY_BILL
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE;


--Still not quite right so let's convert the number to a character with a specified number of pre+post decimal place digits.
SELECT 
	AREA_CODE, 
	COUNT(*), 
	MAX(PHONE_NUMBER), 
	MIN(PHONE_NUMBER), 
	AVG(MONTHLY_BILL), 
	STDDEV(MONTHLY_BILL),
	'£' || ROUND(AVG(MONTHLY_BILL), 2) AS AVG_MONTLHY_BILL,
	'£' || TO_CHAR(ROUND(AVG(MONTHLY_BILL), 2), '99.99') AS AVG_MONTLHY_BILL2
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE;


-- Everything that was introduced
/*
count(*) gives the total number of rows in that group, you can do count (distinct column_name) that gives just distinct values in that column in that group
max(column_name) returns the maximum value
min(column_name) returns the minimum value
avg(column_name) returns the mathematical average (ignores nulls)
stddev(column_name) returns the standard deviation
|| is the concatinate operator, it combined strings (and numbers etc) into a single string 
round(value, decimal places) rounds the value to the desired number of decimal places
to_char(value, format) converts the value to a character string in the format given
group by column_name groups the rows by that column name and allows count, max etc to be calculated
*/

--Let's look at this grouped by multiple columns
SELECT 
	AREA_CODE, 
	PRODUCT, 
	COUNT(*), 
	MAX(PHONE_NUMBER), 
	MIN(PHONE_NUMBER), 
	AVG(MONTHLY_BILL), 
	STDDEV(MONTHLY_BILL),
	'£' || ROUND(AVG(MONTHLY_BILL), 2) AS AVG_MONTLHY_BILL,
	'£' || TO_CHAR(ROUND(AVG(MONTHLY_BILL), 2), '99.99') AS AVG_MONTLHY_BILL2
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A)
GROUP BY 
	AREA_CODE, 
	PRODUCT;

--Notice that the average monthly bill for those on the same product isn't always the cost of the product - we'll come to that later!

--You don't have to nest a statement before you group by if the column is already there
SELECT 
	PRODUCT, 
	SUM(MONTHLY_BILL)
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
GROUP BY 
	PRODUCT;

--Technically you can not nest the main above query, but it is a bit more confusing!




---------------Exercise 3-------------------------------
/*
Create queries that answer the below questions using the tools you have learnt so far
1) What is the average monthly bill of all customers who are no longer with us? Hint: you don't have to actually group by anything!
2) What is the total future bill cost by day of the week? Hint, use the below site for to_char conversions
http://www.sqlines.com/oracle-to-sql-server/to_char_datetime
3) How many customers have our Fast product, by month they joined?
4) What is the product (multiplied all together) of the monthly bills of customers with kinda 
fast broadband by first letter of their last name.
Hint: google this one, stackoverflow is your friend! (remember we're using Oracle!)
5) Using table SCHEMA_NAME.MV_AVAIL what is the % of houses that are served by each type of line?
Bonus question: what % served by both Ultra Fast and Kinda Fast
*/


SELECT 
	AVG(MONTHLY_BILL) 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS 
WHERE 
	END_DATE IS NOT NULL;

SELECT 
	TO_CHAR(NEXT_BILL_DATE, 'DAY') AS WEEKDAY, 
	SUM(MONTHLY_BILL)
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	END_DATE IS NULL
GROUP BY 
	TO_CHAR(NEXT_BILL_DATE, 'DAY')
;

SELECT 
	TO_CHAR(START_DATE, 'MON') AS JOIN_MONTH, 
	SUM(
		CASE WHEN UPPER(PRODUCT) = 'FAST' THEN 1 ELSE 0 END
		) NUM_FAST
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
GROUP BY 
	TO_CHAR(START_DATE, 'MON');

SELECT 
	SUBSTR(LAST_NAME, 1, 1) AS LAST_INITIAL, 
	ROUND(EXP(SUM(LN(MONTHLY_BILL))))
FROM 
	SCHEMA_NAME.MV_CUSTOMERS
WHERE 
	PRODUCT = 'Kinda Fast'
GROUP BY 
	SUBSTR(LAST_NAME, 1, 1)
ORDER BY 
	LAST_INITIAL;

SELECT 
	SUM(CASE WHEN PHONE_ONLY = 'Y' THEN 1 ELSE 0 END)/COUNT(PHONE_ONLY)*100 AS PHONE_ONLY_PREC,	
	SUM(CASE WHEN KINDA_FAST_AVAIL = 'Y' THEN 1 ELSE 0 END)/COUNT(KINDA_FAST_AVAIL)*100 AS KINDA_FAST_AVAIL_PREC,	
	SUM(CASE WHEN PRETTY_FAST_AVAIL = 'Y' THEN 1 ELSE 0 END)/COUNT(PRETTY_FAST_AVAIL)*100 AS PRETTY_FAST_AVAIL_PREC,	
	SUM(CASE WHEN FAST_AVAIL = 'Y' THEN 1 ELSE 0 END)/COUNT(FAST_AVAIL)*100 AS FAST_AVAIL_PREC,	
	SUM(CASE WHEN SUPER_FAST_AVAIL = 'Y' THEN 1 ELSE 0 END)/COUNT(SUPER_FAST_AVAIL)*100 AS SUPER_FAST_AVAIL_PREC,	
	SUM(CASE WHEN ULTRA_FAST_AVAIL = 'Y' THEN 1 ELSE 0 END)/COUNT(ULTRA_FAST_AVAIL)*100 AS ULTRA_FAST_AVAIL_PREC,	
	SUM(CASE WHEN BOLT_FAST_AVAIL = 'Y' THEN 1 ELSE 0 END)/COUNT(BOLT_FAST_AVAIL)*100 AS BOLT_FAST_AVAIL_PREC	
FROM 
	SCHEMA_NAME.MV_AVAIL;

SELECT 
	SUM(CASE WHEN ULTRA_FAST_AVAIL = 'Y' AND KINDA_FAST_AVAIL ='Y' THEN 1 ELSE 0 END)/COUNT(PHONE_ONLY)*100 AS BONUS	
FROM 
	SCHEMA_NAME.MV_AVAIL;


----------------------------------------------------------------------------------

-------------BONUS WINDOW FUNCTIONS------------------

--Sometimes you want to get summarised information about a group without losing all the other information.
--Some common examples are you might want all the info about a task, but only if that task type has more than 100 tasks in a month
--To do this we use a window function, for our example let's find out if customers are paying more or less than the average bill for their area code
SELECT 
	AVG(MONTHLY_BILL) OVER (PARTITION BY AREA_CODE) AS AVG_BILL,
	CASE WHEN MONTHLY_BILL <= AVG(MONTHLY_BILL) OVER (PARTITION BY AREA_CODE) THEN 0 ELSE 1 END AS ABV_AREA_AVG,
	B.*
FROM
	(SELECT 
		A.*, 
		SUBSTR(PHONE_NUMBER, 1, 4) AREA_CODE 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A
	) B
;

--Probably the most common usage is generating row numbers to help get the first/last of something/remove duplicates on a key
SELECT 
	ROW_NUMBER() OVER (PARTITION BY PRODUCT_TYPE ORDER BY UP_SPEED DESC) RN,
	A.*
FROM
	(SELECT 
		* 
	FROM 
		MV_PRODUCTS
	UNION ALL
	SELECT 
		PRODUCT_TYPE, 
		UP_SPEED + 10, 
		DOWN_SPEED, 
		MONTHLY_COST 
	FROM 
		MV_PRODUCTS) A
ORDER BY 
	PRODUCT_TYPE
;

-------------END BONUS ------------------------------


--We've done a lot of interesting things very fast, but much of this you could do in excel and with pivot tables.
--The real power of SQL comes in large volumes of data and in combining tables.

--GO TO SLIDES TO SEE JOIN TABLE

--I built the tables from scratch so I don't have a tonne of join examples, I'd suggest a tutorial online if you aren't confident 
SELECT 
	A.*, 
	B.* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_AVAIL B 
ON 
	A.ADDRESS = B.ADDRESS;

SELECT 
	A.*, 
	B.*, 
	C.* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
LEFT JOIN 
	SCHEMA_NAME.MV_AVAIL C
ON 
	A.ADDRESS = C.ADDRESS;



---------------Exercise 4-------------------------------
/*
Create queries that answer the below questions using the tools you have learnt so far
1) How many customers who's first name starts with G, have Ultra fast available at their home?
2) What is the average age of customer accounts who have at least 41 upload speed? - Include closed accounts (you will need the nvl function, and trunc and sysdate)
3) What is the phone number of the customer with the third lowest account number who have less than 6 download speed and have super fast available?
*/

SELECT 
	COUNT(*) 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_AVAIL B 
ON 
	A.ADDRESS = B.ADDRESS
WHERE 
	SUBSTR(A.FIRST_NAME, 1, 1) = 'G' 
	AND ULTRA_FAST_AVAIL = 'Y';

SELECT 
	AVG(NVL(END_DATE, TRUNC(SYSDATE)) - START_DATE) 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON
	A.PRODUCT = B.PRODUCT_TYPE
WHERE 
	B.UP_SPEED >=41;

SELECT 
	A.PHONE_NUMBER 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
LEFT JOIN 
	SCHEMA_NAME.MV_AVAIL C
ON 
	A.ADDRESS = C.ADDRESS
WHERE 
	B.DOWN_SPEED <6 
	AND SUPER_FAST_AVAIL = 'Y'
ORDER BY 
	ACCOUNT_NUMBER ASC;

----------------------------------------------------------------------------------

--Now you know all the tools you can do what we should have done first, make sure your data is clean
--What could be the issues with the data?



--This is one way to check if the property is being served by a product they apparently don't have

SELECT 
	* 
FROM 
	(SELECT 
		ACCOUNT_NUMBER, 
		CASE WHEN (UPPER(A.PRODUCT) = 'KINDA FAST' 	AND B.KINDA_FAST_AVAIL 	= 'Y') OR 
				(UPPER(A.PRODUCT) 	= 'PRETTY FAST'	AND B.PRETTY_FAST_AVAIL = 'Y') OR 
				(UPPER(A.PRODUCT) 	= 'FAST'		AND B.FAST_AVAIL 		= 'Y') OR 
				(UPPER(A.PRODUCT) 	= 'SUPER FAST'	AND B.SUPER_FAST_AVAIL 	= 'Y') OR 
				(UPPER(A.PRODUCT) 	= 'ULTRA FAST'	AND B.ULTRA_FAST_AVAIL 	= 'Y') OR 
				(UPPER(A.PRODUCT) 	= 'BOLT FAST'	AND B.BOLT_FAST_AVAIL 	= 'Y') 
			THEN 'N'
			WHEN (UPPER(A.PRODUCT) 	= 'KINDA FAST' 	AND B.KINDA_FAST_AVAIL 	= 'N') OR 
				(UPPER(A.PRODUCT) 	= 'PRETTY FAST'	AND B.PRETTY_FAST_AVAIL = 'N') OR 
				(UPPER(A.PRODUCT) 	= 'FAST'		AND B.FAST_AVAIL 		= 'N') OR 
				(UPPER(A.PRODUCT) 	= 'SUPER FAST'	AND B.SUPER_FAST_AVAIL 	= 'N') OR 
				(UPPER(A.PRODUCT) 	= 'ULTRA FAST'	AND B.ULTRA_FAST_AVAIL 	= 'N') OR 
				(UPPER(A.PRODUCT) 	= 'BOLT FAST'	AND B.BOLT_FAST_AVAIL 	= 'N') 
			THEN 'Y' 
		END AS AVAIL_ISSUE
	FROM "
		611192767".MV_CUSTOMERS A
	LEFT JOIN 
		SCHEMA_NAME.MV_AVAIL B 
	ON 
		A.ADDRESS = B.ADDRESS)
WHERE 
	AVAIL_ISSUE = 'Y';
--but as you can see it's messy and long. 
--Sometimes you will have to accept that this is the only way to do something as the tables are too big to edit or you don't own them. 

--But if you are the owner of the data then it is sometimes worth thinking in advance about what will be the right form for the data in the long term.

--I have been nice to you and created this same data in a different format at
SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_AVAIL_V2;
--(Come along to the R session to see a quick way to convert the data between these two formats, there are ways to do this in sql but it's quite complex)



---------------Exercise 5-------------------------------
/*
Create queries that answer the below questions using the tools you have learnt so far (some questions take more than 1 query!)
1) How many (and which) customers are paying a different amount on their monthly bill than they should for their product?
Bonus: how many are paying more, how many are paying less, what the average overpayment and underpayment, which do we care more about as a company?
2) How many customers have incorrect data regarding end date/continued billing, and what are the errors?
3) Rewrite the above query using the new availability table (you will need to lookup the replace function) - which customers are served by a product they don't have available?
*/

SELECT 
	A.*, 
	B.MONTHLY_COST 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
WHERE 
	MONTHLY_BILL != MONTHLY_COST;

SELECT 
	A.*, B.MONTHLY_COST 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
WHERE
	MONTHLY_BILL > MONTHLY_COST;

SELECT 
	A.*, 
	B.MONTHLY_COST 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
WHERE 
	MONTHLY_BILL < MONTHLY_COST;

SELECT 
	AVG(MONTHLY_BILL - B.MONTHLY_COST) AS OVERPAYMENT 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
WHERE 
	MONTHLY_BILL > MONTHLY_COST;

SELECT 
	-AVG(MONTHLY_BILL - B.MONTHLY_COST) AS UNDERPAYMENT 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
WHERE 
	MONTHLY_BILL < MONTHLY_COST;

SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
WHERE 
	END_DATE IS NOT NULL 
	AND NEXT_BILL_DATE IS NOT NULL;

SELECT 
	* 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
WHERE 
	END_DATE IS NOT NULL 
	AND LAST_BILLED_DATE != END_DATE;

SELECT 
	*
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_AVAIL_V2 B 
ON 
	A.ADDRESS = B.ADDRESS
WHERE 
	UPPER(A.PRODUCT) = REPLACE(REPLACE(UPPER(B.PRODUCT_TYPE), '_AVAIL', ''), '_', ' ')
	AND AVAILABLE = 'N';

---------------------------------------------------------------------------------------------


--Sometimes you might want to keep a table for later, or let others access it, to do this you need to create a table
CREATE TABLE MV_CUSTOMERS_COPY NOLOGGING AS
SELECT 
	*
FROM 
	SCHEMA_NAME.MV_CUSTOMERS;

--You might need to overwrite this table, or change it, or just delete it entirely - to do this you must drop the table
DROP TABLE MV_CUSTOMERS_COPY PURGE;
--Make sure you purge the table! It's like cleaning your recycling bin.

--You can also insert new rows into a current table, update certain rows, or remove certain rows that I won't cover here.

--Finally, if you only want a table for a short time, say you don't want a massive nested query, you can use a with statement:
WITH TEMP_CUST AS (
	SELECT 
		A.*, 
		SUBSTR(LAST_NAME, 1, 1) AS INITI 
	FROM 
		SCHEMA_NAME.MV_CUSTOMERS A
) 

SELECT 
	INITI 
FROM 
	TEMP_CUST;
/*
Putting it all together! The final Mirgin Vedia exercise
We want to advertise to all our customers who could be on a faster product than they are currently on, there are a few things we will want to know:
(make sure to exclude any issue customers you found before! Remember you can use a not in (maybe create a table with those order numbers in?))
	a) Who are these customers? How many are there?
	b) How much could their personal speed improve, and what's the average speed all these customers could see an uplift of?
	c) How much more would these customers be paying personally? How much more would the company make from this? 
	d) Say we wanted to entice customers by offering them money off their bill, do we make more money by offering 10% or £10 regardless of new bill amount?
	e) We want to build a table that we can use to send all our emails from to these customers automatically. 
	Write a query that returns 2 columns - one with customer email and one with the content of the email using the concatination operator we learnt earlier
	Use the below template, create a table in your schema first with each of these options (or whatever you need to get them easily) and then write the final script and query that table


Dear  _______, We noticed that you are currently on our _____ product with an upload/download speed of ___mbps/___mbps, but you could be getting ___mbps/___mbps by switching to our _____ product. Not only will this let you stream all your favourite shows and download all your new music faster than ever, but for a limited time rather than the usual cost of £___ we are offering this to you for £____ (use whichever makes the company more money from above), meaning this is only £___ more than your current bill! That is a bargain you will only get direct from Mirgin Vedia. If you want to know more give our friendly customer helper line a call on 0800 GO-VEDIA (0800 46 83342)! Thanks, Your Local Mirgin Vedia Team!


The lack of formatting might make our campaign less successful, but at least we don't have to type them all by hand!
*/

--CREATING AND ADDING THE ISSUE DETAILS INTO A TABLE SO I CAN IGNORE THEM
DROP TABLE MV_ISSUE PURGE;

CREATE TABLE MV_ISSUE NOLOGGING AS
SELECT 
	ACCOUNT_NUMBER
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_AVAIL_V2 B 
ON 
	A.ADDRESS = B.ADDRESS
WHERE 
	UPPER(A.PRODUCT) = REPLACE(REPLACE(UPPER(B.PRODUCT_TYPE), '_AVAIL', ''), '_', ' ')
	AND AVAILABLE = 'N';

--COULD ALSO UNION THEM
INSERT INTO MV_ISSUE 
SELECT 
	ACCOUNT_NUMBER 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
WHERE 
	END_DATE IS NOT NULL 
	AND NEXT_BILL_DATE IS NOT NULL;

INSERT INTO MV_ISSUE
SELECT 
	ACCOUNT_NUMBER 
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
WHERE 
	MONTHLY_BILL != MONTHLY_COST;

COMMIT;

--------------------
--CREATE A LIST OF THE CUSTOMERS WITH THE BEST POSSIBLE UPGRADE FOR THEM
DROP TABLE MV_UPGRADE_LIST PURGE;

CREATE TABLE MV_UPGRADE_LIST NOLOGGING AS 
WITH TEMP_CURRENT AS (
SELECT 
	A.FIRST_NAME, 
	A.LAST_NAME,
	A.EMAIL,
	A.ADDRESS,
	A.MONTHLY_BILL, 
	A.PRODUCT,
	B.UP_SPEED AS CURRENT_UP,
	B.DOWN_SPEED AS CURRENT_DOWN, 
	REPLACE(REPLACE(UPPER(C.PRODUCT_TYPE), '_AVAIL', ''), '_', ' ') AS OTHER_PRODUCT
FROM 
	SCHEMA_NAME.MV_CUSTOMERS A 
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.PRODUCT = B.PRODUCT_TYPE
LEFT JOIN 
	SCHEMA_NAME.MV_AVAIL_V2 C
ON
	A.ADDRESS = C.ADDRESS
LEFT JOIN
	MV_ISSUE ISS 
ON 
 	A.ACCOUNT_NUMBER = ISS.ACCOUNT_NUMBER
--ONLY WANT ONES WHERE THE PRODUCT IS AVAIALBLE AND THEY DO NOT HAVE AN ISSUE
WHERE 
	C.AVAILABLE = 'Y' 
	AND ISS.ACCOUNT_NUMBER IS NULL),

TEMP_COMBINED AS (
SELECT 
	Z.*, 
	Y.* 
FROM 
	TEMP_CURRENT Z
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS Y
ON 
	Z.OTHER_PRODUCT = UPPER(Y.PRODUCT_TYPE)
--GET THOSE WITH A BETTER SPEED
WHERE 
	UP_SPEED > CURRENT_UP)

SELECT 
	A.*, 
	B.UP_SPEED AS FUTURE_UP, 
	B.DOWN_SPEED AS FUTURE_DOWN, 
	B.PRODUCT_TYPE AS FUTURE_PRODUCT 
FROM
	(SELECT 
		COMB.FIRST_NAME,
		COMB.LAST_NAME,
		COMB.EMAIL,
		COMB.MONTHLY_BILL,
		COMB.PRODUCT AS CURRENT_PROD, 
		COMB.CURRENT_UP,
		COMB.CURRENT_DOWN,
		MAX(COMB.MONTHLY_COST) AS FUT_BILL
	FROM 
		TEMP_COMBINED COMB
	GROUP BY 
		COMB.FIRST_NAME,
		COMB.LAST_NAME,
		COMB.EMAIL,
		COMB.MONTHLY_BILL,
		COMB.PRODUCT,
		COMB.CURRENT_UP,
		COMB.CURRENT_DOWN) A
LEFT JOIN 
	SCHEMA_NAME.MV_PRODUCTS B 
ON 
	A.FUT_BILL = B.MONTHLY_COST;


--ANSWERING SOME OF THE QUESTIONS
--Who are the customers and what speed could they improve by?
SELECT 
	FIRST_NAME, 
	LAST_NAME, 
	FUTURE_UP - CURRENT_UP AS SPEED_IMPROV 
FROM 
	MV_UPGRADE_LIST;

--Average overall speed improvement
SELECT 
	AVG(FUTURE_UP - CURRENT_UP) AS AVG_SPEED_IMPROV 
FROM 
	MV_UPGRADE_LIST;

--Each customer bill increase
SELECT 
	FIRST_NAME, 
	LAST_NAME, 
	FUT_BILL - MONTHLY_BILL AS COST_CHANGE 
FROM 
	MV_UPGRADE_LIST;

--how much the company makes
SELECT 
	SUM(FUT_BILL - MONTHLY_BILL) AS INCREASED_COMPANY_REVENUE 
FROM
	MV_UPGRADE_LIST;

--which is better for the company?
SELECT 
	SUM(FUT_BILL*0.9 - MONTHLY_BILL) AS PERC_BENEFIT, 
	SUM(FUT_BILL - 10 - MONTHLY_BILL) AS ABOLSUTE_BENEFIT 
FROM 
	MV_UPGRADE_LIST;



--CREATE THE FINAL TABLE
SELECT
	EMAIL,
	'Dear ' 
	|| FIRST_NAME ||
	', We noticed that you are currently on our '
	|| CURRENT_PROD ||
	' product with an upload/download speed of '
	|| CURRENT_UP || 'mbps/' || CURRENT_DOWN ||
	'mbps, but you could be getting '
	|| FUTURE_UP || 'mbps/' || FUTURE_DOWN ||
	'mbps by switching to our '
	|| FUTURE_PRODUCT  ||
	' product. Not only will this let you stream all your favourite shows and download 
	all your new music faster than ever, but for a limited time rather than the usual cost of £'
	|| FUT_BILL ||
	' we are offering this to you for £'
	|| ROUND(FUT_BILL*0.9,2) || 
	', meaning this is only £'  
	|| to_char(ROUND(FUT_BILL*0.9 - MONTHLY_BILL, 2), '99.99') ||
	' more than your current bill! That is a bargain you will only get direct from Mirgin Vedia. 
	If you want to know more give our friendly customer helper line a call on 0800 GO-VEDIA (0800 46 83342)! 
	Thanks, Your Local Mirgin Vedia Team!'  AS MESSAGE
FROM 
	MV_UPGRADE_LIST;


----------------------------------------------------------------------------------

/*

--World Dataset questions
SCHEMA_NAME.CITY
SCHEMA_NAME.COUNTRY
SCHEMA_NAME.COUNTRYLANGUAGE

What is the population of the US? 
What is the area of the US? 
List the countries in Africa that have a population smaller than 30,000,000 and a life expectancy of more than 45?
Which countries are something like a republic? (are there 122 or 143 countries or ?)
Which countries are some kind of republic and achieved independence after 1945?
Which countries achieved independence after 1945 and are not some kind of republic?


Which fifteen countries have the lowest life expectancy? highest life expectancy?
Which five countries have the lowest population density? highest population density?
Which is the smallest country, by area and population? the 10 smallest countries, by area and population?
Which is the biggest country, by area and population? the 10 biggest countries, by area and population?


Of the smallest 10 countries, which has the biggest gnp? 
Of the smallest 10 countries, which has the biggest per capita gnp?
Of the biggest 10 countries, which has the biggest gnp?
Of the biggest 10 countries, which has the biggest per capita gnp?
What is the sum of surface area of the 10 biggest countries in the world? The 10 smallest? (google rownum in oracle sql)


How big are the continents in term of area and population?
Which region has the highest average gnp?
Who is the most influential head of state measured by population?
Who is the most influential head of state measured by surface area?
What are the most common forms of government? 
What are the forms of government for the top ten countries by surface area?
What are the forms of government for the top ten richest nations? (technically most productive)
What are the forms of government for the top ten richest per capita nations? (technically most productive)


Stretch Challenges
What is the 3rd most common language spoken?
How many cities are in Chile?
What is the total population in China?
How many countries are in North America? 
Which countries gained their independence before 1963?
What is the total population of all continents?
What is the average life expectancy for all continents?
Which countries have the letter z in the name? How many?
What is the age of Jamaica?
Are there any countries without an official language? Hint:  WHERE ... NOT IN ( SELECT ... FROM ... WHERE ...) 


https://www.learnacademy.org/current-days/1025

*/
