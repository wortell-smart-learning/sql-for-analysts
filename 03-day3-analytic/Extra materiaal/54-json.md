# JSON data

JSON (JavaScript Object Notation) is a concise and human-readable "language" designed to store data in a less verbose way than, say, XML.

A small example of a JSON snippet we will use in this lab is:

```json
{
	"Name": "Vlade",
	"Surname": "Divac",
	"Born": { "DoB":"1968-03-02","Town":"Prijepolje", "Country": "Serbia"},
	"NBA Stat": { "pts":13398, "ppg": 11.8, "rebounds":	9326, "rpg": 8.2, "blocks":	1631, "bpg": 1.4},
	"Teams": ["Los Angeles Lakers","Sacramento Kings","Partizan"],
	"Career": [
		{"team":"Sloga", "period":{"start":1983, "end":1986}},
		{"team":"Partizan", "period":{"start":1986, "end":1989}},
		{"team":"Los Angeles Lakers","gp":540, "gs":450, "period":{"start":1989, "end":1996}},
		{"team":"Charlotte Hornets","gp":145, "gs":121,"period":{"start":1996, "end":1998}},
		{"team":"Sacramento Kings","gp":454, "gs":453,"period":{"start":1998, "end":2004}},
		{"team":"Los Angeles Lakers", "gp":15, "gs":0,"period":{"start":2004, "end":2005}}]
 }
```

JSON has the following elements:

* Object-initialisers: `{` _string_ `:` _value_ `,` ... `}`
* Array-initialisers: `[` _value_ `,` ... `]`
* Literal values: `true`, `false` and `null`
* strings, delimited by `"`
* numbers: 3.14, 42 

SQL Server has several functions to work with JSON:

