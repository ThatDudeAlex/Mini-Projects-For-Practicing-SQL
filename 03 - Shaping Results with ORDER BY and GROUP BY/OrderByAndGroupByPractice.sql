/* 
    The queries in these examples are based on a table called 'person' that looks like this:

        table_name: person
        ----------------------------------------------------------------
        |   id  |   first_name  |   last_name   |   contacted_number   |
        ----------------------------------------------------------------
        |   1   |     John      |       Doe     |          8           |
        ----------------------------------------------------------------
        |   2   |     Alex      |     Nunez     |          2           |
        ----------------------------------------------------------------
        |   3   |     John      |     Snow      |          32          |
        ----------------------------------------------------------------
        |   4   |     Alex      |    Macedon    |          16          |
        ----------------------------------------------------------------
        |   5   |   Sanyeris    |      Diaz     |          64          |
        ----------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------
    |                                       SHAPING RESULTS WITH ORDER BY AND GROUP BY                                     |
    ------------------------------------------------------------------------------------------------------------------------

    - So far we have seen the result set in the order that the database stores the rows
    
    - Sometimes you want the result set to be different than the data returned by a simple SELECT statement
*/


/* 
    --------------
    |  ORDER BY  |
    --------------
    
    - The main way that we order a result set is using ORDER BY. 

    - So the ORDER BY clause, as its name suggests, allows us to sort the result set. We're going to 
      put this after the WHERE clause. Now if there is no WHERE clause, that's okay. You can still have 
      ORDER BY after the FROM 
      
    - The default ordering is ascending. If you want the order to be descending, you specify that at the end of the ORDER BY clause
*/
SELECT p.first_name, p.last_name FROM person p ORDER BY p.last_name;


/* 
    -------------------
    |  SET FUNCTIONS  |
    -------------------
    
    - A commonly‑used function with ORDER BY is one of the set functions. Set functions compute new values from column values. 
      So we'll use the set function in place of one of the columns in the SELECT clause, and we basically, passed the column name 
      that we want the function to be applied to into the function. This is going to help us ask more interesting questions, and by 
      using set and order, now we can start to get into things like how many contacts do I have where I've talked to those contacts 
      at least 10 times? How many widgets have I sold, order them by the amount sold and the country. So these are ways that you can 
      start using ORDER BY in more sophisticated ways to give you more sophisticated answers to more sophisticated questions. And as we'll 
      see, it's often used with the distinct qualifier. So let's go over the set functions.


        COUNT: 
            Counts the number of rows for the column specidied (Includes NULL values if * is used instead of column name)

        MAX:
            Maximum value of the column (does not include NULL values)

        MIN:
            Manimum value of the column (does not include NULL values)

        AVG:
            Average of all values in the column (does nut include NULL values & only works for numeric column)

        SUM:
            Sum of all values in the column (does nut include NULL values & only works for numeric column)
*/

-- SUM Example:
--   What is the total number of times that I have contacted my contacts?
SELECT SUM(p.contacted_number) FROM person p;

-- COUNT Example:
--   How many contacts have the name John?
SELECT COUNT(p.first_name) FROM person p WHERE p.first_name = 'John';

-- MAX Example:
--   which contact have I contacted the most?
SELECT MAX(p.contacted_number) FROM person p;

-- AVG Example:
--   How much contact do I have with my contacts on average?
SELECT AVG(p.contacted_number) FROM person p;



/* 
    --------------
    |  ORDER BY  |
    --------------
    
    - The main way that we order a result set is using ORDER BY. 

    - So the ORDER BY clause, as its name suggests, allows us to sort the result set. We're going to 
      put this after the WHERE clause. Now if there is no WHERE clause, that's okay. You can still have 
      ORDER BY after the FROM 
      
    - The default ordering is ascending. If you want the order to be descending, you specify that at the end of the ORDER BY clause
*/
SELECT p.first_name, p.last_name FROM person p ORDER BY p.last_name;


/* 
    --------------------------------
    |  SET FUNCTIONS + Qualifiers  |
    --------------------------------
    
    - Set functions are sometimes used with qualifiers like Distinct, and when you're going to use one of those qualifiers, you add 
      the qualifier inside of the function next to the column name. 
      
    - The most common example, of course, is DISTINCT, which would give you a distinct number of column values to work with in 
      terms of passing to the function
*/

-- Example
--   What is the count of unique first names among my contacts?
SELECT COUNT(DISTINCT p.first_name) FROM person p;


/* 
    --------------
    |  GROUP BY  |
    --------------
    
    - GROUP BY is another keyword, another clause that we can add to our queries, and this is going to allow our queries to be a 
      little bit more sophisticated, get some more interesting results.

    - What the GROUP BY clause does is it allows me to add multiple columns into the select list and still use a set function inside 
      of the select list. By default, if I use a set function in a select list, I can't also use another column and get a rational result, 
      you get kind of a weird result.

    - So what GROUP BY does, you can think about it as breaking the results set into subsets. It then will run the set function against those 
      subsets. What we end up with is one row per subset. The subset is dictated by the column name specified in the GROUP BY

    -  Now, the column you use in the GROUP BY has to also appear in the SELECT LIST. This is a hard and fast requirement.
*/

-- Example:
--   What is the count of every unique first name among my contacts?
SELECT COUNT(p.first_name), p.first_name FROM person p GROUP BY p.first_name;


/* 
    --------------
    |   HAVING   |
    --------------

    - HAVING, what it does, it works like the WHERE clause works against SELECT, but it works against a query with a GROUP BY clause. So this is 
      going to restrict the result set that the GROUP BY clause is going to operate against. Remember, the GROUP BY clause will take the whole result 
      set, break it up into subsets, and then output one row per subset. The HAVING clause allows you to restrict the subset
*/

-- Example
--   What is the count of unique first names among my contacts list that appear at least 5 times?
SELECT COUNT(DISTINCT p.first_name) as FirstNameCount, first_name from person p GROUP BY first_name HAVING FirstNameCount >= 5;

