# Functions and APPLY


## Scalar functions

The most basic function group within T-SQL are *scalar functions*. They can accept multiple parameters, but return only a single value.

As a result, you can use them inside any SELECT statement.

You might have used one of these functions already:

* `GETDATE()`

* `NEWID()`

* `YEAR()`


## Table-valued functions

A second type of function is a *table-valued function*. Table-valued functions return, well, a *table*.

One way table-valued functions (TVFs) are used often in Data Warehousing is as *parameterized views*.

Below is an example for a historical table, and an accompanying TVF dat helps you to view the table *as it was on a certain point in time*.


```sql
IF OBJECT_ID('dbo.addresses') IS NOT NULL

    DROP TABLE dbo.addresses;

IF OBJECT_ID('dbo.address_at') IS NOT NULL

    DROP FUNCTION dbo.address_at;

SELECT

    *

INTO dbo.addresses
FROM (VALUES 

    ('Koos', 'Wilnis', '1986-12-24', '2005-08-31')

    , ('Koos', 'Amsterdam West', '2005-08-31', '2006-05-15')

    , ('Koos', 'Wilnis', '2006-05-15', '2006-10-30')

    , ('Koos', 'Amsterdam Oud-Zuid', '2006-10-30', '2010-05-25')

    , ('Koos', 'Amsterdam Centrum', '2010-05-25', '2011-04-20')

) AS customer ([Name], City, StartDate, EndDate);

GO

CREATE FUNCTION address_at(@date DATETIME2) 

RETURNS TABLE

AS 

RETURN

SELECT * 

FROM dbo.addresses

WHERE StartDate <= @date AND EndDate > @date

GO

SELECT * FROM address_at ('2007-01-01')
```


(5 rows affected)


(1 row affected)


<table><tr><th>Name</th><th>City</th><th>StartDate</th><th>EndDate</th></tr><tr><td>Koos</td><td>Amsterdam Oud-Zuid</td><td>2006-10-30</td><td>2010-05-25</td></tr></table>

## Write a TVF

* Use the example above to write a table-valued function `dbo.productsWithinCategory`

* It should return all products inside a certain category

* The category should be provided via a parameter

* Bonus: if no category is provided, all products from all categories should be returned. You don't need an `IF` statement to achieve this.


## Using a TVF to "join" 

Now we want to see the average price of all product categories. Try the following:

* Select all product categories from the `Production.ProductCategory` table

* Join to the table-valued function you just created `dbo.productWithinCategory`

Can you get it to work? (Hint: you shouldn't, but try it nonetheless)


## APPLY

Just above, you tried to:

1. Create a result set using a TVF that you provided with a parameter. The contents of this parameter came from a table.

2. But, because you used a `JOIN`, at the same time the table that provided the parameter needed to be filtered by the results of the TVF

Of course, you could think up a way to programmatically work around this. In SQL, this is done using the `APPLY` construct. Basically:

* If you want to `INNER JOIN` a TVF, but the value of the parameter(s) come from within your dataset, you use a `CROSS APPLY` statement

* If you want to `LEFT JOIN` a TVF, but the value of the parameter(s) come from within your dataset, you use an `OUTER APPLY` statement

Because the TVF is itself already filtered using the parameters, you don't need an `ON` clause here.

Re-try the following:

* Select all product categories from the `Production.ProductCategory` table

* APPLY the table-valued function you just created `dbo.productWithinCategory`

