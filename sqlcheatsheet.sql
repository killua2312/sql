-- 1. Fundamentals
-- What is a database?
--      A database is an organized collection of data that is stord in a computer system.
--       It allows users to easily access, manipulate and retrieve data in a structured and efficient way.

-- What is DBMS?
--      DataBase Management System is software system that allows users to create, manipulate and manage databases, as well as
--      mechanisms to ensure integrity and security of the data. It also provide query language that allows users to search and
--      analyze data in the database.

-- What is a relation?
--      A relation refers to a table that contains data in rows and columns, where rows represents single record and column
--      represents specific attributes or charactersitics of that record. The term "relation" is often used interchangeably with
--      "tables" in the context of relational databases.

-- What is RDBMS?
--      Relational DataBase Management Systems is a type of database management system where that uses a relational model for 
--      organizing and managing data. In RDMS, data is stored in tables or relations, which are connected to each other through
--      common fields or keys. RDBMS ensures the accuracy, consistency and security of data and they typically use Structured
--      Query Language(SQL) as a standard language for manipulating and managing the data.

-- What is SQL?
--      Structured Query Language is standard language used to manage and manipulate the Relational DataBase Mangement Systems(RDBMS).
--      SQL provides a wide range of commands and functions for creating and modifying databases, inserting, updating and deleting data
--      querying and analyzing.

-- Different components in sql
--  Data Definition Language(DDL): used to define the structure of databse schema, including creating, altering and dropping tables, indexes
--                                 constraints.
--  Data Manipulation Language(DML): used to manipulatie data in the databases, including inserting, updating, deleting and querying data.
--  Data Control Language(DCL): used to control access to the database, including granting and revoking privileges to users and setting up
--                              security and authorization rules.
--  Transaction Control Language(TCL): used to control transactions in the database, including committing or rolling back changes made in the database.
--  Stored Procedures and Functions: used to encapsulate frequently used code and login in the database and make it available for future use.
--  Triggers: used to automatically execute a set of SQL commands when certain events occur, such as insert or update to a table.




-- 2. Tables and Fields
-- What is a Table?
--      A Table is a collection of data that is organized into rows and columns. Each row in table represents a single record or data point,
--      While each column represents a specific attribute or characteristics of that record.Tables can be related to other tables through common
--      fields or keys. Tables are created using Data Definition Language(DDL) commands in sql and modified using Data Manipulation Language(DML) commands.

-- What is a Field?
--      A Field corresponds to a single column in a table and represents a specific attribute or characteristic of the records in a table.
--      The term "field" is sometimes interchangeably with "attribute" or "column".

-- Info on an table:
-- In postgresql:
\d+ table_name;
-- In MySQL:
DESCRIBE table_name or DESC table_name;

-- CREATE A TABLE
CREATE TABLE table_name (
    column_name data_type constraints
);
-- example
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE TABLE employees (
   id SERIAL PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   department VARCHAR(50) DEFAULT 'Unknown',
   salary DECIMAL(10, 2) CHECK (salary > 0),
   hire_date DATE NOT NULL DEFAULT now(),
   CONSTRAINT emp_dept_ck CHECK (department IN ('Sales', 'Marketing', 'IT')),
   CONSTRAINT emp_salary_ck CHECK (salary <= 100000),
   CONSTRAINT emp_name_unq UNIQUE (name),
   INDEX emp_dept_idx (department),
   FOREIGN KEY (manager_id) REFERENCES employees(id)
);


-- a. By adding new fields
ALTER TABLE category
ADD COLUMN phone VARCHAR(12);

-- b. By removing existing field
ALTER TABLE category
DROP COLUMN phone;

-- c. By modifying existing field
ALTER TABLE table_name
RENAME column_name
TO new_column_name;

ALTER TABLE table_name
ALTER COLUMN column_name
[SET DEFAULT value | DROP DEFAULT];

ALTER TABLE table_name
ALTER COLUM column_name
[SET NOT NULL | DROP NOT NULL];

-- DROP A TABLE
DROP TABLE table_name;
DROP TABLE IF EXISTS table_name;
DROP TABLE [IF EXISTS] table_name
[CASCADE | RESTRICT]; -- use CASCADE option to drop a table and all of its dependent objects.




-- 3. KEYS AND CONSTRAINTS
-- Primary Key
--      A primary key is a column or group of columns that uniquely identifies each row in that table.
--      when a primary key is defined, the database automatically creates an index on the primary key column
--      or columns for faster querying and sorting.
--      A primary key is used to link tables together using foreign keys, and it is used as a refernce in the
--      other tables that may have a relationship to the primary key.