* [ISJSON](https://docs.microsoft.com/en-us/sql/t-sql/functions/isjson-transact-sql?view=sql-server-2017) tests whether a string contains valid JSON.
* [JSON_VALUE](https://docs.microsoft.com/en-us/sql/t-sql/functions/json-value-transact-sql?view=sql-server-2017) extracts a scalar value from a JSON string.
* [JSON_QUERY](https://docs.microsoft.com/en-us/sql/t-sql/functions/json-query-transact-sql?view=sql-server-2017) extracts an object or an array from a JSON string.
* [JSON_MODIFY](https://docs.microsoft.com/en-us/sql/t-sql/functions/json-modify-transact-sql?view=sql-server-2017) changes a value in a JSON string.

Samples below are from [Channel9's Json Intro](https://github.com/microsoft/sql-server-samples/blob/master/samples/features/json/scripts/channel9-json-intro.sql)

### ISJSON

`ISJSON` controleert of een JSON-variabele correct opgemaakt is.

1. Probeer dit uit: 
   * Voer de volgende query uit, en bekijk de uitkomst
   * Wijzig iets om de JSON ongeldig te maken (verwijder bijvoorbeeld een komma of `"`)
   * Voer de query nogmaals uit en bekijk de uitkomst


```sql
declare @json nvarchar(max) =
N'{
	"Name": "Vlade",
	"Surname": "Divac",
	"Born": { "DoB":"1968-03-02","Town":"Prijepolje", "Country": "Serbia"},
	"NBA Stat": { "pts":13398, "ppg": 11.8, "rebounds":	9326, "rpg": 8.2, "blocks":	1631, "bpg": 1.4},
	"Teams": ["Los Angeles Lakers","Sacramento Kings","Partizan"],
	"Career": [
		{"team":"Sloga", "period":{"start":1983, "end":1986}},
		{"team":"Partizan", "period":{"start":1986, "end":1989}},
		{"team":"Los Angeles Lakers","gp":540, "gs":450, "period":{"start":1989, "end":1996}},
		{"team":"Charlotte Hornets","gp":145, "gs":121,"period":{"start":1996, "end":1998}},
		{"team":"Sacramento Kings","gp":454, "gs":453,"period":{"start":1998, "end":2004}},
		{"team":"Los Angeles Lakers", "gp":15, "gs":0,"period":{"start":2004, "end":2005}}],
	"Bio":"Vlade Divac (Serbian Cyrillic: Владе Дивац) (born February 3, 1968) is a retired Serbian professional basketball player and is currently the vice president of basketball operations and general manager of the Sacramento Kings.[1]. Divac spent most of his career in the National Basketball Association (NBA). At 7 ft 1 in, he played center and was known for his passing skills. Divac was among the first group of European basketball players to transfer to the NBA in the late 1980s and was named one of the 50 Greatest Euroleague Contributors.[2] Divac is one of seven players in NBA history to record 13,000 points, 9,000 rebounds, 3,000 assists and 1,500 blocked shots, along with Kareem Abdul-Jabbar, Tim Duncan, Shaquille O''Neal, Kevin Garnett, Pau Gasol and Hakeem Olajuwon.[3][n 1] Divac was also the first player born and trained outside the United States to play in over 1,000 games in the NBA. On August 20, 2010, Divac was inducted into the FIBA Hall of Fame in recognition of his play in international competition.[4] Aside from being noticed for his basketball abilities, Divac is also known as a humanitarian, helping children in his native country of Serbia, and in Africa.[5] In October 2008 Divac was appointed a government adviser in Serbia for humanitarian issues.[6] In February 2009 he was elected President of the Serbian Olympic Committee for a 4-year term.[7] and re-elected in November 2012,[8] Divac received an honor from the World Sports Humanitarian Hall of Fame.[9], In summer 1986, at 18, right after signing for KK Partizan, Divac debuted for the senior Yugoslavia national basketball team at the 1986 FIBA World Championship in Madrid, on invitation by the head coach Krešimir Ćosić. However, the excellent rookie''s performance was spoiled by the event in the semi-finals against Soviet Union. Forty-five seconds before the end, Yugoslavia had a comfortable lead of 9 points, but Soviets scored two three-pointers within a few seconds and cut the difference to 3 points. Yugoslavia tried to hold the ball for the remaining time, opting to continue the play with throw-ins instead of free throws following fouls, but with only 14 seconds left, Divac committed a double dribble, the Soviets were awarded the ball, and tied the score with another three-pointer. In the overtime, the Soviets easily prevailed against the shocked Yugoslavs, who had to be content with the bronze.[10] The next year, Divac participated in the team that took the gold at the FIBA Junior World Championship (since split into separate under-19 and under-21 events) in Bormio, Italy. That event launched the young generation of Yugoslavian basketballers, also featuring stars like Rađa and Kukoč, regarded as likely the best in history. Before the breakup of Yugoslavia, they would also take the titles at EuroBasket 1989 and the 1990 FIBA World Championship in Argentina,[10] where they were led by Dražen Petrović,[24] as well as the EuroBasket 1991 title, with Aleksandar Đorđević at point guard.[25], Drafted into the NBA in 1989 by the Los Angeles Lakers. He was also one of the first European players to have an impact in the league. Under the mentorship of Kareem Abdul-Jabbar and Magic Johnson, he improved his play and adapted to the American style of the game. Though he spoke no English, he quickly became popular among his teammates and the public for his charm and joviality. In the 1989–90 season, he was selected into the NBA All-Rookie Team.[10] Divac earned a reputation for flopping, or deceiving the officials into calling a foul on the other team by purposely falling to the floor upon contact with an opposing player.[12] Veteran NBA forward P. J. Brown claimed that Divac might have been the best of all time at flopping.[13] Divac freely admitted doing so, adding that he usually did it when he felt like the officials had missed some calls and owed him.[14] Ian Thomsen, a Sports Illustrated columnist, grouped Divac with fellow international players Anderson Varejão and Manu Ginóbili as the players who \"made [flopping] famous\", exaggerating contact on the court in a manner analogous to diving in FIFA games.[15]"
 }'

-- ISJSON 
 SELECT ISJSON(@json)
```

### JSON_VALUE

The following query gets the value from:

* the "Name" key
* the "Born.Dob" path
* the second item in Career,"period.start" path

2. Write a JSON_VALUE query to retrieve the second team in which Divac played
3. Try to get the `JSON_VALUE` for `$.name`. 
   * Does this work as expected? Why?
4. Get the number of blocks from the NBA stats


```sql
declare @json nvarchar(max) =
N'{
	"Name": "Vlade",
	"Surname": "Divac",
	"Born": { "DoB":"1968-03-02","Town":"Prijepolje", "Country": "Serbia"},
	"NBA Stat": { "pts":13398, "ppg": 11.8, "rebounds":	9326, "rpg": 8.2, "blocks":	1631, "bpg": 1.4},
	"Teams": ["Los Angeles Lakers","Sacramento Kings","Partizan"],
	"Career": [
		{"team":"Sloga", "period":{"start":1983, "end":1986}},
		{"team":"Partizan", "period":{"start":1986, "end":1989}},
		{"team":"Los Angeles Lakers","gp":540, "gs":450, "period":{"start":1989, "end":1996}},
		{"team":"Charlotte Hornets","gp":145, "gs":121,"period":{"start":1996, "end":1998}},
		{"team":"Sacramento Kings","gp":454, "gs":453,"period":{"start":1998, "end":2004}},
		{"team":"Los Angeles Lakers", "gp":15, "gs":0,"period":{"start":2004, "end":2005}}],
	"Bio":"Vlade Divac (Serbian Cyrillic: Владе Дивац) (born February 3, 1968) is a retired Serbian professional basketball player and is currently the vice president of basketball operations and general manager of the Sacramento Kings.[1]. Divac spent most of his career in the National Basketball Association (NBA). At 7 ft 1 in, he played center and was known for his passing skills. Divac was among the first group of European basketball players to transfer to the NBA in the late 1980s and was named one of the 50 Greatest Euroleague Contributors.[2] Divac is one of seven players in NBA history to record 13,000 points, 9,000 rebounds, 3,000 assists and 1,500 blocked shots, along with Kareem Abdul-Jabbar, Tim Duncan, Shaquille O''Neal, Kevin Garnett, Pau Gasol and Hakeem Olajuwon.[3][n 1] Divac was also the first player born and trained outside the United States to play in over 1,000 games in the NBA. On August 20, 2010, Divac was inducted into the FIBA Hall of Fame in recognition of his play in international competition.[4] Aside from being noticed for his basketball abilities, Divac is also known as a humanitarian, helping children in his native country of Serbia, and in Africa.[5] In October 2008 Divac was appointed a government adviser in Serbia for humanitarian issues.[6] In February 2009 he was elected President of the Serbian Olympic Committee for a 4-year term.[7] and re-elected in November 2012,[8] Divac received an honor from the World Sports Humanitarian Hall of Fame.[9], In summer 1986, at 18, right after signing for KK Partizan, Divac debuted for the senior Yugoslavia national basketball team at the 1986 FIBA World Championship in Madrid, on invitation by the head coach Krešimir Ćosić. However, the excellent rookie''s performance was spoiled by the event in the semi-finals against Soviet Union. Forty-five seconds before the end, Yugoslavia had a comfortable lead of 9 points, but Soviets scored two three-pointers within a few seconds and cut the difference to 3 points. Yugoslavia tried to hold the ball for the remaining time, opting to continue the play with throw-ins instead of free throws following fouls, but with only 14 seconds left, Divac committed a double dribble, the Soviets were awarded the ball, and tied the score with another three-pointer. In the overtime, the Soviets easily prevailed against the shocked Yugoslavs, who had to be content with the bronze.[10] The next year, Divac participated in the team that took the gold at the FIBA Junior World Championship (since split into separate under-19 and under-21 events) in Bormio, Italy. That event launched the young generation of Yugoslavian basketballers, also featuring stars like Rađa and Kukoč, regarded as likely the best in history. Before the breakup of Yugoslavia, they would also take the titles at EuroBasket 1989 and the 1990 FIBA World Championship in Argentina,[10] where they were led by Dražen Petrović,[24] as well as the EuroBasket 1991 title, with Aleksandar Đorđević at point guard.[25], Drafted into the NBA in 1989 by the Los Angeles Lakers. He was also one of the first European players to have an impact in the league. Under the mentorship of Kareem Abdul-Jabbar and Magic Johnson, he improved his play and adapted to the American style of the game. Though he spoke no English, he quickly became popular among his teammates and the public for his charm and joviality. In the 1989–90 season, he was selected into the NBA All-Rookie Team.[10] Divac earned a reputation for flopping, or deceiving the officials into calling a foul on the other team by purposely falling to the floor upon contact with an opposing player.[12] Veteran NBA forward P. J. Brown claimed that Divac might have been the best of all time at flopping.[13] Divac freely admitted doing so, adding that he usually did it when he felt like the officials had missed some calls and owed him.[14] Ian Thomsen, a Sports Illustrated columnist, grouped Divac with fellow international players Anderson Varejão and Manu Ginóbili as the players who \"made [flopping] famous\", exaggerating contact on the court in a manner analogous to diving in FIFA games.[15]"
 }'

--> Get a value from "Name" key
SELECT JSON_VALUE(@json, '$.Name')
  

--> Get a value from "Born.Dob" path
SELECT JSON_VALUE(@json, '$.Born.DoB')


--> Get a value from "Career[2].period.start" path
SELECT JSON_VALUE(@json, '$.Career[2].period.start')
```

### JSON_QUERY

5. Try to use **JSON_VALUE** (yes, that's correct) to get the contents of the "Born" object
   * Why does it return NULL?
6. Now re-try the same with JSON_QUERY
7. Is the output of JSON_QUERY still valid JSON? (Test this)
8. Use the output of JSON_QUERY to extract the value for the Day of Birth


```sql
declare @json nvarchar(max) =
N'{
	"Name": "Vlade",
	"Surname": "Divac",
	"Born": { "DoB":"1968-03-02","Town":"Prijepolje", "Country": "Serbia"},
	"NBA Stat": { "pts":13398, "ppg": 11.8, "rebounds":	9326, "rpg": 8.2, "blocks":	1631, "bpg": 1.4},
	"Teams": ["Los Angeles Lakers","Sacramento Kings","Partizan"],
	"Career": [
		{"team":"Sloga", "period":{"start":1983, "end":1986}},
		{"team":"Partizan", "period":{"start":1986, "end":1989}},
		{"team":"Los Angeles Lakers","gp":540, "gs":450, "period":{"start":1989, "end":1996}},
		{"team":"Charlotte Hornets","gp":145, "gs":121,"period":{"start":1996, "end":1998}},
		{"team":"Sacramento Kings","gp":454, "gs":453,"period":{"start":1998, "end":2004}},
		{"team":"Los Angeles Lakers", "gp":15, "gs":0,"period":{"start":2004, "end":2005}}],
	"Bio":"Vlade Divac (Serbian Cyrillic: Владе Дивац) (born February 3, 1968) is a retired Serbian professional basketball player and is currently the vice president of basketball operations and general manager of the Sacramento Kings.[1]. Divac spent most of his career in the National Basketball Association (NBA). At 7 ft 1 in, he played center and was known for his passing skills. Divac was among the first group of European basketball players to transfer to the NBA in the late 1980s and was named one of the 50 Greatest Euroleague Contributors.[2] Divac is one of seven players in NBA history to record 13,000 points, 9,000 rebounds, 3,000 assists and 1,500 blocked shots, along with Kareem Abdul-Jabbar, Tim Duncan, Shaquille O''Neal, Kevin Garnett, Pau Gasol and Hakeem Olajuwon.[3][n 1] Divac was also the first player born and trained outside the United States to play in over 1,000 games in the NBA. On August 20, 2010, Divac was inducted into the FIBA Hall of Fame in recognition of his play in international competition.[4] Aside from being noticed for his basketball abilities, Divac is also known as a humanitarian, helping children in his native country of Serbia, and in Africa.[5] In October 2008 Divac was appointed a government adviser in Serbia for humanitarian issues.[6] In February 2009 he was elected President of the Serbian Olympic Committee for a 4-year term.[7] and re-elected in November 2012,[8] Divac received an honor from the World Sports Humanitarian Hall of Fame.[9], In summer 1986, at 18, right after signing for KK Partizan, Divac debuted for the senior Yugoslavia national basketball team at the 1986 FIBA World Championship in Madrid, on invitation by the head coach Krešimir Ćosić. However, the excellent rookie''s performance was spoiled by the event in the semi-finals against Soviet Union. Forty-five seconds before the end, Yugoslavia had a comfortable lead of 9 points, but Soviets scored two three-pointers within a few seconds and cut the difference to 3 points. Yugoslavia tried to hold the ball for the remaining time, opting to continue the play with throw-ins instead of free throws following fouls, but with only 14 seconds left, Divac committed a double dribble, the Soviets were awarded the ball, and tied the score with another three-pointer. In the overtime, the Soviets easily prevailed against the shocked Yugoslavs, who had to be content with the bronze.[10] The next year, Divac participated in the team that took the gold at the FIBA Junior World Championship (since split into separate under-19 and under-21 events) in Bormio, Italy. That event launched the young generation of Yugoslavian basketballers, also featuring stars like Rađa and Kukoč, regarded as likely the best in history. Before the breakup of Yugoslavia, they would also take the titles at EuroBasket 1989 and the 1990 FIBA World Championship in Argentina,[10] where they were led by Dražen Petrović,[24] as well as the EuroBasket 1991 title, with Aleksandar Đorđević at point guard.[25], Drafted into the NBA in 1989 by the Los Angeles Lakers. He was also one of the first European players to have an impact in the league. Under the mentorship of Kareem Abdul-Jabbar and Magic Johnson, he improved his play and adapted to the American style of the game. Though he spoke no English, he quickly became popular among his teammates and the public for his charm and joviality. In the 1989–90 season, he was selected into the NBA All-Rookie Team.[10] Divac earned a reputation for flopping, or deceiving the officials into calling a foul on the other team by purposely falling to the floor upon contact with an opposing player.[12] Veteran NBA forward P. J. Brown claimed that Divac might have been the best of all time at flopping.[13] Divac freely admitted doing so, adding that he usually did it when he felt like the officials had missed some calls and owed him.[14] Ian Thomsen, a Sports Illustrated columnist, grouped Divac with fellow international players Anderson Varejão and Manu Ginóbili as the players who \"made [flopping] famous\", exaggerating contact on the court in a manner analogous to diving in FIFA games.[15]"
 }';
 
```

### JSON_MODIFY

Examine the queries below.

9. Write a query to update the number of blocks to 1722
10. Try to add a new object to `Career`:
    * team: Landstede Hammers
    * period: 2005-2029


```sql
declare @json nvarchar(max) =
N'{
	"Name": "Vlade",
	"Surname": "Divac",
	"Born": { "DoB":"1968-03-02","Town":"Prijepolje", "Country": "Serbia"},
	"NBA Stat": { "pts":13398, "ppg": 11.8, "rebounds":	9326, "rpg": 8.2, "blocks":	1631, "bpg": 1.4},
	"Teams": ["Los Angeles Lakers","Sacramento Kings","Partizan"],
	"Career": [
		{"team":"Sloga", "period":{"start":1983, "end":1986}},
		{"team":"Partizan", "period":{"start":1986, "end":1989}},
		{"team":"Los Angeles Lakers","gp":540, "gs":450, "period":{"start":1989, "end":1996}},
		{"team":"Charlotte Hornets","gp":145, "gs":121,"period":{"start":1996, "end":1998}},
		{"team":"Sacramento Kings","gp":454, "gs":453,"period":{"start":1998, "end":2004}},
		{"team":"Los Angeles Lakers", "gp":15, "gs":0,"period":{"start":2004, "end":2005}}],
	"Bio":"Vlade Divac (Serbian Cyrillic: Владе Дивац) (born February 3, 1968) is a retired Serbian professional basketball player and is currently the vice president of basketball operations and general manager of the Sacramento Kings.[1]. Divac spent most of his career in the National Basketball Association (NBA). At 7 ft 1 in, he played center and was known for his passing skills. Divac was among the first group of European basketball players to transfer to the NBA in the late 1980s and was named one of the 50 Greatest Euroleague Contributors.[2] Divac is one of seven players in NBA history to record 13,000 points, 9,000 rebounds, 3,000 assists and 1,500 blocked shots, along with Kareem Abdul-Jabbar, Tim Duncan, Shaquille O''Neal, Kevin Garnett, Pau Gasol and Hakeem Olajuwon.[3][n 1] Divac was also the first player born and trained outside the United States to play in over 1,000 games in the NBA. On August 20, 2010, Divac was inducted into the FIBA Hall of Fame in recognition of his play in international competition.[4] Aside from being noticed for his basketball abilities, Divac is also known as a humanitarian, helping children in his native country of Serbia, and in Africa.[5] In October 2008 Divac was appointed a government adviser in Serbia for humanitarian issues.[6] In February 2009 he was elected President of the Serbian Olympic Committee for a 4-year term.[7] and re-elected in November 2012,[8] Divac received an honor from the World Sports Humanitarian Hall of Fame.[9], In summer 1986, at 18, right after signing for KK Partizan, Divac debuted for the senior Yugoslavia national basketball team at the 1986 FIBA World Championship in Madrid, on invitation by the head coach Krešimir Ćosić. However, the excellent rookie''s performance was spoiled by the event in the semi-finals against Soviet Union. Forty-five seconds before the end, Yugoslavia had a comfortable lead of 9 points, but Soviets scored two three-pointers within a few seconds and cut the difference to 3 points. Yugoslavia tried to hold the ball for the remaining time, opting to continue the play with throw-ins instead of free throws following fouls, but with only 14 seconds left, Divac committed a double dribble, the Soviets were awarded the ball, and tied the score with another three-pointer. In the overtime, the Soviets easily prevailed against the shocked Yugoslavs, who had to be content with the bronze.[10] The next year, Divac participated in the team that took the gold at the FIBA Junior World Championship (since split into separate under-19 and under-21 events) in Bormio, Italy. That event launched the young generation of Yugoslavian basketballers, also featuring stars like Rađa and Kukoč, regarded as likely the best in history. Before the breakup of Yugoslavia, they would also take the titles at EuroBasket 1989 and the 1990 FIBA World Championship in Argentina,[10] where they were led by Dražen Petrović,[24] as well as the EuroBasket 1991 title, with Aleksandar Đorđević at point guard.[25], Drafted into the NBA in 1989 by the Los Angeles Lakers. He was also one of the first European players to have an impact in the league. Under the mentorship of Kareem Abdul-Jabbar and Magic Johnson, he improved his play and adapted to the American style of the game. Though he spoke no English, he quickly became popular among his teammates and the public for his charm and joviality. In the 1989–90 season, he was selected into the NBA All-Rookie Team.[10] Divac earned a reputation for flopping, or deceiving the officials into calling a foul on the other team by purposely falling to the floor upon contact with an opposing player.[12] Veteran NBA forward P. J. Brown claimed that Divac might have been the best of all time at flopping.[13] Divac freely admitted doing so, adding that he usually did it when he felt like the officials had missed some calls and owed him.[14] Ian Thomsen, a Sports Illustrated columnist, grouped Divac with fellow international players Anderson Varejão and Manu Ginóbili as the players who \"made [flopping] famous\", exaggerating contact on the court in a manner analogous to diving in FIFA games.[15]"
 }';

--> JSON_MODIFY updates JSON text with a new value on a specified path.
SELECT JSON_MODIFY(@json, '$.Bio', 'Vlade Divac is a retired professional NBA player...')


--> JSON_MODIFY may even append elements in an array.
SELECT JSON_MODIFY(@json, 'append $.Teams', 'Charlotte Hornets')



--> Problem: this function will set text
-- "{\"DoB\":\"02/03/1968\",\"Town\":\"Prijepolje\"}"
-- instead of the object {"DoB":"02/03/1968","Town":"Prijepolje"}
SELECT JSON_MODIFY(@json, '$.Born', '{"DoB":"02/03/1968","Town":"Prijepolje"}')


--> Solution: use JSON_QUERY to "cast" JSON text to JSON
--  Input text will not be escaped.
SELECT JSON_MODIFY(@json, '$.Born', JSON_QUERY('{"DoB":"02/03/1968","Town":"Prijepolje"}'))
```

### OPENJSON

In order to get more data at once from a JSON object and treat the contents as a table, you can use `OPENJSON`:


```sql
declare @json nvarchar(max) =
N'{
	"Name": "Vlade",
	"Surname": "Divac",
	"Born": { "DoB":"1968-03-02","Town":"Prijepolje", "Country": "Serbia"},
	"NBA Stat": { "pts":13398, "ppg": 11.8, "rebounds":	9326, "rpg": 8.2, "blocks":	1631, "bpg": 1.4},
	"Teams": ["Los Angeles Lakers","Sacramento Kings","Partizan"],
	"Career": [
		{"team":"Sloga", "period":{"start":1983, "end":1986}},
		{"team":"Partizan", "period":{"start":1986, "end":1989}},
		{"team":"Los Angeles Lakers","gp":540, "gs":450, "period":{"start":1989, "end":1996}},
		{"team":"Charlotte Hornets","gp":145, "gs":121,"period":{"start":1996, "end":1998}},
		{"team":"Sacramento Kings","gp":454, "gs":453,"period":{"start":1998, "end":2004}},
		{"team":"Los Angeles Lakers", "gp":15, "gs":0,"period":{"start":2004, "end":2005}}],
	"Bio":"Vlade Divac (Serbian Cyrillic: Владе Дивац) (born February 3, 1968) is a retired Serbian professional basketball player and is currently the vice president of basketball operations and general manager of the Sacramento Kings.[1]. Divac spent most of his career in the National Basketball Association (NBA). At 7 ft 1 in, he played center and was known for his passing skills. Divac was among the first group of European basketball players to transfer to the NBA in the late 1980s and was named one of the 50 Greatest Euroleague Contributors.[2] Divac is one of seven players in NBA history to record 13,000 points, 9,000 rebounds, 3,000 assists and 1,500 blocked shots, along with Kareem Abdul-Jabbar, Tim Duncan, Shaquille O''Neal, Kevin Garnett, Pau Gasol and Hakeem Olajuwon.[3][n 1] Divac was also the first player born and trained outside the United States to play in over 1,000 games in the NBA. On August 20, 2010, Divac was inducted into the FIBA Hall of Fame in recognition of his play in international competition.[4] Aside from being noticed for his basketball abilities, Divac is also known as a humanitarian, helping children in his native country of Serbia, and in Africa.[5] In October 2008 Divac was appointed a government adviser in Serbia for humanitarian issues.[6] In February 2009 he was elected President of the Serbian Olympic Committee for a 4-year term.[7] and re-elected in November 2012,[8] Divac received an honor from the World Sports Humanitarian Hall of Fame.[9], In summer 1986, at 18, right after signing for KK Partizan, Divac debuted for the senior Yugoslavia national basketball team at the 1986 FIBA World Championship in Madrid, on invitation by the head coach Krešimir Ćosić. However, the excellent rookie''s performance was spoiled by the event in the semi-finals against Soviet Union. Forty-five seconds before the end, Yugoslavia had a comfortable lead of 9 points, but Soviets scored two three-pointers within a few seconds and cut the difference to 3 points. Yugoslavia tried to hold the ball for the remaining time, opting to continue the play with throw-ins instead of free throws following fouls, but with only 14 seconds left, Divac committed a double dribble, the Soviets were awarded the ball, and tied the score with another three-pointer. In the overtime, the Soviets easily prevailed against the shocked Yugoslavs, who had to be content with the bronze.[10] The next year, Divac participated in the team that took the gold at the FIBA Junior World Championship (since split into separate under-19 and under-21 events) in Bormio, Italy. That event launched the young generation of Yugoslavian basketballers, also featuring stars like Rađa and Kukoč, regarded as likely the best in history. Before the breakup of Yugoslavia, they would also take the titles at EuroBasket 1989 and the 1990 FIBA World Championship in Argentina,[10] where they were led by Dražen Petrović,[24] as well as the EuroBasket 1991 title, with Aleksandar Đorđević at point guard.[25], Drafted into the NBA in 1989 by the Los Angeles Lakers. He was also one of the first European players to have an impact in the league. Under the mentorship of Kareem Abdul-Jabbar and Magic Johnson, he improved his play and adapted to the American style of the game. Though he spoke no English, he quickly became popular among his teammates and the public for his charm and joviality. In the 1989–90 season, he was selected into the NBA All-Rookie Team.[10] Divac earned a reputation for flopping, or deceiving the officials into calling a foul on the other team by purposely falling to the floor upon contact with an opposing player.[12] Veteran NBA forward P. J. Brown claimed that Divac might have been the best of all time at flopping.[13] Divac freely admitted doing so, adding that he usually did it when he felt like the officials had missed some calls and owed him.[14] Ian Thomsen, a Sports Illustrated columnist, grouped Divac with fellow international players Anderson Varejão and Manu Ginóbili as the players who \"made [flopping] famous\", exaggerating contact on the court in a manner analogous to diving in FIFA games.[15]"
 }';

 SELECT * 
 FROM OPENJSON(@json);

SELECT *
FROM OPENJSON(@json, '$.Career')
WITH (team nvarchar(50), gp int, gs int)


----> Paths in column definitions enable you to parse nested JSON.
SELECT *
FROM OPENJSON(@json, '$.Career')
			WITH (team nvarchar(50), gp int, gs int,
					StartYear int '$.period.start',
					EndYear int '$.period.end')


--> AS JSON option returns JSON nested object.
SELECT *
FROM OPENJSON(@json, '$.Career')
		WITH (team nvarchar(50), gp int, gs int,
				period nvarchar(max) AS JSON)
```
