# Grouping and Aggregating

All queries should be executed & written against AdventureWorks2017 (not the LT database)


## Best-selling products

We start off by some analysis about the performance of our products.

1. What is the most expensive product we ever sold?


2. Which product has the highest margin (based on list price and standard cost)


3. Give the total sales per customer. Use `SubTotal` from `Sales.SalesOrderHeader` and the Customer's Name columns from `Person.Person`. The column `CustomerID`  in `Sales.SalesOrderHeader` points to `BusinessEntityID` in `Person.Person`.


4. Give the total sales per year `Sales.SalesOrderHeader`. Use the function `YEAR()` on top of the `OrderDate` column to split out the years. Make sure years aren't listed multiple times in your result set!


5. Give the total profit per year for Bikes only.


6. List the top 10 customers:

   * in number of products (so the customer who bought the most items from us is #1)

   * in variety of products (the customers who bought 10 million different items from us is #1)

   * in sales amount

   * in profitability

7. Return all customers who have more than 1 address registered. Include the following columns:

   * First name

   * Last name

   * Number of addresses


   * The length of the longest product name

   * The length of the shortest product name

   * The average length of the product name

*If you'd like, also add a standard deviation. Decide for yourself whether you use a sample or the population here*

