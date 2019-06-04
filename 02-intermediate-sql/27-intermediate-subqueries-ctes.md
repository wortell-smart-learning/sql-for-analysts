# Subqueries en CTE's

## Self-contained subqueries

De uitkomst van één query "inpluggen" in een andere query.

Bijv.: geef de meest recente verkoop.

MAX(OrderId) AS lastOrder

## Correlated subqueries

Bijv.: geef de meest recente verkoop *per medewerker*

MAX(Orderdate) .. WHERE Inner.empid = outer.empid

## Rekening houden met de uitkomsten

Een scalar vereist '=', een multi-valued vereist 'IN' (maar slechts één kolom!)

## EXISTS / NOT EXISTS

Voordelen schetsen + leesbaarheid

## Derived Tables

Voortbouwen op het resultaat van een eerdere query.

FROM (SELECT ...) AS Derived_table

## CTE's

De extra stap vanuit Derived Tables
Langer voorbeeld uitwerken, waarbij er een fout opgelost moet worden.