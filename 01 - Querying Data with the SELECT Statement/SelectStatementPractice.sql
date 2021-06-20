
/* 
    The queries in these examples are based on a table called 'person' that looks like this:

        table_name: person
        --------------------------------------------------------
        |   id  |   first_name  |   last_name   |   Birthday   |
        --------------------------------------------------------
        |   1   |     John      |       Doe     |   1/1/1990   |
        --------------------------------------------------------
        |   2   |     Alex      |     Nunez     |   2/2/1991   |
        --------------------------------------------------------
        |   3   |     John      |     Snow      |   3/3/1992   |
        --------------------------------------------------------
        |   4   |     Alex      |    Macedon    |   4/4/1993   |
        --------------------------------------------------------
        |   5   |   Sanyeris    |      Diaz     |   5/5/1994   |
        --------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------
    |                                                   SELECT STATEMENT                                                   |
    ------------------------------------------------------------------------------------------------------------------------

    SELECT: 
        - This is a command that allows you to get data
        - It retrieves 1 or more rows, from 1 or more tables

    IMPORTANT:
        - A SELECT statement is really a question. It is the translation of a question you have about your data into correct 
          valid SQL, into a SQL statement
        
    -------------------------
    |   Visual of SELECT    |
    -------------------------
    
        SELECT <COLUMN_NAME>, <COLUMN_NAME> FROM <TABLE_NAME>;

        Example: SELECT first_name, last_name FROM contacts;
*/


/*  
    -------------------------
    |   Simple SQL Query    |
    -------------------------

    This SELECT statement followed by the select-list 'Hello', 'World' will return a row with 2 columns. 
    One row for each value in the select-list

    Things like these can be useful if we want to return constant values in some cases, and we can return them 
    without having to query them in the data. 
*/
SELECT 'Hello','World';


/*  
    -----------------------
    |   The SELECT List   |
    -----------------------

    - Most of the times it contains a list of columns from a table you would like to get data from
    - Once you have a list of columns, then you're required to have a FROM clause
        
    IMPORTANT: 
        - In the previous example we didn't need a FROM clause since we didn't have any column names

        - Once you have column names, the table name is required in the FROM clause
*/
SELECT first_name, last_name FROM person;


/*  
    -------------------------------------
    |   The SELECT List Wild Card (*)   |
    -------------------------------------

    - sometimes when you look at a table, and you're going to write a SELECT statement, you might think, Wow, there're a lot 
      of column names that I'm going to have to write down. 
    - There is a way to not have to write down every column that you want to get. That's by using the asterisk or the star

    - This is the wild card SELECT list
    - For example if we say SELECT * FROM <TABLE_NAME> this will give us all of the columns 

    - IMPORTANT:
        - This is NOT a good thing, using * in a SELECT statement is considered very bad practice!

        - Reasons why is a bad practice:
            - If the application that's getting back your data has to look at the different columns, what happens if the database 
              updates those columns or adds a column? Well, now the database application could be caught in a weird situation
            
            - It's much better to be explicit about the names of the columns in your SELECT list. It will benefit you greatly, even 
              if you maybe don't understand now completely why, if you're new to SQL
            
            - But just to warn you, if you submit SQL statements with star in it to any sort of code review or maybe you have to show 
              it to the database administrator before the database administrator will let you run that query, nobody's going to like this. 
              Everybody is going to say, Hey, could you use column names instead.
*/
SELECT * FROM person;



