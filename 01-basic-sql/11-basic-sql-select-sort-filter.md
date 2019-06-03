# Introduction

In order to get data a from a SQL Server Database (and from loads of other databases), we need the `SELECT` statement. The syntax isn't hard, but good to start with.
We discussed the following things during the lecture & demos:

* `SELECT` to select expressions (like 1 + 1, or a column name)
* `SELECT` in combination with `FROM` to select rows from a table
* `TOP(10)` for the first 10 rows
* `*` for all columns inside a table
* column-delimited expressions that result in multiple columns
* `WHERE` for filtering rows

## Select: writing your first queries

* 

## First steps

Note that the following expressions are identical:

```sql
SELECT
  id
FROM customers
```

```sql
SELECT
  [id] -- square brackets are often used to identify database objects like columns, schemas and tables
FROM [customers]
```

```sql
SELECT
  "id" -- in SQL you can also use double quotes to identify database objects.
FROM "customers"
```

```sql
SELECT
  id
FROM [dbo].customers -- The [dbo] part here is the "schema" in which a table resides. When no schema is written down in the query, the default schema is used. Often, this is the "dbo" schema.
```

