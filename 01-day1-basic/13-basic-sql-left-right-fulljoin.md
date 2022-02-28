```sql
-- No setup code needed here: everything is available inside the AdventureWorksLT sample database


```

# Outer Joins: Left, Right and Full

In the previous module, we looked at the `INNER JOIN`. Remember that this started as a Carthesian Product (in SQL a `CROSS JOIN`, which is all possible combinations of rows), that is filtered down afterwards.

## The need for outer joins

### What happens without outer joins

Now let's say we want to view all customers along with all their registered addresses. In `AdventureWorksLT` we need three tables for that: `Customer` is linked to `Address`, but not directly: there is an intermediate table `CustomerAddress`, allowing multiple customers to have the same address, as well as allowing a single customer to have multiple addresses.

1. Select all columns from `SalesLT.Customer`

   * Notice the number of rows

2. Join the `CustomerAddress` table

   * What happens to the number of rows?

   * Why does this happen?

### Making sure the rows of one table are always present

An **outer join** does the same as an **inner join**: based on a carthesian product it filters only on the rows that match according to the `ON` clause. However, it does something extra: it assures that **when no match is found for a table, still rows are returned**.

Let's see what that means:

In the `Customer` table, two customers are present (actually, 847 customers are present, but we pick these two as an example):


```sql
SELECT *

FROM SalesLT.Customer

WHERE CustomerID IN (701, 29485);
```


(2 rows affected)


<table><tr><th>CustomerID</th><th>NameStyle</th><th>Title</th><th>FirstName</th><th>MiddleName</th><th>LastName</th><th>Suffix</th><th>CompanyName</th><th>SalesPerson</th><th>EmailAddress</th><th>Phone</th><th>PasswordHash</th><th>PasswordSalt</th><th>rowguid</th><th>ModifiedDate</th></tr><tr><td>701</td><td>0</td><td>Ms.</td><td>Linda</td><td>R.</td><td>Ecoffey</td><td>NULL</td><td>Future Bikes</td><td>adventure-works\josé1</td><td>linda5@adventure-works.com</td><td>674-555-0188</td><td>zM1odbx2eTJoH556dXSIqTCDa5EBj8DWUSHVo67GEGc=</td><td>Q5U1IZU=</td><td>61ae9625-8bd8-48b7-b171-8a90cbba494c</td><td>2006-12-01 00:00:00.000</td></tr><tr><td>29485</td><td>0</td><td>Ms.</td><td>Catherine</td><td>R.</td><td>Abel</td><td>NULL</td><td>Professional Sales and Service</td><td>adventure-works\linda3</td><td>catherine0@adventure-works.com</td><td>747-555-0171</td><td>zh3goJUbYsPv92k4bVZuJtlLHwuvpQtu6uNcjkKSdF8=</td><td>rpyd5Tw=</td><td>392ae773-d7ec-48ac-b8d0-6e65b770285c</td><td>2009-05-16 16:33:33.077</td></tr></table>

The first customer, Linda, doesn't have any address stored. The second one, Catherine, does have an address:


```sql
SELECT 

    * 

FROM SalesLT.CustomerAddress

WHERE CustomerID IN (701, 29485);
```


(1 row affected)


<table><tr><th>CustomerID</th><th>AddressID</th><th>AddressType</th><th>rowguid</th><th>ModifiedDate</th></tr><tr><td>29485</td><td>1086</td><td>Main Office</td><td>16765338-dbe4-4421-b5e9-3836b9278e63</td><td>2007-09-01 00:00:00.000</td></tr></table>

With a simple `INNER JOIN`, Linda would disappear:


```sql
SELECT

    Customer.CustomerID

    , Customer.FirstName

    , CustomerAddress.AddressID

FROM SalesLT.Customer

INNER JOIN SalesLT.CustomerAddress
    ON Customer.CustomerID = CustomerAddress.CustomerID

WHERE Customer.CustomerID IN (701, 29485)
```


(1 row affected)


<table><tr><th>CustomerID</th><th>FirstName</th><th>AddressID</th></tr><tr><td>29485</td><td>Catherine</td><td>1086</td></tr></table>

We can fix this using a `LEFT OUTER JOIN`. This ensures that the **left** side of the JOIN clause (in this case `SalesLT.Customer`) will always have all their rows returned:


```sql
SELECT

    Customer.CustomerID

    , Customer.FirstName

    , CustomerAddress.AddressID

FROM SalesLT.Customer

LEFT JOIN SalesLT.CustomerAddress

    ON Customer.CustomerID = CustomerAddress.CustomerID

WHERE Customer.CustomerID IN (701, 29485)
```