/* 
    -------------------------
    |       FROM CLAUSE     |
    -------------------------

    - So the FROM clause is going to at least define the table that you want to query. 

    - It is possible to query multiple tables, as I've said. We're going to cover that later on, however. 
      So for right now, we're going to stick with a single table name in the FROM clause.

    - Now a good practice is, instead of saying: 
        - SELECT first_name, last_name FROM person; 
        - It's a good idea to qualify every column name in your select list with the table name
    
    - So if we're going to do that in this case, first_name would turn into person.first_name, person dot is the qualification 
      for the column first_name, where a person is the table and then dot indicates the relationship, right, that column is a 
      child of person. Same thing for last_name, and now we can say FROM person.

        - SELECT person.first_name, person.last_name FROM person; 

    - Okay, so this is a good practice, right? It's a good practice to always table qualify the names of your columns. Some databases 
      will run this query faster when you have qualified the name of the column. But certainly, for one thing, I think it makes the SQL 
      statement much easier to read. The SELECT list is much clearer and, again, in this simple case, it may not seem like that's such a 
      big deal, but as we get into more complex queries, as we get into multi‑table queries, always qualifying the column names helps you 
      to be able to disambiguate which columns are from which table. Okay, so again, good practice. You should do this

    - There is a way to make this less painful than typing out person.first_name, person.last_name.
      What we can do is we can alias the table name. So we can say person p, where p is the alias that you're giving to the person table.

        - SELECT p.first_name, p.last_name FROM person p; 
    
    - Best practice is to not only qualify all the column names, but to alias each of the table names, again, helps you simplify the query, 
      and keeps it much cleaner and much easier to read
*/
SELECT p.first_name, p.last_name FROM person p; 


-- We can also alias the column names in a SELECT statement with the AS Keyword, like these examples here

SELECT 'Hello' AS FirstWord,'World' AS SecondWord;
/*
    This would return:
        
        ---------------------------------
        |   FirstWord   |   SecondWord  |
        ---------------------------------
        |   Hello       |   World       |
        ---------------------------------      
*/

 SELECT p.first_name AS FirstName FROM person p; 
 /*
    This would return something like this:
        
        -----------------
        |   FirstName   |
        -----------------
        |   John        |
        -----------------
        |   Alex        |
        -----------------
*/



/* 
    ------------------------------------------------------------------------------------------------------------------------
    |                                           HOW TO CONSTRAINT THE RESULT SET                                           |
    ------------------------------------------------------------------------------------------------------------------------

    - All of the queries that we've done so far have returned all of the columns from the table. Although you will sometimes 
      run such a query, it is fairly unusual. Most of the time what you want is some subset of the data. You want to constrain 
      the rows that get returned to your dataset from the SQL statement. And so there are really two ways to constrain the number 
      of results. 
        - One way is to add a DISTINCT qualifier.
        - The other way is to add a WHERE clause to your SELECT statement.
*/



/* 
    -----------------------------------------
    |       DISTINCT AND NOT DISTINCT       |
    -----------------------------------------

    - Not Distinct means that it will return the entire data set, even if some attributes are repeated. 

    - Distinct means that it look at the values that would be returned in your data set, and return back only the values only the unique values. 

    - IMPORTANT:
        - Not Distinct is the default 
        - To make something distinct, we must use the DISTINCT keyword before the column list
        - The DISTINCT keyword applies to all of the columns in the column list, not just the first one
*/

/* 
    Example of Non Distinct: 
        - What are all the First Names of the people I know?
*/

 SELECT p.first_name FROM person p; 
 /*
    This could return something like this:
        
        -----------------
        |   FirstName   |
        -----------------
        |   John        |
        -----------------
        |   Alex        |
        -----------------
        |   John        |
        -----------------
        |   Alex        |
        -----------------
        |   Sanye       |
        -----------------
*/

/* 
    Example of Distinct: 
        - What are all unique First Names of the people I know?
*/

 SELECT DISTINCT p.first_name FROM person p; 
 /*
    This would return something like this:
        
        -----------------
        |   FirstName   |
        -----------------
        |   John        |
        -----------------
        |   Alex        |
        -----------------
        |   Sanye       |
        -----------------



    ---------------------------------------------------------------------
    |          SUMMARY OF QUERYING DATA WITH SELECT STATEMENTS          |
    ---------------------------------------------------------------------

    - We query data with the SELECT command. 
    - The SELECT list defines the number of columns. 
    - The FROM clause defines the table that we want to use. 
    - And remember that DISTINCT helps you to constrain the results to unique values.
*/