CREATE TABLE students (
    student_id INT PRIMARY KEY, -- Primary key as a single column
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    CONSTRAINT ck_gender CHECK (gender IN ('M', 'F')), -- Check constraint
    CONSTRAINT pk_student_info PRIMARY KEY (last_name, first_name) -- Composite primary key
);


-- Foreign Key
--      A Foreign key is a column or set of columns that refers to the primary key of another table to eshtablish
--      relationship between two tables. A foreign key is used to enforce referential integrity, which means that
--      the data in one table must correspond to the data in another table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- Unique Key
--      Unique key is a database constraint thet ensures that the values in a column or group of columns are unique
--      across all the rows. It is same as primary key but the unique key allows one null value in the column where as
--      primary key cannot contain null values.
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    product_code VARCHAR(20) UNIQUE,
    price DECIMAL(10,2) NOT NULL
);


-- Candidate Key
--      Candidate key is a column or set of columns that can be used as a primary key. It is unique and not null, but it may
--      not have been designated as primary key. A table can contain multiple candidate keys.

-- Alternate Key
--      An Alternate key is a candidate key that is not selected as primary key. It is still unique and not null, but it cannot
--      be identified as primary identifier.

-- Composite Key
--      A Composite Key is a key that is made two or more columns.

-- Super Key
--      Super key is set of columns that can be used to uniquely identify a row in table. It may include more columns than necessary,
--      but it ensures uniqueness.

-- These Keys are used for integrity and improve performance.

-- NOT NULL constraint
--      The NOT NULL constraint is used to ensure that a column in table does not contain any null values.

-- DEFAULT constraint
--      The DEFAULT constraint is used to provide a default value for a column in table when no value is explicitly specified for that
--      column in an INSERT statement.
CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(50) NOT NULL,
    cust_email VARCHAR(50) DEFAULT 'noemail@example.com',
    join_date DATE NOT NULL
);

-- CHECK constraint
--      CHECK constraint used to restrict the values that can be inserted or updated in a column based on a specific condition or set of conditions.
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT chk_total_amount CHECK (total_amount > 0)
);





-- 4. NORMALIZATION AND DATA MODELING
-- What is Normalization?
--      Normalization is the process of organizing data in a relational database in such a way that it reduces redundancy and dependency, and improves
--      data integrity and efficiency. The main goal of normalization is to eliminate data duplication and inconsistencies.
--      The process of normalization involves breaking down table into smaller and more specific tables that have clear and logical relationship with
--      one another.

-- What is Denormalization?
--      Denormalization is the process of intentionally adding redundancy to a database design to improve performance or simplify quries.
--      This involves delibirately violating the normalization rules in order to improve query performance, reduce the number of joins needed
--      to retrieve data, or otherwise optimize database design.

-- Different Normalization Forms (NF)
--      First Normal Form (1NF): This level requires that each table has primary key, and that each column in the table contains atomic values.
--      Second Normal Form (2NF): This level requires that each non-key attribute in the table is fully dependent on the primary key.
--      Third Normal Forma (3NF): This level requires that each non-key attribute in the table is independent of other non-key attributes.
--                                In other words, each non-key attribute should be dependent only on primary key, and not on any other non-key
--                                attribute in the table.
--      Boyce-Codd Normal Form(BCNF): This level is similar to 3NF, but it requires that each determinant (a column or set of columns that determines
--                                    the value of another column) be a candidate key. In other words, each non-key attribute should be dependent on the
--                                    candidate key, and not just part of it.
--      Fourth Normal Form(4NF): This level requires that each non-key attribute in the tables is independent of other non-key attributes, as well as
--                               any non-key attribute that is not functionally dependent on the primary key.

-- Different types of table relationships:
-- One-to-One Relationship: In this relationship, each record in one table can be related to only one record in another table, and vice versa.
CREATE TABLE Person (
    ID int PRIMARY KEY,
    First_Name varchar(255) NOT NULL,
    Last_Name varchar(255) NOT NULL
);

CREATE TABLE Passport (
    ID int PRIMARY KEY,
    Person_ID int UNIQUE,
    Passport_Number varchar(255) NOT NULL,
    FOREIGN KEY (Person_ID) REFERENCES Person(ID)
);

-- One-to-Many Relationship: In this relationship, each record in one table can related to one or more records in another tables, but each record
--                           in another table can be related to only one record in one table.
CREATE TABLE Customer (
    ID int PRIMARY KEY,
    First_Name varchar(255) NOT NULL,
    Last_Name varchar(255) NOT NULL,
    Email varchar(255) NOT NULL
);

