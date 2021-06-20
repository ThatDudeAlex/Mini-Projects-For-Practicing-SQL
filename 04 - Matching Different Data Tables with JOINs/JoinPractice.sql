/* 
    ------------------------------------------------------------------------------------------------------------------------
    |                                         Matching Different Data Tables with JOINs                                    |
    ------------------------------------------------------------------------------------------------------------------------

    - the JOIN clause, the JOIN keyword, is a new keyword that we're going to start talking about. It merges multiple tables into one result set. 
      
    - The FROM clause is going to have to include all the tables that we want to join. We're going to separate each table with a comma. 
    
    - Typically, we're going to have a WHERE clause. Most of the time, we don't want to just join the data whole from one table to another. 
    
    - Again, usually we're using these types of clauses in more sophisticated query scenarios. Now in the WHERE clause, we can restrict the result set 
      from each different table. We can put in Boolean expressions that return true or false, and those expressions can reference columns from all the tables. 
      
    - Now there are different kinds of JOINs, so we're going to talk about each one in turn
*/


/* 
    ----------------
    |  CROSS JOIN  |
    ----------------
        - This is the simplest join. 
        
        - It's going to return all rows from both tables. 
        
        - No WHERE clause. 
        
        - This is also the least useful. 
        
        - It's very inefficient. 
        
        - It creates what's called a Cartesian product 
        
        - You don't actually have to use the cross join or the join keyword. It's implied just by the syntax of the query 

    Example: 
        - What are all the first names and email addresses I have?
        
        - NOTICE: 
            - The example below has multiple tables in the From clause & no WHERE clause
            - This is what's going to create the cartesian product
            - This is BAD PRACTICE and an inefficient query 
*/
SELECT p.first_name, e.email_address FROM person p, email_address e; 


/* 
    ----------------
    |  INNER JOIN  |
    ----------------
        - This is the most typical JOIN we're going to use. 
        
        - This is emphasizing the relational nature of a database. What it's going to do is it's going to allow us to match the 
          column value in one of the tables to the column value in another one of the tables. And in this simple case, if we have 
          two tables, that's a column from the first table to a column in the second table. 
          
        - Most of the time, we're going to use a primary key in one of the tables and a foreign key in one of the other tables. 
          If you remember back to the introduction, the relational model is dependent on this idea of each table has a relationship 
          to some other table. We have a primary key in the first table. We've got a foreign key in the second table, and that allows 
          us to relate table one to table two. The INNER JOIN is the clause that's going to allow us to make that happen 

    Example: 
        - Instead of saying, What are all my contacts, and what are all my email addresses?, which isn't a very useful result set, 
          how about, What are all my contacts' email addresses? 
        
        - IMPORTANT: 
            - the INNER JOIN clause and the ON clause are the key here. 
            
            - INNER JOIN says I want to JOIN these two tables and then the ON clause specifies between those two tables, 
              what columns should we relate? Which columns are part of this relational model?
*/
SELECT p.first_name, p.last_name, e.email_address FROM person p
    INNER JOIN email_address e ON p.person_id = e.email_address_person_id;


/* 
    ----------------
    |  OUTER JOIN  |
    ----------------
        - The difference between an inner join and an outer join is that inner joins don't deal with null values and outer joins do. 
          
        - That is, if there isn't data matching the query in one or both of the tables, inner join ignores that. Outer joins will work 
          even when there is no match in the second table. 
          
        - Then null columns matching in the second table would mean that those values in the result set will be null. Now a full outer join 
          will return all the rows from both tables that match the query and then null for the columns in the first table where the second 
          table has data but the first table doesn't and null rows in the second table when the first table has data and the second table doesn't.
*/


/* 
    ---------------------
    |  LEFT OUTER JOIN  |
    ---------------------
        - Now, the left outer join is a kind of outer join that specifies all the rows from the left side table will be returned NULL for non‑matching 
          right side table rows

        - IMPORTANT
            - We're still using the relational system, but we're basically saying, if there isn't a match in the right hand table, 
              please return those rows

        Example: 
            - What are my contacts and their email addresses, including those I don't have an email for?
*/
SELECT p.first_name, p.last_name, e.email_address FROM person p
    LEFT OUTER JOIN email_address e ON p.person_id = e.email_address_person_id;


/* 
    ----------------------
    |  RIGHT OUTER JOIN  |
    ----------------------
        - Now, right outer join is the opposite, right? 
        
        - It gives me all the rows from the right side table and NULL for non‑matching left side table rows. 
        
        - IMPORTANT
            - We're still using the relational system, but we're basically saying, if there isn't a match in the right hand table, 
              please return those rows

        Example: 
        - So what are the email addresses I have, including those emails I don't have a person for? 

            - IMPORTANT
                - Now, this is sort of an unusual query in that normally we wouldn't have a system that would allow the tables to get 
                  into such a state, right? How could we have an email address and not a person associated with it? So this is sort of more 
                  of a hypothetical example in this case. But in the real world, this is definitely possible in many database designs. 
*/
SELECT p.first_name, p.last_name, e.email_address FROM person p
    RIGHT OUTER JOIN email_address e ON p.person_id = e.email_address_person_id;


/* 
    -----------------------
    |   FULL OUTER JOIN   |
    -----------------------
        - This is essentially a merge of LEFT OUTER JOIN & RIGHT OUTER JOIN
        
        - IMPORTANT
            - This particular syntax does not work in MySQL. MySQL just does not support full outer join. 
            
            - It is part of the SQL standard. For whatever reason, they've decided not to support it. 
            
            - There is a workaround for this if you need to do this in MySQL. But this is actually a fairly uncommon kind of query, 
              and so I wouldn't go out of your way trying to do it. Just remember that it exists and it's possible.

        Example: 
            - What are all my contacts and their email addresses, including the ones missing an email address and the ones with an 
              email address missing a contact?
*/
SELECT p.first_name, p.last_name, e.email_address FROM person p
    FULL OUTER JOIN email_address e ON p.person_id = e.email_address_person_id;


/* 
    -----------------
    |   SELF JOIN   |
    -----------------
        - Now, self isn't a keyword, right? It's just this idea that I can join a table to itself. 
        
        - This is kind of odd, but it actually is sometimes useful. Now, there's no special syntax for this. The usefulness is often 
          the case where you have a table that's hierarchical, right. 
            - So let's think of the person table where maybe not only am I keeping track of people, but I'm keeping track of who each 
              individual persons superior is or manager is, right. 
              
            - So the person table then might have another key, which is a foreign key back to itself, which is for this particular person, 
              what is the ID of that person's manager? And then a self join would allow you to be able to find the person and that person's manager. 
        
        - Okay, so we're just going to put the same table name on the left and right side of the joint. And this can work for any of the 
          joint that we've talked about, right, it's not specific to a particular kind of join. It's more of a conceptual way to query data 
          where you've got the relational system working in sort of a recursive fashion against the table itself.

        Example: 
            - What are all my contacts and their email addresses, including the ones missing an email address and the ones with an 
              email address missing a contact?
*/


/* 
    -----------------------------
    |          SUMMARY          |
    -----------------------------

    - Joins are the way that we really make the relational model come to life. 
    
    - The relational model is about having data separated out, normalized into multiple tables, but then able to bring it back 
      together again when we want to see those relationships, and the different kinds of joins allow us to do that in slightly different ways.
*/




