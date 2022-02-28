# Challenge Assignment

Create a staging table for the `Production.Product` table from `AdventureWorks2017`:

* Create a new database (think about the logging level you want to have!)
* Use the CREATE TABLE statement from the table you want to stage
* Leave out all constraints, but keep datatypes the same
* Add two new columns:
  1. An identity column for the staging area
  2. A Load Date-Time Stamp
* Now, create a stored procedure that truncates and inserts this staging area from the source table


```python

```

## Bonus 1 - building a DW

> You can do the two bonus assignments apart from each other. This first bonus focuses on how to load historical data, the second bonus has a more technical take on SQL Server using `sys.tables` or the `INFORMATION_SCHEMA` views. Of course, you could do them both if you like.

In most Data Warehouses, you'll have not only a "staging" area, but also a "historical" layer. Create this layer:

* Table structure can be the same as in the staging area
* Write a stored procedure that inserts rows if they don't exist yet
* If you want to take this even further: alter the stored procedure for loading the staging areaso that it only loads rows that you don't have already in your history layer.


```python

```

## Bonus 2 - Generate ALL the things

> You can do the two bonus assignments apart from each other. The first bonus focused on how to load historical data, **this second bonus has a more technical take on SQL Server using `sys.tables` or the `INFORMATION_SCHEMA` views**. Of course, you could do them both if you like.

Creating a staging area is pretty repetitive and boring work. So, automate it. Basically this is an extended version of the bonus assignment from [Programming and variables](42-programming-and-variables.ipynb).

* Create a stored procedure that generates `CREATE TABLE` statements in the way described in [Programming and variables](42-programming-and-variables.ipynb).
* This time, don't iterate over some metadata-table, but just use the input of `sys.tables` (filter on type `USER`).
  * Start with one particular table
  * then extend it to a complete schema
* Start with two bogus columns (`Id` and `Name`) inside each `CREATE TABLE` statement
* If that succeeds, extend it to the "real" columns. 
* Don't try to boil the ocean: it would be pretty impressive if you generated `CREATE TABLE` statements containing only all `VARCHAR`, `NVARCHAR` and `INT` columns. Just leave out any datatypes you don't recognize at once.
* If the output doesn't fit, call on me for some tricks. (You can set a larger output in SSMS for instance).