CREATE TABLE Order (
    ID int PRIMARY KEY,
    Order_Date date NOT NULL,
    Amount decimal(10,2) NOT NULL,
    Customer_ID int NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(ID)
);

-- Many-to-Many RelationshipL In this relationship, each record in table one can be related to one or more records in table two and vice versa.
CREATE TABLE Artist (
    ID int PRIMARY KEY,
    Name varchar(255) NOT NULL,
    Genre varchar(255) NOT NULL
);

CREATE TABLE Album (
    ID int PRIMARY KEY,
    Title varchar(255) NOT NULL,
    Release_Date date NOT NULL,
    Artist_ID int NOT NULL,
    FOREIGN KEY (Artist_ID) REFERENCES Artist(ID)
);

CREATE TABLE Album_Artist (
    Album_ID int,
    Artist_ID int,
    PRIMARY KEY (Album_ID, Artist_ID),
    FOREIGN KEY (Album_ID) REFERENCES Album(ID),
    FOREIGN KEY (Artist_ID) REFERENCES Artist(ID)
);





-- 5. TRANSACTION
-- What is DML?
--      Data Manipulation Language is sub-language of SQL that is used to perform data manipulation operation on database tables, such as
--      updating, inserting, deleting and selecting.

-- Different DML operations
--      SELECT: retrieve data from a table
--      INSERT: adds new data to a table
--      UPDATE: modifies existing data in a table
--      DELETE: removes data from a table

-- What is transaction?
--      Transaction is a logical unit of work in database that consists of one or more operatons as a single, indivisible unit.
--      Transaction ensures that all operations are completed successfully, or none of them are completed at all.
--      Transaction is used to ensure data integrity and consistency in coomplex database systems.

-- What is ACID property?
--      ACID is an acronym for Atomicity, Consistency, Isolation and Durability.
--      Atomicity: This property ensures that a transaction is treated as single, indivisible unit of work. The operation in a transaction
--                 must either all succeed or all fail. There should be no partial execution of a transaction.
--      Consistency: This property ensures that a transaction takes the database from one valid state to another valid state.
--                   The database should always be consistent before and after the transaction.
--      Isolation: This property ensures that concurrent transactions do not interfere with each other. Each transaction should be executed
--                 independently and as if it is the only transaction running.
--      Durability: This property ensures that once a transaction is committed, its effects are permanent and will survive any subsequent failure
--                  of the system. The changes made by the transaction must be stored in non-volatile storage to ensure they are not lost in case
--                  system failure.

-- What is TCL?
--      Transaction Control Language is a sub-language of SQL that is used to control the transactions in database. TCL commands allows you to manage
--      transactions and ensure they are processed reliably and consistently.
--      Three main TCL commands are:
--      COMMIT: This command saves all the changes made to the database during the current transaction and ends the transaction. The changes made permanent
--              and can be seen by other transactions.
--      ROLLBACK: This command undoes all the changes made to the database during the current transaction and ends the transactions. It restores the database
--                to its previous state before the transaction started.
--      SAVEPOINT: This command creates a savepoint within a transaction that allows you to undo only a part of the transaction. You can rollback to specific
--                 savepoint wihtout undoing the entire transaction.

-- How to create a SAVEPOINT?
    SAVEPOINT savepoint_name;

    -- FULL EXAMPLE
    BEGIN;

    -- Update the account balance
    UPDATE accounts SET balance = balance - 100 WHERE id = 123;

    -- Create a savepoint
    SAVEPOINT update_balance;

    -- Attempt to update the account balance again
    UPDATE accounts SET balance = balance - 200 WHERE id = 123;

    -- If the second update fails, roll back to the savepoint
    ROLLBACK TO update_balance;

    -- Commit the transaction
    COMMIT;


-- How to rollback changes?
    ROLLBACK;

    -- Full Example
    BEGIN;

    -- Update the account balance
    UPDATE accounts SET balance = balance - 100 WHERE id = 123;

    -- Attempt to update the account balance again
    UPDATE accounts SET balance = balance - 200 WHERE id = 123;

    -- If the second update fails, roll back the transaction
    ROLLBACK;

    -- Commit the transaction
    COMMIT;

-- How to commit changes?
    COMMIT;

    -- Full Example
    BEGIN;

    -- Update the account balance
    UPDATE accounts SET balance = balance - 100 WHERE id = 123;

    -- Update the transaction history
    INSERT INTO transaction_history (account_id, amount, type) VALUES (123, 100, 'debit');

    -- Commit the transaction
    COMMIT;





