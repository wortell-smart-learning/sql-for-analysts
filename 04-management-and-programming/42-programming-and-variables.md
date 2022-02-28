# Programming and variables

## Batches

1. Create a simple table called `dbo.ListOfNames` with 2 columns:

   * one Id (type INT, IDENTITY)

   * one Name, type VARCHAR(30)


2. Insert a single row in it. Terminate the statement with GO

   * name should be 'Koos'. Or your own name. Or anything else.


3. Examine the contents of the table


4. Copy and paste the query from question 2, but now replace the `GO` with `GO 10`. Examine the results


```sql
-- same query as 2, but now with a GO 10
```


```sql
-- examination of the `dbo.ListOfNames`
```

The `GO` statement separates *batches*: the lines SQL Server will try to grok and execute. 

By providing a number after `GO` (for example `GO 10`), the batch is executed that number of times.

## Variables

To store data for the duration of one batch, you can use a *variable*.

5. For example, try the commands below and see what happens.
   * First, describe what you expect to see when you "just" read the syntax for every line (guesses are ok!)
   * Then, execute the code.
   * Notice that you cannot execute the line-by-line: 
      * Executing only the first line will be ok
      * Executing only the second line will yield an error: you are now in a new *batch*, so the variable you declared in an earlier batch has disappeared
   * Therefor, instead of line-by-line you should execute the code from start until the line you want to see the results of.
      * So if you want to see the results of line 2, you execute both line 1 AND 2.

```sql

DECLARE @name VARCHAR(30);

SET @name = 'Koos';

SELECT @name;

SELECT @name = 'Inge';

PRINT @name;

DECLARE @anotherName VARCHAR(30) = 'Sanne';

```


### Variables part 2

6. Write a script using the following steps:

   * Retrieve the *BusinessEntityId* of the salesperson with the highest amount of sales according to SalesOrderHeader

   * Store the *BusinessEntityId* in a variable

   * Retrieve and display the first- and last name of this salesperson based on the variable

   * As a bonus, not only display the first and last name, but also the amount of sales this person made. Use a second variable for this figure.


## Conditional logic with IF-statements

7. Write a small SQL-script on `AdventureWorks2017`. Use an `IF` statement for the conditional logic

* Declare a variable `@gender` of type `CHAR(1)`

* If `@gender` = 'F', then execute the following query:

```sql

SELECT

* 

FROM [HumanResources].[Employee]

WHERE [Gender] = 'F'

```

* Otherwise, execute the same query, but without any filter on `[Gender]`:

```sql

SELECT

* 

FROM [HumanResources].[Employee]

WHERE [Gender] = 'F'

```


8. (Bonus) the script above can be rewritten without having to use an `IF` statement.

   * Write the script without the `IF` statement

   * Why would you choose one over another?


9. One particular case where an IF-statement is useful, is to ensure the repeatability of your scripts.

   * Rewrite the `SELECT` statement below so that it outputs data into the temporary table `#femaleEmployees`

   * Don't use any `CREATE TABLE` statements

   * If you don't know how to do this, have a look at [this page (link)](https://bit.ly/2kYbIjc).

   

The script you just wrote can be executed only once. The second time you execute this script, it will fail: the temporary table already exists.

> Unlike a variable, a temporary table will remain after your *batch* has completed. It will be removed as soon as your *connection* is dropped.

   * Now, add a `DROP TABLE` statement at the top of your script:

```sql

DROP TABLE #femaleEmployees;

```

Now you can re-execute the script. In some sense, it's repeatable now. However..

   * Open a new query window, and execute the complete script

As you see, now the script fails the first time. The table doesn't exist yet, so you cannot drop it!

This particular case can be solved easily using an `IF` statement that checks if the table exists already

   * The way to check if any object in a database exists is using the `OBJECT_ID` function

   * For temporary tables, have a look at [this second hit from the Google search 'Check if temporary table exists in SQL'](https://bit.ly/2l37OFU) (or execute the search yourself)

   * Add this little snippet, and check in a new query window 

     1. that it works the first time

     2. that it can be re-executed


## Program flow (WHILE)

The `WHILE` function checks if a condition is true. As long as the condition is true, it keeps executing a code block:

```sql

DECLARE @number INT = 0;

WHILE @number < 10 

BEGIN

    PRINT 'Hi!';

    PRINT @number;

    SET @number = @number + 1;

END;

```

This can be great for generating demo workloads or fake data, just to stress-test your system.

10. Use a `WHILE` loop to generate fake data

    * Create a temporary table called `#students`

        * Two columns, `Id` (bigint, identity) and `Name` (`varchar(30)`)

    * Write a `WHILE` loop to insert 10.000 rows (use the sample above as a pattern)

    * Every student name should be 'Student *n*', where *n* is the number of the iteration

    * The first student should be 'Student 1' (not 0!), the last 'Student 10000'


## Looking for a challenge?

**If you're finished early, find everything above pretty easy, or just want some extra challenge, this part could be useful. In all other cases, just skip it.**

A `WHILE` statement can help to iterate (loop) over a given block of code (the "block" is from `BEGIN` to `END`) while re-evaluating the condition (in the example above, `@number < 10`). However, it is often useful to be able to iterate not with a static condition, but based on the contents of a table.

A construction to iterate over the contents of a table is a `CURSOR`. It isn't the most straightforward syntax, but can be very useful.

You can read more about cursor on [http://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-cursor/](http://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-cursor/).

> Keep in mind that in most cases (implementing business rules, data analysis etc.), **cursors are not the answer**. The row-based approach is something that a relational database engine like SQL Server simply is not designed to do. 

> 

> In other cases, cursor may come in very handy. For example, when you're managing many tables (you could iterate over `sys.tables`, filtering by schema using a `JOIN` to `sys.schemas` or name pattern using `LIKE`). Or when you're generating lots of DDL statements (combine the knowledge about `sys.tables` with `PRINT` statements and `VARCHAR` variables to "build" SQL-statements).

> 

> Basically, this is a way to program using the database. Sometimes useful, but be careful :-)

### Bonus: DDL-generation using metadata and cursors

10. Create a metadata-table and generate some tables with it

    * Declare a variable `@sqlToExecute` of type `VARCHAR(MAX)`

    * Create a small (temporary?) table that contains your metadata

      * Two columns:

      * Id (bigint, identity)

      * Schema (sysname)

      * TableName (sysname)

    * Insert table five rows

| schema | tablename         |

|--------|-------------------|

| dbo    | cursorcustomers   |

| dbo    | cursorproducts    |

| dbo    | cursoremployees   |

| dbo    | cursorsales       |

| dbo    | cursorotherthings |

    * Create a cursor to iterate over these rows. Inside the cursor:

      * Clear the variable `@sqlToExecute`

      * Fill the variable with a new SQL Statement: `CREATE TABLE [(schemaname)].[(tablename)]`

      * Add two columns in this SQL statement (use your creativity for column names and datatypes)

      * Execute the SQL code inside `@sqlToExecute`. You can do this using [sp_executesql (link to MSFT docs)](https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-executesql-transact-sql?view=sql-server-2017).

    * Make sure your script is repeatable (if the tables already exist, they should be dropped)

