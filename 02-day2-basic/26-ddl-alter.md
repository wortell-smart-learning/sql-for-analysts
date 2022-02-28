# Altering tables

1. Add a new column `TotalListPriceForColor` to the table `Production.Product`


2. Update this column with data from the `Production.ColorValuation` table. Do this in the following steps:

   * First, create a SELECT statement that joins `Production.Product` to `Production.ColorValuation`

   * Then, re-write the SELECT statement as an `UPDATE .. FROM` (see yesterday's module about INSERT, UPDATE and DELETE)


```sql
-- Create your SELECT statement here
```


```sql
-- re-write your SELECT statement as an UPDATE
```


```sql
-- Check the results
```

3. Delete the column `TotalPrice` from `Production.ColorValuation`
sql

```

4. Add a column `TotalSales` to the table `Production.ProductCategory`
sql

```

5. Set the contents of the `TotalSales` so that no row is empty (and preferably with correct values)
sql

```

6. Alter the column `TotalSales` and set it non-nullable
sql

```
