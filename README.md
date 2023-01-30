# SQL for Analysts

SQL for Analysts is een raamwerk voor een SQL-training met drie soorten materiaal:

*	Instructies (feitelijk een uitgeschreven instructie / demo)
*	Labs (Oefeningen die direct teruggrijpen op een instructie of demo)
*	Challenges (opgaven die deelnemers moeten maken met alle voorafgaande opgedane kennis)

De training wordt normaal gesproken in Azure Data Studio gegeven, vanwege de beschikbaarheid van Jupyter Notebooks met SQL. 
De database is voornamelijk AdventureWorksLT, die in een lokale SQL Server wordt gedraaid. Deelnemers krijgen een VM waarin ze kunnen werken (maar mogen uiteraard ook SQL op hun eigen laptop draaien)

De kracht van dit materiaal zit vooral in de challenges, omdat daar verschillende technieken gecombineerd moeten worden.

In de basis ziet het er als volgt uit:
| Map / dag        | Onderwerp              | Type                                                                 | Bestand                                     |
|------------------|------------------------|----------------------------------------------------------------------|---------------------------------------------|
| 01-day1-basic    | Select, sort, filter   | Presentatie (pptx)                                                   | 1 - SELECT, SORT and FILTER.pptx            |
|                  | Select, sort, filter   | Instructie (demo) + Lab                                              | 11-basic-sql-select-sort-filter.md          |
|                  | Inner Join             | Instructie (demo) + Lab                                              | 12-basic-sql-inner-join.md                  |
|                  | Outer Joins            | Instructie (demo)                                                    | 13-basic-sql-left-right-fulljoin.md         |
|                  | Insert, update, delete | Instructie (demo) + opgaven tussendoor (let op, staan tussen tekst!) | 14-insert-update-delete.md                  |
|                  | Challenge day 1        | Challenge                                                            | 15-challenge-day-1.md                       |
| 02-day2-basic    | Group by, aggregate    | Instructie                                                           | Geen materiaal                              |
|                  | Group by, aggregate    | Lab                                                                  | 21-analytic-sql-grouping-aggregating.md     |
|                  | Set operators          | Instructie                                                           | 22-analytic-sql-setoperators-instruction.md |
|                  | Set operators          | Lab                                                                  | 22-analytic-sql-setoperators-lab.md         |
|                  | Datatypes              | Instructie                                                           | 4 - Data Types.pptx                         |
|                  | Datatypes              | Lab                                                                  | 23-intermediate-sql-datatypes.md            |
|                  | DDL (tables)           | Instructie                                                           | Geen materiaal                              |
|                  | DDL (tables)           | Lab                                                                  | 24-ddl-sql-tables.md                        |
|                  | DDL (alter table)      | Instructie                                                           | Geen materiaal                              |
|                  | DDL (alter table)      | Lab                                                                  | 26-ddl-alter.md                             |
| 03-day3-analytic | Subqueries en CTE’s    | Instructie                                                           | Geen materiaal                              |
|                  | Subqueries en CTE’s    | Lab                                                                  | 31-intermediate-subqueries-ctes.md          |
|                  | Windowing & Ranking    | Instructie                                                           | Geen materiaal                              |
|                  | Windowing & ranking    | Lab                                                                  | 32-advanced-analytic-windowing-ranking.md   |
|                  | Challenge              | Challenge                                                            | 35-challenge.md                             |
