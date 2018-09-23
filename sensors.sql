
CREATE TABLE justextreme as SELECT
e.bid,e.tempdiff,e.typed 
from withextreme e
WHERE e.extreme==1


CREATE VIEW extremedata AS SELECT
j.bid,j.tempdiff,j.typed,
b.hvacprod,b.country 
FROM justextreme j LEFT OUTER JOIN building b
ON j.bid=b.bid


CREATE table ctrycount as
SELECT country,count(country) as ccount
FROM extremedata GROUP BY country


CREATE view HOT as SELECT ex.country,avg(ex.tempdiff) as havg
FROM extremedata ex
WHERE ex.typed='WARM' GROUP BY ex.country

CREATE view cold as SELECT ex.country,avg(ex.tempdiff) as cavg
FROM extremedata ex WHERE
ex.typed='COLD' GROUP BY ex.country

CREATE TABLE avgtemps AS SELECT h.country,h.havg,c.cavg
FROM HOT h FULL OUTER JOIN COLD c on h.country=c.country

CREATE table extbid AS 
SELECT bid as ids,count(bid) as bcount
 FROM justextreme GROUP BY bid
