# Stored procedures

## Creating a stored procedure

Almost any block of SQL statements can be captured inside a *stored procedure*: basically a name that you put on a piece of code.

For example:

```sql
CREATE PROCEDURE [dbo].[getEmployeesByGender]
(
    @gender CHAR(1)
)
AS

IF(@gender = 'F')
THEN
    SELECT
    * 
    FROM [HumanResources].[Employee]
    WHERE [Gender] = 'F'
ELSE
    SELECT CONCAT('Gender was ', @gender);
```

## Executing a stored procedure

A stored procedure can be executed using the `exec` keyword. Arguments are passed directly, without parentheses:

```sql
exec dbo.getEmployeesByGender 'F'
```

