# Set Operators

## Kinds of set operators

Set operators take two datasets with an identical form, and do something with them.

* `UNION ALL` glues together two sets

* `UNION` does the same, but only leaves unique rows

* `INTERSECT` gives the rows that exist in both datasets

* `EXCEPT` gives the rows that exist in the first dataset, but not in the second

## Preparation


```sql
IF OBJECT_ID('dbo.products1', 'U') IS NOT NULL

   DROP TABLE dbo.products1;

IF OBJECT_ID('dbo.products2', 'U') IS NOT NULL

   DROP TABLE dbo.products2;


INTO products1


    ('Audi', 'Car')

    , ('Skoda', 'Car')

) t (make, category);

SELECT *

INTO products2

FROM (VALUES
    ('Koga Myata', 'Bicycle')

    , ('Audi', 'Car')

) t (make, category);
```


(2 rows affected)

(2 rows affected)

```sql
SELECT * FROM dbo.products1;
```


(2 rows affected)


<table><tr><th>make</th><th>category</th></tr><tr><td>Audi</td><td>Car</td></tr><tr><td>Skoda</td><td>Car</td></tr></table>

(2 rows affected)


<table><tr><th>make</th><th>category</th></tr><tr><td>Koga Myata</td><td>Bicycle</td></tr><tr><td>Audi</td><td>Car</td></tr></table>

## Union all


```sql
SELECT * FROM dbo.products1


SELECT * FROM dbo.products2;
```


(4 rows affected)


<table><tr><th>make</th><th>category</th></tr><tr><td>Audi</td><td>Car</td></tr><tr><td>Skoda</td><td>Car</td></tr><tr><td>Koga Myata</td><td>Bicycle</td></tr><tr><td>Audi</td><td>Car</td></tr></table>

## Union


```sql
SELECT * FROM dbo.products1

UNION

SELECT * FROM dbo.products2;
```


(3 rows affected)


<table><tr><th>make</th><th>category</th></tr><tr><td>Audi</td><td>Car</td></tr><tr><td>Koga Myata</td><td>Bicycle</td></tr><tr><td>Skoda</td><td>Car</td></tr></table>

## Intersect


```sql
SELECT * FROM dbo.products1

INTERSECT

SELECT * FROM dbo.products2;
```


(1 row affected)


<table><tr><th>make</th><th>category</th></tr><tr><td>Audi</td><td>Car</td></tr></table>

## Except


```sql
SELECT * FROM dbo.products1

EXCEPT

SELECT * FROM dbo.products2;
```


(1 row affected)


<table><tr><th>make</th><th>category</th></tr><tr><td>Skoda</td><td>Car</td></tr></table>
