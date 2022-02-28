# Challenge - day 1

## Introduction

During the course until this moment, we've encountered various parts of the SQL language:

* SELECT statements

  * Sorting 

  * Filtering

* Joins

  * Carthesian products (cross join)

  * Inner join

  * Outer joins:

    * Left

    * Right

    * Full

* Insert

* Update

* Delete

In the "Challenge", the various parts come together: you'll have to apply the several parts together to solve these little "puzzles".

## About the AdventureWorks database

In this "Challenge", we'll use the *AdventureWorks2017* database. This database has a lot of tables and schemas, so maybe you won't find everything at once. Some ways to explore the data structures:

* Use the "Search" functionality in Azure Data Studio (double click on a database name to open the *Database Dashboard* with a *Search* box in it)

* Google for the AdventureWorks 2017 Diagram (but don't spend too long staring to these pictures)

* Ask someone else (last resort: the trainer)

## Puzzles

### Persons and addresses

We work with the following tables:

* `Person.Person`

* `Person.BusinessEntityAddress`

* `Person.Address`

You should know that the `AdventureWorks` source systems sometimes use system-wide unique keys. They call this a `BusinessEntityID`. For example, within the `Person.Person` table, the `BusinessEntityID` means the same as `PersonID`.

1. Find out the number of persons within the database. 

   * How many distinct BusinessEntityID's do you have?


2. Join `Person.Person` via `Person.BusinessEntityAddress` towards `Person.Address`. Include only persons with addresses.

   * How many rows do you see? 

   * How many distinct BusinessEntityID's do you have left?


3. Join `Person.Person` via `Person.BusinessEntityAddress` towards `Person.Address`. Include all persons, with or without addresses. Exclude addresses without persons attached.

    * How many rows do you see?

    * Check that the distinct of unique BusinessEntityID's is the same as in puzzle #1


4. Join `Person.Person` via `Person.BusinessEntityAddress` towards `Person.Address`.

   * In the `JOIN` clause, include all persons, with or without addresses 

   * In the `WHERE` clause, filter on customerse *without* an address (you can check for *NULL* values using `WHERE [column_name IS NULL]`)


### Sales

We add the following tables to work with:

* `Production.Product`

* `Production.ProductSubcategory`

* `Production.ProductCategory`

* `Sales.SalesOrderDetail` (contains order rows / line items: quantity, product, price, discount, etc.)

* `Sales.SalesOrderHeader` (contains order-level items: shipping cost, total due, date ordered, etc.)

*Know that you can join a Customer stored in `Person` to `SalesOrderHeader` via `Person.BusinessEntityID = Customer.PersonID` and `Customer.CustomerID = SalesOrderHeader.CustomerID`*

5. Get all orders (stored in `SalesOrderHeader`) placed by any customer with the name `Mary`


6. Get all distinct colors of products that were ordered by any customer with the name `John`

   * You'll need to navigate from `Person` to `SalesOrderHeader` to `SalesOrderDetail` to `Product`


7. Get all products that have never been sold (you can use the pattern of puzzle #4 here)


8. Get all distinct products with a list price larger than $ 200, that have ever been sold to persons with a Firstname starting with 'A'


9. Select the distinct list of product category names (inside the `ProductCategory` table)
    - Include only the product categories in which products are ever ordered by customers with a first name starting with 'M', and a last name ending with 'n', so for example:
        - Meghan I. Alan
        - Mackenzy Allen
        - Mary Allen
        - Mario J. Andersen
        - etc.


10. Insert a new ProductCategory. Define the following columns:

    * **Name**: `'Cars'`

    * **ModifiedDate**: `GETDATE()`

*Notice `GETDATE()`: this is a function within T-SQL and not a value, so you don't put quotes around it!*

**Check the ProductCategoryID of the category you just created**


11. Update the `ProductSubcategory` table, so that `Touring Bikes` is renamed to `Touring Cars`, and the *ProductCategoryID* column is filled with the *ProductCategoryID* from the "Cars" category created in puzzle #10.


12. Get all products where:

    * A person ordered the product whose first name started with 'M' and last name ended with 'n'

    * The Product Category is 'Cars'

*You should get 8 products*


13. Undo your changes introduced in puzzle #11: rename subcategory `Touring Cars` back to `Touring Bikes`, and update *ProductCategoryID* to 1 (Bikes) for these rows.


14. Delete the Product Category "Bikes"
