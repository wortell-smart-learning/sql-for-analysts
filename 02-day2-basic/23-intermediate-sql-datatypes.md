# SQL Datatypes

Every column in every table inside a SQL Database has a so-called "datatype". This determines the type of data that fits in, and the detail with which data is stored. A full list of data types can be found in the Microsoft docs - but instead of giving you the link, [just google for "t-sql data types"](http://lmgtfy.com/?q=t-sql+data+types) to find the docs. It will come in handy as a reference in this module (plus, the habit of looking up documentation this way will serve you well as SQL Server user).

As soon as you are on the Microsoft Docs about SQL Data Types, notice the link on the left that says **Precedence**. This is the one that tells you which data type will be automatically converted into another data type. Don't worry about storing this page: it will almost always be easier to test how it works in SQL than to read the docs about precedence. Just remember the phrase in case you need it :-).

## Explicit conversions

1. Select the "Title" concatenated with the "Id" column in the table "Customer"


```sql

2. Select the "Name" column from ProductCategory. Make sure only the first columns are displayed by casting to a smaller CHAR or VARCHAR-datatype.


```sql

```

3. Select 100 rows from `Sales.SalesOrderDetail`. Join where necessary

   * You should return only one column

   * The column should read as a text, saying things like:

     * Customer James Hendergart bought 4 Sport-100 Helmet, Blue(s) at a price of $80.746000

     * Customer Takiko J. Collins bought 1 Road-650 Red, 44(s) at a price of $419.458900

  * Use the `CONCAT()` function to construct your sentence.

   * Bonus points:

     * Customers without a middle name should have only one space between first- and last name

     * When OrderQty > 1, a "s" is added after the product name. When OrderQty = 1, no "s" is added:

        * Customer James Hendergart bought 4 Sport-100 Helmet, Blue**s** at a price of $80.746000

        * Customer Takiko J. Collins bought 1 Road-650 Red, 44 at a price of $419.458900

           1. Using Set operators

           2. Using a `CASE` statement


```sql

```

3. Convert the following formats *using SQL* to a correct Date format:

   * `'2019/04/06'` (U.S. notation: 4th of June, 2019)

   * `'04-06-2019'` (Italian notation: 4th of June, 2019)

   * `'190604'` (short ISO notation)

   * Bonus:

     * Get the ISO week numbers for one of these dates

     * Display one of these dates as a Chinese (Simplified PRC) formatted date using the `FORMAT` constructor


```sql

```

4. (Bonus) Select all products where the letter-digit pattern is like 'AR-5381' (two letters, hyphen, four digits). Add one to each number.

   * Hint: Use `LEFT` and `RIGHT` to select a certain part of a `VARCHAR`
