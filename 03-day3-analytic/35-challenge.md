# Challenge

1. Create a table "SalesPerCustomerPerOrderyear" with the following columns:

   * ID (automatically incrementing)

   * First name (cannot contain NULL values)

   * Last name (cannot contain NULL values)

   * Order year (cannot contain NULL values)

You can leave the table empty for now.


```sql

Select the sales per customer per order year. 

* For example, A. Leonetti hasn't made any sales in 2012. Still, there should be a row for this customer in 2012, with 0 for the sales in that year

   * You can do this either by using a CTE, or a subquery inside your SELECT list


```

* First, use windowing version of the `SUM` aggregate to get the same results *without using `GROUP BY`*

   * Then, check if the results of those two queries are the same using `EXCEPT`


```


```sql

```

4. Extend the previous query once more:

* Include the total sales for that customer (regardless the sales person)

   * Give the sales for one sales person as a percentage of total sales in that year for the customer

   

For example, Aaron Con would yield the following results for 2011 and 2012:

---------|-----------|-----------------|------------|---------------------------|------------------------------|

| 2011      | Aaron Con | Michael  Blythe | 11043.5801 | 11043.5801                | 1.00                         |

| 2012      | Aaron Con | Michael  Blythe | 22055.7977 | 28435.0089                | 0.7756                       |

| 2012      | Aaron Con | Stephen  Jiang  | 4792.247   | 28435.0089                | 0.1685                       |


```


```sql

```

5. Alter the table of exercise 1 so that it can store the results from query #4


```sql

```

6. Store the results of exercise 4 inside the table using `INSERT .. SELECT`
