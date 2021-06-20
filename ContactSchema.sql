/* 
    This is the table that I will use for the practice examples in this directory

    IMPORTANT:
        - IDENTITY informs SQL Server to auto increment the numeric value within the specified 
          column anytime a new record is INSERTED

        - PRIMARY KEY forces the specified column to behave as a completely unique index for the 
          table, allowing for rapid searching and queries
*/


CREATE TABLE person IF NOT EXISTS (
    id            INT             NOT NULL    IDENTITY    PRIMARY KEY,
    first_name    VARCHAR(254)    NOT NULL, 
    last_name     VARCHAR(254)    NOT NULL 
);

INSERT INTO person (first_name, last_name) 
    VALUES ('John', 'Doe'),
           ('Alex', 'Nunez'),
           ('John', 'Snow'),     -- GOT referrence
           ('Alex', 'Macedon'),  -- Alexander the great AKA: Alexander III Of Macedon
           ('Sanyeris', 'Diaz');

/* 
    Resulting Table: person
        -----------------------------------------
        |   id  |   first_name  |   last_name   |
        -----------------------------------------
        |   1   |     John      |       Doe     |
        -----------------------------------------
        |   2   |     Alex      |     Nunez     |
        -----------------------------------------
        |   3   |     John      |     Snow      |
        -----------------------------------------
        |   4   |     Alex      |    Macedon    |
        -----------------------------------------
        |   5   |   Sanyeris    |      Diaz     |
        -----------------------------------------
*/

                                                 