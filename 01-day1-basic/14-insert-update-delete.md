# Manipulating data

`SELECT` is by far the first and most used SQL keyword by any SQL user, in particular analysts. However, it will not help you to store, change or delete data within your database. In order to do that, you'll need different commands.

The three essential commands are:

* `INSERT` for inserting data into a table
* `UPDATE` to change data inside a table
* `DELETE` to delete data from a table

## Preparation

Connect to the `AdventureWorksLT` database, and execute the following script. This will create some tables we can safely use without messing with the original database.


```sql
IF OBJECT_ID('dbo.myCustomers', 'U') IS NOT NULL
  DROP TABLE dbo.myCustomers;

CREATE TABLE dbo.myCustomers (
    CustomerID BIGINT IDENTITY(1,1) NOT NULL
    , CustomerName NVARCHAR(20)
    , CustomerAge INT
    , CustomerBirthdate DATE
);
```

Check if there are any rows inside the table `dbo.myCustomers`. Use the cell below to write a `SELECT` query to check this.

## Inserting data

The basic INSERT statement has three components: a table, a column list, and a values list.

It works as follows:

```sql
INSERT INTO [schema].[table] (columnname1, ..., columnname_n_)
VALUES ('value_for_column1', ..., 'value_for_column_n_');
```

Test if can get this to work in the cell below. Insert two customers:

* Name: John, Age: 54
* Name: Sandra, Age: 36

**You don't have to specify all columns - only include the columns that you have values for (`CustomerName` and `CustomerAge`) - in the column list as well as in the `VALUES` list.**

Now, write a SELECT statement and check the contents of this table. 

* Are the results as expected?
* Try to explain any unexpected results


## Updates

As you've seen, the birthdates of John and Sandra were not available during the initial insert. To update these columns, we can use the `UPDATE` statement. In its most simple form, it looks like this:

```sql
UPDATE [schema].[table]
SET columnname1 = 'value_for_column1', ..., columnname_n_ = 'value_for_column_n_'
```

There's one problem with the statement above: it updates the specified columns *for all rows in the table*. In other words, when we used this "plain" `UPDATE` statement to set a birthdate, *all customers would get the same birthdate*.

Let's try this and set all customer's birth dates to 1-1-1965 (use '1965-01-01' as value):


<table><tr><th>CustomerID</th><th>CustomerName</th><th>CustomerAge</th><th>CustomerBirthdate</th></tr><tr><td>1</td><td>John</td><td>54</td><td>1965-01-01</td></tr><tr><td>2</td><td>John</td><td>36</td><td>1965-01-01</td></tr><tr><td>3</td><td>Sandra</td><td>36</td><td>1965-01-01</td></tr><tr><td>4</td><td>Maria</td><td>42</td><td>1965-01-01</td></tr></table>

In order to update only selected rows, we use the same mechanic as within the `SELECT` statement: `WHERE`. For example:

```sql
UPDATE [schema].[table] SET CustomerPolitics = 'Republican' WHERE CustomerName = 'John'
```

Use this construct to set the following values:

* For John: Birthdate 28-02-1965
* For Sandra: Birthdate 15-02-1983


Now correct Sandra's name to *Alexandra* (you can use the same column in the `WHERE` construct as in the `UPDATE .. SET` columnlist)


> As you can see, the `UPDATE` statement can affect a lot of rows at once. Therefor, you might want to check (with a `SELECT`) which rows your `UPDATE` would hit.  
> Although rewriting the basic `UPDATE` statement we just used into a `SELECT` statement is not that hard, it could easily introduce some non-intended errors.  
> Luckily, we can also write the `UPDATE` statement in an almost `SELECT`-like way:
>
> ```sql
> UPDATE [tablename] SET 
>    Column1 = 'value1'
>    , ...
>    , ColumnN = 'valueN'
> FROM [schemaname].[tablename]
> WHERE (etc.);
> ```
> 
> Now, we can replace the `UPDATE [tablename] SET` simply with `SELECT`, and a perfectly valid `SELECT` statement would remain, providing us with a view of the result of the `UPDATE` statement:
>
> ```sql
> SELECT
>    Column1 = 'value1'
>    , ...
>    , ColumnN = 'valueN'
>    -- You can add ", *" to include all original columns alongside with the updated ones
> FROM [schemaname].[tablename]
> WHERE (etc.);
> ```
> 
> We use a slightly different `SELECT` statement here, where each selected value (`'value1'` unto `'valueN'`) is given an *alias*. This is just the column header in your result set (usually you'd see your column names here).

## Delete

In order to remove rows from a table, we can use the `DELETE` statement. As no values or columns need to be provided (after all, we're only deleting *rows*, regardless of the columns or values within), the syntax is easier than `UPDATE` or `INSERT`:

```sql
DELETE
FROM [schemaname].[tablename];
```

As with the `UPDATE` statement, this statement would **delete all rows**. So, just like the `UPDATE` statement, we'll use the `DELETE` always in conjunction with `WHERE`:

```sql
DELETE
FROM [schemaname].[tablename]
WHERE (expression);
```

Delete the row with John from the table.

<table><tr><th>CustomerID</th><th>CustomerName</th><th>CustomerAge</th><th>CustomerBirthdate</th></tr><tr><td>1</td><td>John</td><td>54</td><td>1965-02-28</td></tr><tr><td>2</td><td>John</td><td>36</td><td>1965-02-28</td></tr><tr><td>3</td><td>Alexandra</td><td>36</td><td>1965-01-01</td></tr><tr><td>4</td><td>Maria</td><td>42</td><td>1965-01-01</td></tr></table>

<table><tr><th>CustomerID</th><th>CustomerName</th><th>CustomerAge</th><th>CustomerBirthdate</th></tr><tr><td>1</td><td>John</td><td>54</td><td>1965-02-28</td></tr></table>
