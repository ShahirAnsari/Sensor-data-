CREATE TABLE building(
	bid INT,
	bmgr VARCHAR(3),
	bage INT,
	hvacprod VARCHAR(10),
	country VARCHAR(15))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
LOCATION '/user/cloudera/Project4/building'

LOAD DATA INPATH '/user/cloudera/Project4/building/building.csv'
INTO TABLE building


CREATE TABLE hvac(
	dates VARCHAR(8),
	times VARCHAR(8),
	targtemp INT,
	acttemp INT,
	sys INT,
	sysage INT,
	bid INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
LOCATION '/user/cloudera/Project4/hvac'

LOAD DATA INPATH '/user/cloudera/Project4/hvac/HVAC.csv'
INTO TABLE hvac


create table as ranged as
select *,
(acttemp-targtemp) as tempdiff
from nhvac;

CREATE TABLE if Not EXISTS temptype as SELECT
r.*,
case
	WHEN r.tempdiff>4 THEN 'WARM'
	WHEN r.tempdiff<-4 THEN 'COLD'
	ELSE 'NORMAL' END as typed
from ranged r



CREATE TABLE if Not EXISTS withextreme as SELECT
t.bid,t.dates,t.times,t.sys,t.sysage,t.tempdiff,t.typed,
case
	WHEN t.typed = 'NORMAL' THEN 0
	ELSE 1
	END as extreme
from temptype t
