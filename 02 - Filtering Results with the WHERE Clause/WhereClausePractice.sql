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
    |                                         FILTERING RESULTS WITH THE WHERE CLAUSE                                      |
    ------------------------------------------------------------------------------------------------------------------------

    - The WHERE Keyword is going to tell the query, "tell the database how to constrain the result set". It's a fairly decent 
      correlation to english.
        Example: I want to know X WHERE a certain condition is true

    - The WHERE clause is going to come after the FROM clause, and it's going to contain boolean expressions. The database will
      then filter the result set, and return only the rows where the expression evaluates to true.
        - Example of simple boolean expressions can be:
            - Does 2 equal 2? => True
            - Does 2 equal 3? => False


    -------------------------
    |     Visualization     |
    -------------------------
    
            Select clause         From clause            Where clause
        ---------------------  -----------------  ---------------------------
        |                   |  |               |  |                         |
        SELECT <COLUMN_NAME>   FROM <TABLE_NAME>  WHERE <BOOLEAN_EXPRESSION>;

    Example: What is the last name of all the people I know, whose first name is 'john'?
*/
SELECT p.last_name FROM person p WHERE p.first_name = 'John';  
/*
    - Notice how in the WHERE clause we still qualify the column name, we should continue doing this good practice even in the WHERE clause
    - The result set will be:
        -----------------
        |   last_name   |
        -----------------
        |     Doe       |
        -----------------
        |     Snow      |
        -----------------
*/

/* 
    -------------------------
    |   Boolean Operators   |
    -------------------------

    --------------------------------------------
    |   =    |      Equals                     |       
    --------------------------------------------
    |   <>   |      Not Equals                 |    
    --------------------------------------------
    |    >   |      Greater Than               |  
    --------------------------------------------
    |    <   |      Less Than                  |
    --------------------------------------------
    |   >=   |  Greater or Equal               | 
    --------------------------------------------
    |   <=   |  Less Than or Equal             | 
    --------------------------------------------
    |   AND  | Both expressions must be True   | 
    --------------------------------------------
    |   OR   | One expression  must be True    | 
    --------------------------------------------
    |BETWEEN | Is column value between a range | 
    --------------------------------------------
    |  LIKE  |    A more fuzzy version of =    | 
    --------------------------------------------
    |   IN   |    A multi-value = operator     | 
    --------------------------------------------
    |   IS   |  = operator specially for NULL  | 
    --------------------------------------------
    | IS NOT | != operator specially for NULL  | 
    --------------------------------------------
*/

/* 
    AND Example: 
        Who are all the people in my contact list that have the first name 'John"
        & were born later than 1965
*/
SELECT p.first_name, p.last_name From person p WHERE p.first_name = 'John' AND p.birthday > '12/31/1965';


/* 
    OR Example:
        who are all the people in my contact list that have the first name of Jon or a 
        last name of Flanders
*/
SELECT p.first_name, p.last_name From person p WHERE p.first_name = 'John' OR p.last_name = 'Flanders';


/* 
    BETWEEN Example:
        who are all the people in my contact list that I've contacted at least once, but 
        no more than 20 times
*/
SELECT p.first_name, p.last_name From person p WHERE p.contacted BETWEEN 1 AND 20;


/* 
    LIKE Example:
        who are all the people whose first name start with J
*/
SELECT p.first_name, p.last_name From person p WHERE p.first_name LIKE 'J%';


/* 
    IN Example:
        Who are all the people in my contact list that are named Jon or Fritz
*/
SELECT p.first_name, p.last_name From person p WHERE p.first_name IN ('John', "Fritz");


/* 
    IS Example:
        Who are all the people in my contact list that don't have a last name?
*/
SELECT p.first_name, p.last_name From person p WHERE p.last_name IS NULL;


/* 
    IS NOT Example:
        So who are all the people in my contact list that have a last name
*/
SELECT p.first_name, p.last_name From person p WHERE p.last_name IS Not NULL;
