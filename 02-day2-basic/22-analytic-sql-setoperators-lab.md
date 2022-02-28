# Set Operators

During this lab we will work with the **AdventureWorksDW2017** database

1. Select the cities where both customers and employees live.

   * For the employee addresses, join `HumanResources.Employee` through `Person.BusinessEntityAddress` to `Person.Address`

   * For the customer addresses, join `Sales.Customer` through `Person.BusinessEntityAddress` to `Person.Address` 

     * column `PersonID` in `Customer` corresponds to column `BusinessEntityID` in `BusinessEntityAddress`


2. Select the employees who have ever bought anything at AdventureWorks


(0 rows affected)


<table><tr><th>BusinessEntityID</th></tr></table>
