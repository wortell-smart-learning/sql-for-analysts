# Creating tables

1. Create a Table named `Production.ColorValuation`, with the following columns:

   * Color. This column will contain the same colors as used in the `Production.Product` table

   * NumberOfOccurences. The times a given color is listed will be stored here. Expect large, but not too large values (more than 100.000 times is pretty unlikely)

   * TotalPrice. Here you will store the sum of the listprices of all products added together. Very useful indeed.

All columns except *Color* may be empty.


2. Insert the following rows, and verify they fit into the table:

| Color      | NumberOfOccurences | TotalPrice |

|------------|--------------------|------------|

| Red        | 42                 | NULL       |

| Blue       | NULL               | 31         |

| Yellow-ish | 11                 | 7          |


3. Delete the rows again.


The syntax of `INSERT` we used until now was something like this:

```sql

INSERT INTO [schema].[table] (

    column1, 

    ..., 

    column_n

)

VALUES

(

    expression + for - column1,

    ...,

    CONCAT('another', expression+for, ' --> column_n!')   -- Because - as we now know - we aren't limited to columns or direct values, but can use expressions containing functions

)

```

However, instead of inserting data by hand using `INSERT INTO (...) VALUES`, we can also use the `INSERT ... SELECT` syntax:

```sql

INSERT INTO [schema].[table] (

    ..., 

    column_n

)

SELECT

    expression_for_column1,

    ...,

    expression_for_column_n

FROM (...) -- Here follows your regular SELECT syntax. FROM, JOIN, WHERE, GROUP BY as you like.

```

4. Use the `INSERT .. SELECT` syntax to insert data to the `Production.ColorValuation` table selected from the `Production.Product` table:

   * The number of rows belonging to each color

   * The sum of list prices for each color

   * `NULL` is not a color. And even if it was, you couldn't insert it into your table:-). Take care.


5. Using `Production.Product` combined with `Production.ColorValuation`, select the following information:

   * Product name

   * Color

   * List price

   * Percentage of the sum of all list prices for that color

