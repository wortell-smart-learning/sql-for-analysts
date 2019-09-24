# Basic management

* Uitleg: verschil in logging types
* Lab ervaren
  * Twee databases aanmaken
    1. Simple logging
    2. Full logging
  * Tijd noteren (tijd A)
  * Script uitvoeren met 100K inserts + 100K deletes
  * logfiles bekijken (formaat)
  * Tijd noteren (tijd B)
  * Script uitvoeren met 100K deletes (uit de verkeerde tabel)
  * Laten zien dat de "full logging" nu de mogelijkheid biedt om terug te gaan naar "tijd A" - zelfs al is er nog geen backup tussendoor geweest --> PIT restore
  * Verschil compressie en niet-compressie bekijken (specifiek voor AWDW)

* In challenge:
  * backup maken
  * alles stuk maken
  * backup terugzetten
