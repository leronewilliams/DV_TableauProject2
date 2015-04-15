require('RCurl')
require("jsonlite")
require('dplyr')
require('plyr')
require('tidyr')

#rank top_destinations for each uniquecarrier
rank <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="
select uniquecarrier, dest, COUNT(dest) AS TOTAL_RECORDS, rank()
OVER (PARTITION BY uniquecarrier order by COUNT(dest) desc) as DEST_RANK
from FT 
where origin = \\\'JFK\\\' 
GROUP BY uniquecarrier, dest"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank)


last_value <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select distinct dest, distance, dense_rank()
OVER (order by distance DESC) as DEST_RANK 
from FT where origin = \\\'JFK\\\' order by DEST_RANK"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(last_value)



#query works in sql but not in r - CHECK
# max_value - carriers with most delays. Can't do rank and pull total number of records for each 
max_value <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="
SELECT uniquecarrier, MAX(Arrdelay) AS Avg_Arrdelay, AVG(Depdelay) AS Avg_Depdelay 
FROM FT 
WHERE origin = \\\'JFK\\\' 
GROUP BY uniquecarrier "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(max_value)



#2nd highest cancellation for each month
nthval <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="
select l.month, l.dest, l.c_dest, nth_value(l.c_dest, 2)
OVER (PARTITION BY month) secondhighest_cancellation 
from 
( select month, dest, count(dest) AS c_dest 
FROM FT where origin = \\\'JFK\\\' and cancelled = 1  
GROUP BY month, dest order by month, c_dest desc) l
ORDER BY 1"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(nthval)

#cume_dist
cumedist <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select  G.dest,  G.avg_airtime, cume_dist()
OVER (ORDER BY G.avg_airtime ASC) AS PERCENTILE
from ( Select dest, AVG(airtime) AS avg_airtime FROM FT where origin = \\\'JFK\\\' GROUP BY dest) G
order by 2 "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(cumedist)

time_efficiency <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "SELECT dest, uniquecarrier, min_airtime, max_airtime, Diff_airtime, rank() 
OVER (PARTITION BY dest, uniquecarrier order by Diff_airtime desc) as AirTimeDuration_Rank
FROM (SELECT dest, uniquecarrier, 
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime) AS min_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime) AS max_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime) -
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime) AS Diff_airtime 
FROM ( 
SELECT dest, uniquecarrier, airtime FROM FT WHERE origin = \\\'JFK\\\' AND cancelled = 0 )
ORDER BY DEST, uniquecarrier)
WHERE AirTimeDuration_Rank = 1
"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(time_efficiency)




