# Joins

There are several join types in SQL, and you can think of them in many ways. Whatever way you choose, remember that a `JOIN` is **not** a *lookup* operation!

## Setup code

```sql
-- Setup code
-- Creates tables we need just for this module / notebook
IF OBJECT_ID('dbo.ProductCategory', 'U') IS NOT NULL
  DROP TABLE ProductCategory;

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
  DROP TABLE Product;

SELECT *
INTO ProductCategory
FROM (
    VALUES (1, 'Bikes'), (2, 'Cars')
) AS ProductCategory (categoryId, categoryName)

SELECT *
INTO Product
FROM (
    VALUES (1, 1, 'Bicycle')
    , (2, 1, 'Tricycle')
    , (3, 2, 'Station wagon')
) AS Product (productId, productCategoryId, productName);
```


## Cartesian product

The mother of all joins is the `CROSS JOIN`, or the *cartesian product*. This is a somewhat technical term, but it simply means "all possible combinations of rows"

> When you have two tables and create all possible combination of rows, you've got a *cartesian product*.

So what does this look like?

Let's say we've got two tables: `Product` and `ProductCategory`. They look like this:

| productId | productCategoryId | productName   |
|-----------|-------------------|---------------|
| 1         | 1                 | Bicycle       |
| 2         | 1                 | Tricycle      |
| 3         | 2                 | Station wagon |

| categoryId | categoryName |
|------------|--------------|
| 1          | Bikes        |
| 2          | Cars         |

Now the *cartesian product* is just all possible combinations of rows:


| categoryId | categoryName | productId | productCategoryId | productName   |
|------------|--------------|-----------|-------------------|---------------|
| 1          | Bikes        | 1         | 1                 | Bicycle       |
| 2          | Cars         | 1         | 1                 | Bicycle       |
| 1          | Bikes        | 2         | 1                 | Tricycle      |
| 2          | Cars         | 2         | 1                 | Tricycle      |
| 1          | Bikes        | 3         | 2                 | Station wagon |
| 2          | Cars         | 3         | 2                 | Station wagon |

To achieve this in SQL, you can use the `CROSS JOIN` clause:

```sql
SELECT
   ProductCategory.categoryId
   , ProductCategory.categoryName
   , Product.productId
   , Product.productCategoryId
   , Product.productName
FROM ProductCategory
CROSS JOIN Product
```


<table><tr><th>categoryId</th><th>categoryName</th><th>productId</th><th>productCategoryId</th><th>productName</th></tr><tr><td>1</td><td>Bikes</td><td>1</td><td>1</td><td>Bicycle</td></tr><tr><td>1</td><td>Bikes</td><td>2</td><td>1</td><td>Tricycle</td></tr><tr><td>1</td><td>Bikes</td><td>3</td><td>2</td><td>Station wagon</td></tr><tr><td>2</td><td>Cars</td><td>1</td><td>1</td><td>Bicycle</td></tr><tr><td>2</td><td>Cars</td><td>2</td><td>1</td><td>Tricycle</td></tr><tr><td>2</td><td>Cars</td><td>3</td><td>2</td><td>Station wagon</td></tr></table>

... but now we'd like only to display the products alongside the categories they really *belong* to (so essentially rows 2, 4 and 5 are eliminated).

The most basic way of extending the query we wrote earlier would be as follows:


```sql
SELECT
   ProductCategory.categoryId
   , ProductCategory.categoryName
   , Product.productId
   , Product.productCategoryId
   , Product.productName
FROM ProductCategory
CROSS JOIN Product
WHERE ProductCategory.categoryId = Product.productCategoryId

```


<table><tr><th>categoryId</th><th>categoryName</th><th>productId</th><th>productCategoryId</th><th>productName</th></tr><tr><td>1</td><td>Bikes</td><td>1</td><td>1</td><td>Bicycle</td></tr><tr><td>1</td><td>Bikes</td><td>2</td><td>1</td><td>Tricycle</td></tr><tr><td>2</td><td>Cars</td><td>3</td><td>2</td><td>Station wagon</td></tr></table>

However, this way of writing is somewhat confusing: when reading from top to bottom, we essentially say first "we want to make a cartesian product", and then: "now filter it back".

The better way to write this is using an `INNER JOIN` with an accompanying `ON` clause.


```sql
SELECT
   ProductCategory.categoryId
   , ProductCategory.categoryName
   , Product.productId
   , Product.productCategoryId
   , Product.productName
FROM ProductCategory
INNER JOIN Product ON ProductCategory.categoryId = Product.productCategoryId
```


<table><tr><th>categoryId</th><th>categoryName</th><th>productId</th><th>productCategoryId</th><th>productName</th></tr><tr><td>1</td><td>Bikes</td><td>1</td><td>1</td><td>Bicycle</td></tr><tr><td>1</td><td>Bikes</td><td>2</td><td>1</td><td>Tricycle</td></tr><tr><td>2</td><td>Cars</td><td>3</td><td>2</td><td>Station wagon</td></tr></table>

## Using joins

1. Create a new query
2. Make sure you're connected to the `AdventureWorksLT` database with the same number as your student login (so if you're `student-1`, pick `AdventureWorksLT-1`)
3. Select the following columns from `SalesLT.Product`:
   * Name
   * Color
   * ListPrice
4. Notice the number of rows
5. Add the column `Name` from the table `SalesLT.ProductCategory` to the result set. 
   * The column `Product.ProductCategoryID` should match with `ProductCategory.ProductCategoryID`
   * The number of rows should stay the same
6. Notice the number of rows in `SalesLT.ProductCategory`
7. Introduce an error, but **do not execute the query yet**
   * Replace your `ON` clause with the clause `ON Product.ProductCategoryID = Product.ProductCategoryID`
   * How many rows do you expect?
8. Execute the query, and check your assumptions
9. Correct the query, so the result is identical to the result of step 7.

Let's say we're interested in the color of product we've sold in a particular month.

1. Write a query that joins the following tables. The columns to join on are called the same in all tables. The columns to select are listed below every table
   * `SalesLT.Product`
     * Name
     * Color
   * `SalesLT.SalesOrderDetail`
     * UnitPrice
   * `SalesLT.SalesOrderHeader`
     * OrderDate
2. Add a filter using a `WHERE` clause, so only orders with a `LineTotal` of greater than 203.3964 will be displayed
3. Add two expressions to your select list: one for month, one for year
   * The function `MONTH([name_of_date_column])` extracts a month number out of a date. For example, `MONTH('2019-12-31')` will yield `12`
   * The function `YEAR()` does the same for a year.
4. Extend the `WHERE` clause so that only results from June 2008 are displayed.
5. Extend the query so that the 10 orders with the highest Freight costs are displayed. You need to use `TOP(n)` in conjunction with the `ORDER BY` clause.


```sql
-- Cleanup code
-- Removes tables we only needed for this section / notebook

IF OBJECT_ID('dbo.ProductCategory', 'U') IS NOT NULL
  DROP TABLE ProductCategory;

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
  DROP TABLE Product;
```
