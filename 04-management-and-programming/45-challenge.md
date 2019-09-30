# Challenge Assignment

Create a staging table for any table from `AdventureWorks2017`. If you want to have this as real as possible:

* Create a new database
* Use the CREATE TABLE statement from the table you want to stage
* Remove all constraints, but keep datatypes the same
* Add two new columns:
  1. An identity column for the staging area
  2. A Load Date-Time Stamp
* Now, create a stored procedure that truncates and inserts this staging area

* Bonus: create a history-layer as well.
* Table structure can be the same as in the staging area
* Write a stored procedure that inserts rows if they don't exist yet
* If you want to take this even further: alter the staging procedure so that it only loads rows that you don't have already in your history layer.