(2 rows affected)


<table><tr><th>CustomerID</th><th>FirstName</th><th>AddressID</th></tr><tr><td>701</td><td>Linda</td><td>NULL</td></tr><tr><td>29485</td><td>Catherine</td><td>1086</td></tr></table>

So in order to see all addresses for all customers, **and also return customers without an address**, we could use the LEFT JOIN in exactly the manner above (but omitting the `WHERE` clause).

1. Correct your earlier query so that all customers are returned along with all their addresses. This time customers like Linda (without an address) should also be returned.

2. Extend this query with the actual address (from the `SalesLT.Address` table). Think about the following points:

   * Every row in `CustomerAddress` points to a valid row in `Address`

   * Should we still use a LEFT JOIN, or can we do with an INNER JOIN? (try this!)

   * Why?

## LEFT, RIGHT, FULL

There are three types of outer joins:

* `LEFT OUTER JOIN` (or `LEFT JOIN`) ensures that rows on the left side are always returned at least once


* `FULL OUTER JOIN` (or `FULL JOIN`) ensures that rows on both side are always returned at least once

Please note that *left* and *right* don't have anything to do with the order of your `ON` clause. The following two queries (displaying even more obvious which side is left / right) are identical:

```sql

SELECT

    [columns]

FROM [TableA] LEFT OUTER JOIN [TableB] ON [TableA].[Column] = [TableB].[Column];

    -- ^ Left                   ^ Right

-- is the same as (notice the ON clause has flipped around)

SELECT

    [columns]

FROM [TableA] LEFT OUTER JOIN [TableB] ON [TableB].[Column] = [TableA].[Column]

    -- ^ (still) left           ^ (still) right

```

Perform the following actions to the query you were writing earlier:

3. Extend your query so that all addresses (regardless whether a customer lives there) are displayed as well. You should have 890 rows now.

4. If you need a bit more challenge: take the earlier query (resulting in 857 rows). Try to rewrite this one so that you use one `INNER JOIN` and one `RIGHT JOIN`, but still have the same result.

### Avoiding Right Joins


A right join can be pretty useful, but it has some nasty side-effects. Let's say we've our query from above which neatly preserves all customers:


```sql
SELECT

    Customer.CustomerID

    , Customer.FirstName

    , CustomerAddress.AddressID

FROM SalesLT.Customer

LEFT JOIN SalesLT.CustomerAddress

    ON Customer.CustomerID = CustomerAddress.CustomerID

-- In theory, another 10 joins or so could live here

WHERE Customer.CustomerID IN (701, 29485)
```


(2 rows affected)


<table><tr><th>CustomerID</th><th>FirstName</th><th>AddressID</th></tr><tr><td>701</td><td>Linda</td><td>NULL</td></tr><tr><td>29485</td><td>Catherine</td><td>1086</td></tr></table>

As soon as we add only one `RIGHT JOIN`, it "reverses" more or less the way rows are preserved - in the example below, now only the Addresses are kept, and not the Customers:


```sql
SELECT

    Customer.CustomerID

    , Customer.FirstName

    , CustomerAddress.AddressID

FROM SalesLT.Customer

LEFT JOIN SalesLT.CustomerAddress

    ON Customer.CustomerID = CustomerAddress.CustomerID

-- In theory, another 10 joins or so could live here

RIGHT JOIN SalesLT.Address

    ON CustomerAddress.AddressID = Address.AddressID

WHERE Customer.CustomerID IN (701, 29485)
```


(1 row affected)


<table><tr><th>CustomerID</th><th>FirstName</th><th>AddressID</th></tr><tr><td>29485</td><td>Catherine</td><td>1086</td></tr></table>

In this example, this is pretty obvious, but still not very intuitive: usually, we read from top to bottom, from left to right. Therefor, try to avoid right joins. Every right join can be rewritten to a left join. The SQL statement below is identical to the one above, but way easier to read:


```sql
SELECT

    Customer.CustomerID

    , Customer.FirstName

    , CustomerAddress.AddressID

FROM SalesLT.Address

LEFT JOIN SalesLT.CustomerAddress

    ON Address.AddressID = CustomerAddress.CustomerID

-- In theory, another 10 joins or so could live here

LEFT JOIN SalesLT.Customer

    ON Customer.CustomerID = CustomerAddress.AddressID

WHERE Customer.CustomerID IN (701, 29485)
```


(0 rows affected)


<table><tr><th>CustomerID</th><th>FirstName</th><th>AddressID</th></tr></table>
