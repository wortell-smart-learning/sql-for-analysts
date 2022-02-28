# PIVOT and UNPIVOT

* pivot + voorbeeld

* unpivot + voorbeeld

* Challenge: unpivot meerdere kolommen (APPLY voorbeeld aanhalen, links verwijzen)

## PIVOT

With `PIVOT`, you can turn rows into columns. 

A small example is provided on [https://docs.microsoft.com/en-us/sql/t-sql/queries/from-using-pivot-and-unpivot?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/t-sql/queries/from-using-pivot-and-unpivot?view=sql-server-2017)

1. Use `PIVOT` to turn rows into columns

* Find the minimum ModifiedDate for every product category

* The product categories (Bikes, Components, Clothing, Accessories) should be displayed as columns

* The result should contain only one row

* Use `PIVOT`


2. Try to achieve the same, but this time without `PIVOT`


3. Now try to extend the query *with* `PIVOT`: display the total sales per year per product category

   * Columns: 

     * OrderYear, 

     * Bikes

     * Components

     * Clothing

     * Accessories

   * Use `SalesOrderHeader.TotalDue` for the total sales, and `SalesOrderHeader.OrderDate` to get the order year.

Expected result set:

| OrderYear | Bikes          | Components     | Clothing       | Accessories   |

|-----------|----------------|----------------|----------------|---------------|

| 2013      | 506859342,9843 | 459407387,8208 | 248559015,995  | 128142537,661 |

| 2014      | 177988977,456  | 137562176,3122 | 72965056,5847  | 51924553,043  |

| 2011      | 94334765,9073  | 36547927,9377  | 25064911,4966  | 14836129,6141 |

| 2012      | 410662322,0103 | 297051818,4436 | 195879878,3633 | 69183322,4115 |

You need the following JOIN to get everything together:

```sql

FROM [Production].[ProductCategory]

INNER JOIN Production.ProductSubcategory

    ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID

INNER JOIN Production.Product

    ON ProductSubcategory.ProductSubcategoryID = Product.ProductSubcategoryID

INNER JOIN Sales.SalesOrderDetail

    ON SalesOrderDetail.ProductID = Product.ProductID

INNER JOIN Sales.SalesOrderHeader

    ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID

```

## UNPIVOT

`UNPIVOT` is the almost-opposite of `PIVOT`. Opposite, because it turns columns into rows. Almost, because `PIVOT` does aggregations, and `UNPIVOT` cannot undo them.

Below is a small example from [https://docs.microsoft.com/en-us/sql/t-sql/queries/from-using-pivot-and-unpivot?view=sql-server-2017#complex-pivot-example](https://docs.microsoft.com/en-us/sql/t-sql/queries/from-using-pivot-and-unpivot?view=sql-server-2017#complex-pivot-example)

```

-- Create the table and insert values as portrayed in the previous example.  

CREATE TABLE pvt (VendorID int, Emp1 int, Emp2 int,  

    Emp3 int, Emp4 int, Emp5 int);  

GO  

INSERT INTO pvt VALUES (1,4,3,5,4,4);  

INSERT INTO pvt VALUES (2,4,1,5,5,5);  

INSERT INTO pvt VALUES (3,4,3,5,4,4);  

INSERT INTO pvt VALUES (4,4,2,5,5,4);  

INSERT INTO pvt VALUES (5,5,1,5,5,5);  

GO  

-- Unpivot the table.  

SELECT VendorID, Employee, Orders  

FROM   

   (SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5  

   FROM pvt) p  

UNPIVOT  

   (Orders FOR Employee IN   

      (Emp1, Emp2, Emp3, Emp4, Emp5)  

)AS unpvt;  

GO

```

4. Examine the example by executing it and querying intermediate results: 

* Notice the structure & contents of the table `pvt`

* Execute the `UNPIVOT`

* Can you get the same results without `UNPIVOT`?

## UNPIVOTing continued

5. Create a table as follows

name  |  age  |  gender

------|-------|---------

John  |   20  |    M

Jill  |   21  |    F

* Try to `UNPIVOT` the  table so that you get the following results.

* Try to get around some issues with `UNPIVOT`

name | column | value

-----|--------|-------

John |  age   |   20

John | gender |   M

Jill |  age   |   21

Jill | gender |   F

6. Use Google to see if there's a third way to "UNPIVOT" a result set without using `UNPIVOT`, but using `CROSS APPLY`.
