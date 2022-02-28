# Backup & Restore

Use `AdventureWorks2017` as a database inside this notebook.

1. Review the database logging settings for both `AdventureWorks2017` and `AdventureWorksDW2017`
   * `AdventureWorks2017` should be set to `Full logging`
   * `AdventureWorksDW2017` should be set to `Simple logging`

You can either review this via the GUI, or in T-SQL

* SSMS: right-click the database, view "Properties"
* Azure Data Studio: right-click the database, click "Manage"
* T-SQL: 
```sql
SELECT name, recovery_model_desc 
FROM sys.databases;
```


```sql
SELECT name, recovery_model_desc  

   FROM sys.databases;  
```


(7 rows affected)


<table><tr><th>name</th><th>recovery_model_desc</th></tr><tr><td>master</td><td>SIMPLE</td></tr><tr><td>tempdb</td><td>SIMPLE</td></tr><tr><td>model</td><td>FULL</td></tr><tr><td>msdb</td><td>SIMPLE</td></tr><tr><td>AdventureWorks2017</td><td>FULL</td></tr><tr><td>AdventureWorksDW2017</td><td>SIMPLE</td></tr><tr><td>AdventureWorksLT2017</td><td>SIMPLE</td></tr></table>

2. Select (and note) the current time (try to use a SQL command returning the current date and time)


```sql
SELECT GETDATE();
```


(1 row affected)


<table><tr><th>(No column name)</th></tr><tr><td>2019-09-24 10:07:29.667</td></tr></table>

3. Insert a new salesperson in `AdventureWorks2017` by adding data to the following two tables:

   * In `Person.BusinessEntity`: add a row

     * rowguid: Use the `NEWID()` function to generate a new GUID

     * ModifiedDate: Use `GETDATE()` to get the current date

  * BusinessEntityID: look up (manually) the ID just generated in `Person.BusinessEntity.BusinessEntityID`

     * TerritoryID: 7 (from `Sales.SalesTerritory`: France)

     * SalesQuota, Bonus, CommissionPct, SalesYTD, SalesLastYear: use the values from SalesPerson with BusinessEntityID 290, add 10%

     * rowguid: Use the `NEWID()` function to generate a new GUID

     * ModifiedDate: Use `GETDATE()` to get the current date


```

4. Insert a new employee in `AdventureWorksDW2017`. Use the same values as employee with dimension ID 269


```sql

```

5. Select (and note) the current time (yes, again)


```sql

```


(10 rows affected)


<table><tr><th>orderyear</th><th>SalesPersonID</th><th>NumOfOrders</th></tr><tr><td>2012</td><td>277</td><td>166</td></tr><tr><td>2012</td><td>275</td><td>148</td></tr><tr><td>2013</td><td>279</td><td>159</td></tr><tr><td>2013</td><td>275</td><td>175</td></tr><tr><td>2013</td><td>276</td><td>162</td></tr><tr><td>2012</td><td>276</td><td>151</td></tr><tr><td>2013</td><td>277</td><td>185</td></tr><tr><td>2012</td><td>279</td><td>153</td></tr><tr><td>2013</td><td>289</td><td>170</td></tr><tr><td>2012</td><td>289</td><td>111</td></tr></table>

6. Delete (semi-accidentally) all rows from

   * `dbo.FactResellerSales` in `AdventureWorksDW2017`

   * `Sales.SalesOrderDetail` in `AdventureWorks2017`


```sql

```

## Restore backups

We are now in a situation where we "accidentally" removed a large number of rows in both databases.

In both cases, a "full backup" is available. This means we can roll back both databases, but with one major difference:

* with **full recovery model** (aka *full logging*), we can roll back to **any point in time**. This is called *Point In Time Recovery*.

* with **simple logging**, we can only roll back to the **exact situation on the moment of backup**.

### Restore the AdventureWorks database

The `AdventureWorks2017` database has a **full recovery model**. This means:

* larger transaction log files (.ldf)

* more IOPS used (writes and reads per second to disk)

* point in time recovery possible

The query below will show all transaction log files, displaying the current size (on disk the file will be larger, as there should always be room to store more transactions)


```sql
SELECT 'AdventureWorks2017', file_id, name, type_desc, physical_name, size, max_size

FROM AdventureWorks2017.sys.database_files

UNION ALL

SELECT 'AdventureWorksDW2017', file_id, name, type_desc, physical_name, size, max_size

FROM AdventureWorksDW2017.sys.database_files


```


(4 rows affected)


<table><tr><th>(No column name)</th><th>file_id</th><th>name</th><th>type_desc</th><th>physical_name</th><th>size</th><th>max_size</th></tr><tr><td>AdventureWorks2017</td><td>1</td><td>AdventureWorks2017</td><td>ROWS</td><td>C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorks2017.mdf</td><td>33792</td><td>-1</td></tr><tr><td>AdventureWorks2017</td><td>2</td><td>AdventureWorks2017_log</td><td>LOG</td><td>C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorks2017_log.ldf</td><td>9216</td><td>268435456</td></tr><tr><td>AdventureWorksDW2017</td><td>1</td><td>AdventureWorksDW2017</td><td>ROWS</td><td>C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2017.mdf</td><td>17408</td><td>-1</td></tr><tr><td>AdventureWorksDW2017</td><td>2</td><td>AdventureWorksDW2017_log</td><td>LOG</td><td>C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2017_log.ldf</td><td>9216</td><td>268435456</td></tr></table>

To do a point-in-time (PIT) restore, start SSMS.

From there, follow the instructions on [https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-sql-server-database-to-a-point-in-time-full-recovery-model?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-sql-server-database-to-a-point-in-time-full-recovery-model?view=sql-server-2017) under the heading **Using SQL Server Management Studio**.

* Restore to the point *before* the "accidental" deletion of `SalesOrderDetail`, but *after* the inserting of the new `SalesPerson`. 

* Make sure the `WITH OVERWRITE` option is selected

* Make sure active connections are closed

### Restore the AdventureWorksDW database

Given the explanation about *full recovery model*, I expect a point-in-time recovery for the `AdventureWorksDW` database to be impossible, because it doesn't keep all transactions in between two backups. 

To test this assumption, try to do the same restore (before deleting the fact, but after adding the new employee) on AdventureWorksDW.

If this is not possible, do a restore of the full backup, and check that the new employee has disappeared from the DimEmployee table. You can do this either via the GUI in SSMS, or try to find the T-SQL commands to do it using T-SQL.
