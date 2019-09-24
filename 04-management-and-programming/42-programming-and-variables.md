# Programming and variables

## Batches en variabelen

* Introductie concept van "batch"
* GO statement (batch separator, geen onderdeel T-SQL)
* Variabelen m.b.v. casus:
  * Haal beste verkoper op
  * Geef de verkopen van die verkoper weer
  * (bonus: zou je dit zonder variabelen kunnen oplossen?)
* PRINT statement

## Programmaflow

* Recap: CASE-statement. Waarde binnen een query voor elke rij.
* Maar wat nu als je wilt kiezen tussen twee queries?
  * Optie 1 (preferred): met WHERE-clausules goed scheiden
  * Optie 2 (handig voor beheer e.d.): een IF-statement
* Bijzondere casus: handig wanneer je DDL-logica wilt scheiden, i.c.m. `OBJECT_ID`

* WHILE voor automatiseren van grotere hoeveelheden statements
* Basis-casus: aanmaken van verzameling aan tabellen
* Meer geavanceerde casus?

## Cursors (voor de liefhebbers)

* Doorlopen van metadata-tabel om je tabellen te genereren
