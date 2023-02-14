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

