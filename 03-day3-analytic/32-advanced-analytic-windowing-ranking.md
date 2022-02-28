# Windowing & Ranking

Use `AdventureWorks2017` as a database inside this notebook.

1. Select all orders in 2013, with the following information:

   * SalesOrderNumber

   * TotalDue

   * Difference with TotalDue of one item "cheaper"

     * In case of ties, this difference will be 0.

     * To keep your ordering correct order not only on TotalDue, but also on the ID column of the table you're using


2. Select all product sales, with the following information in each row:

   * Unit price * qty

   * Product name

   * Sales date

   * Percentage of total sales in year

   * Percentage of total sales in category


```sql

3. Select the top 5 performing sales person per category per year. Display the sales, category name, person first- and lastname, and rank. To tackle this:

   * First create a CTE to select the total sales per person, category and year

   * Then use windowing functions to rank (hint) the sales persons

   * Think up a way to filter only ranks 1-5


4. Select the top 10 orders placed per year, based on `TotalDue`


5. Select the 10 orders with the **lowest** `TotalDue` per year

   * Select OrderNumber, Rank, TotalDue

   * Include four kinds of rankings, with the following behavior when ties occur:

     * Keep the same ranking number, then skip the following ranks (2011 has two #4's, after that a #6)

     * Just keep counting (2011 has one of each #4, #5, #6)

     * Keep the same ranking number, then count on (2011 has two #4's, after that a #5). This means you'll get more than 10 results per year

