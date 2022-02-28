# XML data

* XML introductie

  * Structuur

  * Schema's

* XML data laden met schema

* XML queries

* XML output queries

## About XML

The eXtensible Markup Language (XML) is a language to model data in text-files. 

Not only is it extensible, it's also pretty extensive:

* Although everything is stored inside text-files, XML knows about:

  * identifiers (elements can refer to other elements)

  * datatypes (and you can create your own data structures if you want)

  * schema's (what element is allowed at which place in the file)

For an almost-exhaustive list of properties about XML, have a look at [The XML Wikipedia page](https://en.wikipedia.org/wiki/XML)

For a basic example, see this example from the Dutch Wikipedia page:

```xml

<?xml version="1.0" encoding="utf-8"?>

<playlist name="mylist" xml:lang="en">

        <title>Little Fluffy Clouds</title>

        <artist>the Orb</artist>

    </song>

    <song>

        <title>Goodbye mother Earth</title>

        <artist>Underworld</artist>

    </song>

    <song />

</playlist>

```

Some terminology and rules:

* An XML document starts with `<?xml .... ?>`

* Things between angle brackets (like `<song>`) are called *elements*

* Each element has an opening tag (`<song>`) and a closing tag (`</song>`)

* Empty elements can also have a *self-closing* tag. `<song />` is a *self-closing* tag, aka. an *empty-element tag*

* An element can have zero or more child-elements (`<song>` has two child-elements)

* An element can have zero or more attributes (`<playlist>` has two *attributes*: `name` and `xml:lang`)

* Elements can have direct text (like `Little Fluffy Clouds`)


## XML data inside SQL Server

Inside the `Person.Person` table, there is a `Demographics` column containing XML data.

1. Look at the details of *Scott M. Rogers*, and study the contents of the `Demographics` column. Click on the value to see the entire XML document

2. Look at the details of *Ken J. Sánchez* as well. Compare the XML documents, and notice some differences

## Querying XML data in SQL Server

Within T-SQL, you can query data inside an XML column using several built-in functions:

* `query()` queries XML (for example, it retrieves a certain element and everything inside)

* `value()` queries a value (for example, the contents of an attribute) and enables you to put it in a SQL datatype

* `exist()` checks for the existence of an XML element

* `modify()` lets you change XML documents

* `nodes()` turns XML into multiple rows, thus enabling standard database-operations

3. Try the following example to test whether an XML document contains the element `NumberCarsOwned`

   * It's a simplified example from `Person.Person.Demographics` (to be more precise: the *namespace* has been removed)

```sql

DECLARE @tableVar TABLE (Demographics XML, FirstName nvarchar(50), MiddleName nvarchar(50), LastName nvarchar(50))

-- Inserts two rows almost identical to the Person.Person rows with the same name

INSERT INTO @tableVar (Demographics, FirstName, MiddleName, LastName)

VALUES (

'<IndividualSurvey><TotalPurchaseYTD>1647</TotalPurchaseYTD><DateFirstPurchase>2002-04-18Z</DateFirstPurchase><BirthDate>1968-05-15Z</BirthDate><MaritalStatus>M</MaritalStatus><YearlyIncome>50001-75000</YearlyIncome><Gender>M</Gender><TotalChildren>2</TotalChildren><NumberChildrenAtHome>2</NumberChildrenAtHome><Education>Bachelors</Education><Occupation>Professional</Occupation><HomeOwnerFlag>1</HomeOwnerFlag><NumberCarsOwned>1</NumberCarsOwned><CommuteDistance>2-5 Miles</CommuteDistance></IndividualSurvey>', 'Scott', 'M.', 'Rodgers'),

('<IndividualSurvey><TotalPurchaseYTD>0</TotalPurchaseYTD></IndividualSurvey>', 'Ken', 'J', 'Sánchez');

SELECT 

    FirstName

    , MiddleName

    , LastName

    , Demographics

    , Demographics.exist('/IndividualSurvey/NumberCarsOwned') AS ElementExists

    , Demographics.query('/IndividualSurvey/DateFirstPurchase') AS valueOfDateFirstPurchase

FROM @tableVar;

```

**The language used within the elements is called *XQuery***


## Querying data with namespaces

If you want to query data inside the `AdventureWorks2017` database, you'll need one other element: the *namespace* of XML.

Simply stated, the first query doesn't work, while the second will work:

```sql

SELECT 

    FirstName

    , MiddleName

    , LastName

    , Demographics

    , Demographics.exist('/IndividualSurvey/NumberCarsOwned') AS ElementExists

    , Demographics.query('/IndividualSurvey/DateFirstPurchase') AS valueOfDateFirstPurchase

    , Demographics.value('/idvs:IndividualSurvey[1]/idvs:DateFirstPurchase[1]', 'varchar(30)') AS ContentsOfDateFirstPurchase

FROM Person.Person

  WHERE BusinessEntityID IN (1, 1703)

;

WITH XMLNAMESPACES('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' as idvs)

SELECT 

    FirstName

    , MiddleName

    , LastName

    , Demographics

    , Demographics.exist('/idvs:IndividualSurvey/idvs:NumberCarsOwned') AS ElementExists

    , Demographics.query('/idvs:IndividualSurvey/idvs:DateFirstPurchase') AS valueOfDateFirstPurchase

    , Demographics.value('/idvs:IndividualSurvey[1]/idvs:DateFirstPurchase[1]', 'varchar(30)') AS ContentsOfDateFirstPurchase

FROM AdventureWorks2017.Person.Person

  WHERE BusinessEntityID IN (1, 1703)

;

```

4. Try both queries, and verify the first doesn't work while the second does.

> The reason you need `XMLNAMESPACES` here, is that the `IndividualSurvey` doesn't stand on its own: it is contained inside a *namespace*.

> 

> Let's keep this simple, and compare the namespace with a *schema* in SQL Server. The `Employee` table doesn't exist on its own as well, but only within the `HumanResources` schema. In order to query the `Employee` table, you need to define in which schema the table is.

>

> Because the *namespace* is a pretty long URI, in XML these are usually aliased - in documents as well as queries.

The `Production.ProductModel` also contains some XML-typed instructions within the `Instructions` column.

5. Examine the instructions for models `HL Touring Frame` and `LL Touring Frame`

6. Use `.exist` to check whether the `Location` tag exists.

7. Query the first `Location` for both rows. Study the XML for constructing your query.

8. Query the `specs` of the third `step` of the second `Location`

## Output data as XML: the easy way

If you need to *output* XML data, that is pretty easy as well in SQL Server.

9. Write a simple SELECT statement

   * Select from the table `Person.Person`

   * Select the columns `FirstName`, `MiddleName`, `LastName`

   * Select only 10 rows in order to keep your GUI responsive (SQL Server won't bat an eye for big XML documents, but Azure Data Studio / SSMS might)

   * Verify that it works

10. Add `FOR XML AUTO` at the end of the query and examine the results


11. Now, alias the table to `Person` and examine the results again.

    * Notice the differences with the earlier query

12. Add the directive `, ELEMENTS` after `AUTO` (so it looks like `FOR XML AUTO, ELEMENTS`)

    * Notice the difference with earlier queries

## Output data as XML: the extended way

`FOR XML AUTO` always returns the columns nested within their originating table expressions.

If you need to be somewhat more explicit in the way the XML is formed, you could use `FOR XML PATH`

Below is an example:

```sql

SELECT TOP 10 FirstName AS "Name/FirstName", MiddleName AS "Name/MiddleName", LastName 

FROM AdventureWorks2017.Person.Person AS Person

FOR XML PATH

```

13. (Bonus) Write a query

    * It should `INNER JOIN` the following tables:

      * `HumanResources.Employee`

        * Select column `LoginID`

      * `Person.Person`

        * Select columns `FirstName`, `MiddleName`, `LastName` and `BusinessEntityID` 

    * For `BusinessEntityID = 1`, the output should look like this:

```xml

<row EmpID="1">

	<PersonName>

		<First>

			Ken

		</First>

		<Middle>

			J

		</Middle>

		<Last>

			Sánchez

		</Last>

	</PersonName>

	<Employee>

		<LoginID>

			adventure-works\ken0

		</LoginID>

	</Employee>

</row>

```


## Bonus-output data as XML: the complete way

The most explicit way to define your XML is using `FOR XML EXPLICIT`. If you really need to fine-tune your XML documents, have a look at this [article from SQL Server Central](https://www.sqlservercentral.com/articles/xml-workshop-iv-for-xml-explicit).
